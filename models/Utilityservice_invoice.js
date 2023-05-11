const Model = require("./db/Model");
const Helper = require("../utils/Helper.js");
const t_utilityservice_invoice = require('./db/tables/utilityservice_invoice');

class Utilityservice_invoice extends Model {
    constructor() {
        super();
    }

    create = async (invoice) => {
        let start_date = invoice && invoice[t_utilityservice_invoice.period.name]? invoice[t_utilityservice_invoice.period.name]:null;
        invoice[t_utilityservice_invoice.status.name]='pending';
        let filter = {
            [t_utilityservice_invoice.group.name]:invoice[t_utilityservice_invoice.group.name],
            [t_utilityservice_invoice.estate_id.name]:invoice[t_utilityservice_invoice.estate_id.name],
        }
        let end_date = '';
        if(!start_date){
            start_date = new Date();
        }
        start_date = Helper.formatDate(start_date,'Y-M-01');
        end_date = Helper.formatDate(new Date(start_date).addMonths(1),'Y-M-01');

        let res = await this.select(
            t_utilityservice_invoice.id,
            t_utilityservice_invoice.amount,
            t_utilityservice_invoice.status,
            t_utilityservice_invoice.period,
            t_utilityservice_invoice.date,
            t_utilityservice_invoice.attachment_file
        ).setFilter(filter).andWhere(t_utilityservice_invoice.period, '>=',start_date)
            .andWhere(t_utilityservice_invoice.period, '<',end_date).exec();
        console.log(res);
        if(res.rows && res.rows[0]){
            // not update if already payed
            if(res.rows[0][t_utilityservice_invoice.status.name]==='pending'){
                res.rows[0][t_utilityservice_invoice.amount.name] = invoice[t_utilityservice_invoice.amount.name];
                await this.up(res.rows[0]);
            } else {
                console.error('Invoice is already payed!')
            }
        } else {
            console.log(await this.add(invoice));
        }
    }
}

module.exports = Utilityservice_invoice