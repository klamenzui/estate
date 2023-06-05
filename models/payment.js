const ShareModel = require('./share');
const TransferModel = require('./transfer');
const Model = require('./db/model');
const t_transfer = require('./db/tables/transfer');
const t_card = require('./db/tables/card');
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
        if(!Helper.isEmpty(filter[t_contract.estate_id.name]) || !Helper.isEmpty(filter[t_payment.contract_id.name])){
            let data  = await this.query(`SELECT 
                ${(t_payment.id)},
                ${(t_payment.amount)},
                ${(t_payment.status)},
                ${(t_contract.id.as())},
                ${(t_contract.estate_id)}
            FROM ${(t_contract)}
                LEFT JOIN ${(t_payment)} on (${(t_payment.contract_id)} = ${(t_contract.id)})
                LEFT JOIN ${(t_client)} on (${(t_client.id)} = ${(t_contract.client_id)})
            ${(this.where())} GROUP BY ${(t_payment.id)}`);
            console.log(data);
            if(data.rows){
                let is100Pr = 0;
                let estate_id = data.rows[0][t_payment.estate_id.name];
                let cardShare = await new ShareModel().getWithCard({
                    [t_share.estate_id.name]: estate_id
                });
                console.log(cardShare);
                for(let i in cardShare.rows){
                    is100Pr += cardShare.rows[i][t_share.percentage.name] || 0;
                }
                if(is100Pr === 100) {
                    for(let i in data.rows){
                        let payment_id = data.rows[i][t_payment.id.name];
                        let amount_before = data.rows[i][t_payment.amount.name];
                        let amount = data.rows[i][t_payment.amount.name];
                        let transactions = [];
                        for(let c in cardShare.rows) {
                            let percentage = cardShare.rows[c][t_share.percentage.name] || 0;
                            if (percentage > 0) {
                                percentage = percentage / 100;
                                let card_id = cardShare.rows[c][t_card.id.name];
                                //let card_amount = cardShare.rows[c][t_card.amount.name];
                                if (percentage <= 1 && card_id) {
                                    let part = amount_before * percentage;
                                    amount -= part;
                                    //card_amount += part;
                                    transactions.push({
                                        [t_transfer.from_card.name]: data.rows[i],
                                        [t_transfer.to_card.name]: cardShare.rows[c],
                                        ['amount']: part,
                                        //[t_transfer.description]: part,
                                    });
                                    //await new Model(t_card.toString()).up(obj);
                                }
                            }
                        }
                        if(amount === 0){
                            /*for(let i in transactions){
                                //await new Model(t_card.toString()).up(before_transaction[i]);
                                await new Model(t_card.toString()).up(transactions[i]);
                            }*/
                            await new TransferModel().addTransaction(transactions).commit();
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


}

module.exports = Payment