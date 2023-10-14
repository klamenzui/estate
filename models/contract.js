const Model = require('./db/model');
const Helper = require('../utils/helper');
const t_payment = require('./db/tables/payment');
const t_contract = require('./db/tables/contract');
const t_client = require('./db/tables/client');
const t_estate = require('./db/tables/estate');
const ModelPayment = require('./payment');
const logger = require('../utils/logger')

class Contract extends Model {
    constructor() {
        super();
    }

    debt = async (filter) => {
        /*
        SELECT sum( payment.summe ) AS summ, count( payment.id ) AS total, contract.price
FROM contract
LEFT JOIN `payment` ON ( payment.contract_id = contract.id )
WHERE contract_id = 6
         */
        if (!filter) return null;
        let contract;
        if (filter[`${(t_contract.id.name)}`] && filter[`${t_contract.date_start.name}`] && filter[`${t_contract.price.name}`]) {
            contract = filter;
        }else{
            let res = await this.select(t_contract).setFilter(filter).addFilter({[`${(t_contract.status.name)}`]: 'active'})
                .exec();
            contract = res.res[0];
        }
        try {
            let date_start = new Date(Helper.getDate(contract[`${t_contract.date_start.name}`]));
            logger.info(date_start);
            let monthDiff = Helper.getMonthDifference(date_start, new Date());
            let sum2pay = monthDiff * contract[`${t_contract.price.name}`];
            logger.info('sum2pay:',sum2pay);
            let payed = await new ModelPayment().setFilter({[t_payment.contract_id.name]: contract[`${(t_contract.id.name)}`]})
                .addFilter({[t_payment.period.name]:Helper.formatDate(date_start, 'Y-M-D')}, '>', 'AND')
                .addFilter({[t_payment.period.name]:Helper.formatDate(new Date(), 'Y-M-01')}, '<', 'AND')
                .addFilter({[t_payment.status.name]:'pending'},'=', 'AND')
                .sumBy();
            payed = payed.rows[0];
            payed['total'] = payed.total?payed.total:0;
            let toPay = sum2pay - payed.total;
            logger.info('toPay:', toPay);
            return toPay;
        } catch (e) {
            logger.error(e);
        }

    }

    getCurrent = async (obj) => {
        /*SELECT contract.id, client.first_name, client.last_name, contract.status, contract.period_type, contract.price, DATE_FORMAT( contract.date_end, "%d.%m.%Y" ) AS date_end, DATE_FORMAT( contract.date_start, "%d.%m.%Y" ) AS date_start
        FROM contract
        LEFT JOIN estate ON ( estate.id = contract.estate_id )
        LEFT JOIN client ON ( client.id = contract.client_id )
        WHERE contract.estate_id = '2' && contract.status = 'active'
        ORDER BY contract.date_start DESC
        LIMIT 0 , 30*/
        let e_id = obj?obj[`${(t_contract.estate_id.name)}`]:-1;
        let q = app.locals.knex.select().from(this.table);
        if (typeof (e_id) != 'undefined' && e_id !== -1) {
            q.where(`${(t_contract.estate_id)}`,e_id);
        }
        return q.andWhere('status', '=', 'active');
        //6 	7 	2 	active 	monthly 	3000 	2019-07-15 21:48:44 	0000-00-00 00:00:00
    }

    async close(obj) {
        if (typeof obj !== 'object' || (!obj[t_contract.estate_id.name] && !obj[t_contract._primary_key.name])) {
            logger.info(`${t_contract.estate_id.name} and ${t_contract._primary_key.name} are not set`);
            return;
        }

        const currentObj = await this.getCurrent(obj);
        if (!currentObj || !currentObj.length) return;

        const updatedObj = currentObj[0];
        updatedObj[t_contract.status.name] = 'closed';
        updatedObj[t_contract.date_end.name] = Helper.formatDate(new Date(), 'Y-M-D');

        return this.update(updatedObj);
    }

    get = async (filter) => {
        if(typeof filter !== 'undefined'){
            this.setFilter(filter);
        }
        // id 	client_id 	estate_id 	status 	period_type 	price 	date_start 	date_end
        return this.query(`SELECT ${t_contract.id},
            ${t_contract.estate_id},
            ${t_estate.description.as()},
            ${t_contract.client_id}, 
            ${t_client.description.as()}, 
            ${(t_client.last_name)},
            ${(t_contract.status)}, ${(t_contract.period_type)}, ${(t_contract.price)}, 
            ${(t_contract.date_end.format("%Y-%m-%d"))},
            ${(t_contract.date_start.format("%Y-%m-%d"))}
        FROM ${(t_contract)}
            LEFT JOIN ${(t_estate)} on (${(t_estate.id)} = ${(t_contract.estate_id)})
            LEFT JOIN ${(t_client)} on (${(t_client.id)} = ${(t_contract.client_id)})
        ${(this.where())} ORDER BY ${(t_contract.date_start)} DESC`).catch((e) => {
            logger.error(e);
        });
    }

    set = async (obj) => {
        /*
        UPDATE payment
        INNER JOIN contract
        ON contract.id = payment.contract_id
        SET payment.estate_id = contract.estate_id
        WHERE payment.estate_id = 0;

        SELECT * FROM `payment` WHERE estate_id = 6

        UPDATE payment SET payment.status = 'transferred' WHERE payment.estate_id = 6 AND period <'2023-02-20';
        SELECT * FROM `payment` WHERE estate_id =6 and period <='2022-09-16' and period>='2022-04-10'

        INSERT INTO `estate`.`payment` (`id`, `contract_id`, `estate_id`, `amount`, `period`, `status`, `date`, `comment`) VALUES (NULL, '22', '6', '4000', '2022-08-01 00:00:00', 'transferred', '2022-08-01 00:00:00', 'test')
         */

        let isNew = Helper.isEmpty(obj[this.primary_key]);
        if (isNew) {
            await this.close(obj);
            return await this.add(obj);//.catch(callback);
        } else {
            return await this.update(obj);
        }
    }

}

module.exports = Contract