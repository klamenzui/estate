const Model = require('./db/model');
const t_estate = require('./db/tables/estate');
const t_address = require('./db/tables/address');
const t_country = require('./db/tables/country');
const t_city = require('./db/tables/city');
const t_state = require('./db/tables/state');
const t_contract = require('./db/tables/contract');
const t_client = require('./db/tables/client');
const t_payment = require('./db/tables/payment');


class Estate extends Model {
    constructor() {
        super();
    }

    getAddress = async (filter) => {
        //t_estate.as('e');
        return this.select(t_address.id,
            t_address.street,
            t_estate.id,
            t_estate.house_number,
            t_estate.apartment_number)
            .setFilter(filter)
            .order(t_address.id).exec();
        /*t_address.as('addr');
        this.query(`SELECT ${(t_address.id)}, 
            ${(t_address.street)},
            ${(t_estate.id.as())},
            ${(t_estate.house_number)},
            ${(t_estate.apartment_number)}
        FROM
            ${(t_estate)}
        LEFT JOIN ${(t_address)} on ( ${(t_address.id)} = ${(t_estate.address_id)} )
            ${(this.where())}
        order by ${(t_address.id)} asc`, callback);
        */
        /*knexPg({ f: 'foo', b: 'bar' })
            .select('foo.*')
            .where('f.name', knexPg.raw('??', ['b.name']))
            .whereIn('something', knexPg('bar').select('id'))
            .toSQL().sql;
        this.db.query(`SELECT addr.id as estate_id, 
                                addr.street as street, a.house_number, a.apartment_number
                            FROM
                                ${(this.table)} AS a
                            LEFT JOIN ${(this.tables.address)} as addr on ( addr.id = a.address_id )
								${(where)}
							order by addr.id asc`, params, callback);*/
    }

    getDetails = async (filter, callback) => {
        return this.setFilter(filter).query(`SELECT ${(t_estate.id.as())}, 
                ${(t_address.street)},
                ${(t_address.longitude)},
                ${(t_address.latitude)},
                ${(t_country.name.as('country'))}, 
                ${(t_state.name.as('state'))}, 
                ${(t_city.name.as('city'))},
                ${(t_estate.house_number)},
                ${(t_estate.apartment_number)},
                ${(t_estate.square)},
                ${(t_estate.photos)},
                ${(t_client.first_name)},
                ${(t_contract.id.as())},
                ${(t_contract.period_type)},
                ${(t_contract.price)},
                ${(t_contract.date_start.format("%Y-%m-%d"))},
                profit.profit_total
            FROM
                ${(t_estate)}
    
            LEFT JOIN ${(t_address)} on ( ${(t_address.id)} = ${(t_estate.address_id)} )
            LEFT JOIN ${(t_country)} on (${(t_country.id)} = ${(t_address.country_id)})
            LEFT JOIN ${(t_city)} on (${(t_city.id)} = ${(t_address.city_id)})
            LEFT JOIN ${(t_state)} on (${(t_state.id)} = ${(t_address.state_id)})
            LEFT JOIN ${(t_contract)} on (${(t_contract.estate_id)} = ${(t_estate.id)} and ${(t_contract.status)} = 'active')
            LEFT JOIN ${(t_client)} on ( ${(t_client.id)} = ${(t_contract.client_id)} )
            LEFT JOIN (
                    select
                        ${(t_contract.estate_id)},
                        sum(${(t_payment.amount)}) profit_total
                    from ${(t_contract)}
                    LEFT JOIN ${(t_payment)} on ( ${(t_contract.id)} = ${(t_payment.contract_id)} )
                group by ${(t_contract.estate_id)}
                ) as profit on ( profit.${(t_contract.estate_id.name)} = ${(t_estate.id)} )
            ${(this.where())}
            group by ${(t_estate.id)}
            order by profit.profit_total desc`, callback);
    }

    /**
     * @description write your own code here.
     */

}

module.exports = Estate