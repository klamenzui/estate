const Model = require('./db/model');
class Task extends Model {
    constructor() {
        super();
    }
/*
    get = async (filter, callback) => {
        this.select(t_task).setFilter(filter).orderDESC(t_task.id).exec(callback);
        // id 	client_id 	estate_id 	status 	period_type 	price 	date_start 	date_end
        /*this.query(`SELECT *
        FROM ${(t_task)}
        ${(this.where())} ORDER BY ${(t_task.id)} DESC`, callback);
        *
    }
    */


}

module.exports = Task