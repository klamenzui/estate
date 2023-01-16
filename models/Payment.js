const Model = require("./db/Model");
const t_contract = require('./db/tables/contract');
const t_payment = require('./db/tables/payment');
const t_client = require('./db/tables/client');
class Payment extends Model {
    constructor() {
        super();
    }

    sumBy = async (filter) => {
        if(typeof filter !== 'undefined'){
            this.setFilter(filter);
        }
        return this.query(`SELECT sum(${(t_payment.summe)}) total, count(${(t_payment.id)}) count
        FROM ${(t_contract)}
            LEFT JOIN ${(t_payment)} on (${(t_payment.contract_id)} = ${(t_contract.id)})
        ${(this.where())}`);
    }

    get = async (filter) => {
        this.setFilter(filter);
        return this.query(`SELECT 
            ${(t_payment.id)},
            ${(t_payment.summe)},
            ${(t_payment.period.format("%d.%m.%Y"))},
            ${(t_client.first_name)},
            ${(t_contract.id.as())},
            ${(t_contract.estate_id)},
            ${(t_contract.period_type)},
            ${(t_contract.price)},
            ${(t_contract.date_start.format("%d.%m.%Y"))}
        FROM ${(t_contract)}
            LEFT JOIN ${(t_payment)} on (${(t_payment.contract_id)} = ${(t_contract.id)})
            LEFT JOIN ${(t_client)} on ( ${(t_client.id)} = ${(t_contract.client_id)} )
        ${(this.where())} ORDER BY ${(t_payment.period)} DESC`);
    }


}

module.exports = Payment