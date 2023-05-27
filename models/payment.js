const Model = require('./db/model');
const t_bank = require('./db/tables/bank');
const t_share = require('./db/tables/share');
const t_contract = require('./db/tables/contract');
const t_payment = require('./db/tables/payment');
const t_client = require('./db/tables/client');
const Helper = require('../utils/helper.js');

class Payment extends Model {
    constructor() {
        super();
    }

    sumBy = async (filter) => {
        if(typeof filter !== 'undefined'){
            this.setFilter(filter);
        }
        return this.query(`SELECT sum(${(t_payment.amount)}) total, count(${(t_payment.id)}) count
        FROM ${(t_contract)}
            LEFT JOIN ${(t_payment)} on (${(t_payment.contract_id)} = ${(t_contract.id)})
        ${(this.where())}`);
    }

    sumPeriod = async (filter) => {
        let start_date = typeof filter === 'object' && filter.start_date? filter.start_date: new Date();
        let months = typeof filter === 'object' && filter.months? filter.months:1;
        let select = '';
        let group_by = '';
        let period = Helper.getPeriod(start_date,months);
        this.where(t_payment.period,'>=',period[0])
            .andWhere(t_payment.period,'<',period[1]);
        if(typeof filter === 'object'){
            if(filter.estate){
                select += `${(t_contract.estate_id)},`;
                group_by = `${(t_contract.estate_id)}, `;
            }
            if(filter.estate_id){
                this.andWhere(t_payment.status,'=',filter.estate_id);
            }
            if(filter.status){
                select += `${(t_payment.status)},`;
                group_by += `${(t_payment.status)}, `;
                this.andWhere(t_payment.status,'=',filter.status);
            }

        }
        return this.query(`SELECT ${select} YEAR(${(t_payment.period)}) as year, MONTHNAME(${(t_payment.period)}) month, sum(${(t_payment.amount)}) total, count(${(t_payment.id)}) count
        FROM ${(t_payment)} 
        LEFT JOIN ${(t_contract)} on (${(t_contract.id)} = ${(t_payment.contract_id)})
        ${(this.where())}
        GROUP BY ${group_by} YEAR(${(t_payment.period)}), MONTH(${(t_payment.period)})`);
    }

    get = async (filter) => {
        this.setFilter(filter);
        return this.query(`SELECT 
            ${(t_payment.id)},
            ${(t_payment.amount)},
            ${(t_payment.status)},
            ${(t_payment.period.format("%Y-%m-%d"))},
            ${(t_payment.date.format("%Y-%m-%d"))},
            ${(t_client.first_name)},
            ${(t_contract.id.as())},
            ${(t_contract.estate_id)},
            ${(t_contract.period_type)},
            ${(t_contract.price)}
        FROM ${(t_contract)}
            LEFT JOIN ${(t_payment)} on (${(t_payment.contract_id)} = ${(t_contract.id)})
            LEFT JOIN ${(t_client)} on ( ${(t_client.id)} = ${(t_contract.client_id)} )
        ${(this.where())} ORDER BY ${(t_payment.period)} DESC`);
    }

    withdraw = async (filter) => {
        filter[t_payment.status.name] = 'payed';
        this.setFilter(filter);
        this.andWhere(t_bank.currency,'=', 'hryvnia');
        if(!Helper.isEmpty(filter[t_contract.estate_id.name]) || !Helper.isEmpty(filter[t_payment.contract_id.name])){
            let data  = await this.query(`SELECT 
                ${(t_payment.id)},
                ${(t_payment.amount)},
                ${(t_payment.status)},
                ${(t_contract.id.as())},
                ${(t_contract.estate_id)},
                ${(t_share.user_id)},
                ${(t_share.percentage)},
                ${(t_bank.id.as('card_id'))},
                ${(t_bank.currency)},
                ${(t_bank.amount.as('card_amount'))}
            FROM ${(t_contract)}
                LEFT JOIN ${(t_payment)} on (${(t_payment.contract_id)} = ${(t_contract.id)})
                LEFT JOIN ${(t_client)} on ( ${(t_client.id)} = ${(t_contract.client_id)} )
                LEFT JOIN ${(t_share)} on ( ${(t_share.estate_id)} = ${(t_contract.estate_id)} )
                LEFT JOIN ${(t_bank)} on ( ${(t_bank.user_id)} = ${(t_share.user_id)} )
            ${(this.where())} `);//GROUP BY ${(t_payment.id)}
            console.log(data);
            if(data.rows){
                let is100Pr = 0;
                for(let i in data.rows){
                    is100Pr += data.rows[i][t_share.percentage.name] || 0;
                }
                if(is100Pr === 100) {
                    let payment_id = data.rows[0][t_payment.id.name];
                    let amount_before = data.rows[0][t_payment.amount.name];
                    let amount = data.rows[0][t_payment.amount.name];
                    let before_transaction = [];
                    for(let i in data.rows){
                        let percentage = data.rows[i][t_share.percentage.name] || 0;
                        if(percentage > 0) {
                            percentage = percentage / 100;
                            let card_id = data.rows[i]['card_id'];
                            let card_amount = data.rows[i]['card_amount'];
                            before_transaction.push({
                                [t_bank.id.name]:card_id,
                                [t_bank.amount.name]:card_amount,
                            })
                            if (percentage <= 1 && card_id) {
                                let part = amount_before * percentage;
                                amount -= part;
                                card_amount += part;
                                let obj = {
                                    [t_bank.id.name]:card_id,
                                    [t_bank.amount.name]:card_amount,
                                }
                                //transactions.push(obj);
                                await new Model(t_bank.toString()).up(obj);
                            }
                        }
                    }
                    if(amount !== 0){
                        for(let i in before_transaction){
                            await new Model(t_bank.toString()).up(before_transaction[i]);
                        }
                    } else {
                        await new Model(t_payment.toString()).up({
                            [t_payment.id.name]:payment_id,
                            [t_payment.status.name]: 'withdrawn',
                        });
                    }
                }
            }
        }

    }


}

module.exports = Payment