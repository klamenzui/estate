const Model = require("./db/Model");
const t_utilitymeter = require('./db/tables/Utilitymeter');
const t_utilityservice = require('./db/tables/Utilityservice');
const t_utilityservice_formula = require('./db/tables/Utilityservice_formula');
const t_utilityservice_invoice = require('./db/tables/Utilityservice_invoice');
const UtilityserviceModel = require("./Utilityservice");
const Utilityservice_invoiceModule = require("./Utilityservice_invoice");
const vm = require("vm");
class Utilitymeter extends Model {
    constructor() {
        super();
    }
    get = async (filter) => {
        return this.select(
            t_utilitymeter.id,
            t_utilitymeter.code,
            t_utilitymeter.description,
            t_utilitymeter.meter_before,
            t_utilitymeter.meter_current,
            t_utilitymeter.price,
            t_utilitymeter.estate_id,
            t_utilitymeter.date,
            t_utilitymeter.utilityservice_id,
            t_utilityservice.group,
            t_utilityservice.name,
            t_utilityservice.unit,
            //t_utilityservice.tariff_url,
            //t_utilityservice.tariff_selector,
        )
            .setFilter(filter)
            .orderASC(t_utilitymeter.index.name).exec();
    }
    updateCurrent = async (data) => {
        let filter = {};
        filter[t_utilitymeter._primary_key] = data[t_utilitymeter._primary_key];
        let utilitymeter = await this.get(filter);
        let row = utilitymeter.rows[0];
        data[t_utilitymeter.meter_before.name]=row[t_utilitymeter.meter_current.name];
        let utilityservice = await new UtilityserviceModel().getFormula({
            [t_utilityservice.group.name]:row[t_utilityservice.group.name]
        });
        let res = await this.up(data);
        let invoice = {};
        let amount = await this.calcByRow(utilityservice, await this.get({
            [t_utilitymeter.estate_id.name]:row[t_utilitymeter.estate_id.name],
            [t_utilityservice.group.name]:row[t_utilityservice.group.name]
        }));
        invoice[t_utilityservice_invoice.amount.name]=amount[row[t_utilityservice.group.name]];
        invoice[t_utilityservice_invoice.estate_id.name]=row[t_utilitymeter.estate_id.name];
        invoice[t_utilityservice_invoice.group.name]=row[t_utilityservice.group.name];
        await new Utilityservice_invoiceModule().create(invoice);
        return res;
    }

    calc = async (filter) => {
        return this.calcByRow(await new UtilityserviceModel().getFormula(),await this.get(filter));
    }

    calcByRow = async (utilityservice, utilitymeter) => {
        let res = {};
        if (utilityservice && utilityservice.rows) {
            for (let i in utilityservice.rows) {
                let service = utilityservice.rows[i];
                let formula = service[t_utilityservice_formula.formula.name];
                let data = utilitymeter.rows.filter(function (el) {
                    return el[t_utilityservice.group.name] === service[t_utilityservice_formula.group.name];
                });
                console.log(service[t_utilityservice_formula.group.name], data);
                if (formula) {
                    console.log(formula);
                    let context = {
                        'data': data,
                        'sum': 0
                    };
                    vm.createContext(context);
                    vm.runInContext(formula, context);
                    res[service[t_utilityservice_formula.group.name]] = context.sum;
                    console.log(context.sum, context);
                }

            }
        }
        console.log(res);
        return res;
    }
}

module.exports = Utilitymeter