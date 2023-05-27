const Model = require('./db/model');
const Helper = require('../utils/helper');
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

    set = async (obj) => {
        let isNew = Helper.isEmpty(obj[this.primary_key]);
        if(obj[t_client.first_name.name] && obj[t_client.last_name.name])
            obj[t_client.description.name] = obj[t_client.first_name.name] + ' ' + obj[t_client.last_name.name]
        if (isNew) {
            return this.add(obj);//.catch(callback);
        } else {
            return this.update(obj);
        }
    }


}

module.exports = Client