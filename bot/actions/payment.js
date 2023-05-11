const ModelContract = require('../../models/contract');
const t_contract = require('../../models/db/tables/contract');
const t_payment = require('../../models/db/tables/payment');
const Helper = require('../../utils/helper');
const ModelPayment = require('../../models/payment');

class Payment {
    estate_id;
    date;
    amount;

    main() {
        return this.add();
    }

    async getData() {
        let data = {};
        try {
            let filter = {};
            filter[t_contract.estate_id.name] = this.estate_id;
            filter[t_contract.status.name] = 'active';
            filter[t_contract.period_type.name] = 'monthly';
            let res = await new ModelContract().get(filter);
            console.log(res.rows);
            if (res.rows && res.rows[0]) {
                let contract = res.rows[0];
                console.log(contract);
                if (!this.amount) {
                    this.amount = contract['price'];
                }
                if (!this.date) {
                    this.date = Helper.getDate();
                }
                data[t_payment.contract_id.name] = contract[t_contract._primary_key];
                data[t_payment.amount.name] = this.amount;
                data[t_payment.period.name] = this.date;

            }
        } catch (e) {
            console.log('getData', e);
        }
        return data;
    }

    async add() {
        let msg = '';
        // All the required data to book is present => process the reservation

        let data = this.getData();
        //var rows = await q(`INSERT INTO payment(contract_id, summe, period) VALUES (`+contract[0]['id']+`,`+summe+`,'`+period+`')`);
        //console.log(rows);
        let res;
        try{
            res = await new ModelPayment().add(data);
        }catch (e){
            res = e;
        }
        if(res[0]){
            console.log('add', res);
            msg = 'Сделано, добавил оплату ' + (this.date ? ' за ' + this.date : '') + ', сумма ' + this.amount;
        }else{
            console.log('err', res);
            msg = ('не удалось добавить оплату');
        }
        return msg;
    }

    get() {
        let msg = '';
        // All the required data to book is present => process the reservation
        let data = this.getData();
        let period = data.date.substring(0, 7);
        let filter = {};
        filter[t_payment.contract_id.name] = data[t_payment.contract_id.name];
        this.setFilter(filter);
        new ModelPayment().query(`SELECT sum(${t_payment.amount}) total FROM ${t_payment} 
                                        ${(this.where)} and ${t_payment.period} LIKE '?%'`,[period]).then(res => {
            console.log(res.rows);
            if (res.rows && res.rows[0]) {
                let rows = res.rows[0];
                msg = ('всего за период ' + period + ' оплат на сумму - ' + (rows['total'] == null ? 0 : rows['total']));
            } else {
                msg = ('not found payments');
            }
        });
        console.log(msg);
        return msg;
    }
}

/*
try {
                    switch(input_arr[0]) {
                        case "get payment":
                        case "set payment":
                            this.table = 'contract';
                            let filter = {};
                            filter[t_contract.estate_id.name] = estate_id;
                            filter[t_contract.status.name] = 'active';
                            filter[t_contract.period_type.name] = 'monthly';
                            await this.get(filter).then(res => {
                                console.log(res.rows);
                                if(res.rows && res.rows[0]){
                                    let contract = res.rows[0];
                                    console.log(contract);
                                    var summe = input_arr[2].indexOf('num');
                                    if (summe > -1) {
                                        summe = input_arr[1][summe];
                                    } else {
                                        summe = contract['price'];
                                    }
                                    var period = input_arr[2].indexOf('date');
                                    if (period > -1) {
                                        period = input_arr[1][period];
                                    } else {
                                        period = Helper.getDate();
                                    }
                                    this.table = 'payment';
                                    if(input_arr[0] === "set payment") {
                                        //var rows = await q(`INSERT INTO payment(contract_id, summe, period) VALUES (`+contract[0]['id']+`,`+summe+`,'`+period+`')`);
                                        //console.log(rows);
                                        let data = {};
                                        data[t_payment.contract_id.name] = contract[t_contract._primary_key];
                                        data[t_payment.summe.name] = summe;
                                        data[t_payment.period.name] = period;
                                        this.add(data).then((res)=>{
                                            console.log('add', res);
                                            callback('сделано, я добавил оплату: сумма - ' + summe + ', дата - ' + period + ', id - ' + res[0]);
                                        }).catch(e=>{
                                            console.log('err', e);
                                            callback('не удалось добавить оплату: ' + JSON.stringify(e));
                                        });
                                    } else {
                                        period = period.substring(0,7);
                                        this.table = 'payment';
                                        let filter = {};
                                        filter[t_payment.contract_id.name] = contract[t_contract._primary_key];
                                        this.setFilter(filter);
                                        this.query( `SELECT sum(${t_payment.summe}) total FROM ${t_payment}
                                            ${(this.where)} and ${t_payment.period} LIKE '` + period + `%'`).then(res => {
                                            console.log(res.rows);
                                            if (res.rows &&res.rows[0]) {
                                                let rows = res.rows[0];
                                                callback('всего за период ' + period + ' оплат на сумму - ' + (rows['total'] == null ? 0 : rows['total']));
                                            } else {
                                                callback('not found payments');
                                            }
                                        });
                                    }
                                } else {
                                    callback('contract not found');
                                }
                            });

                            break;
                        case "get expense":
                        case "set expense":
                            break;
                        default:
                            result = 'прошу прощения, я не понял';
                            callback(result);
                    }
                    //res = cmd_val;
                    //res = execSync(cmd_val).toString("utf8");
                }catch(e){
                    //message('out', e);
                    console.log('cmdExec', e);
                    callback(false);
                }
 */

module.exports = Payment;