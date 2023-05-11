const Model = require("./db/Model");
const Helper = require('../utils/Helper');
const t_client = require('./db/tables/client');

class Client extends Model {
    constructor() {
        super();
    }

    get = async (filter) => {
        this.setFilter(filter);
        // id 	client_id 	estate_id 	status 	period_type 	price 	date_start 	date_end
        return this.query(`SELECT ${(t_client.id)},${(t_client.first_name)}, ${(t_client.last_name)}
        FROM ${(t_client)}
        ${(this.where())} ORDER BY ${(t_client.id)} DESC`);
    }


}

module.exports = Client