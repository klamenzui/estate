const Model = require('./db/model');
const t_message = require('./db/tables/message');
const t_user = require('./db/tables/user');
const Helper = require('../utils/helper');
class Message extends Model {
    constructor() {
        super();
    }

    get = async (filter) => {
        return await this.addFilter(filter).orderDESC(t_message.date).query(`SELECT ${t_message.id}, 
            ${t_message.text}, ${t_message.date}, 
            from_u.${t_user.username.name} AS from_user, from_u.${t_user.img.name} AS from_img
            FROM ${t_message}
            LEFT JOIN ${t_user} AS from_u ON ( from_u.${t_user.id.name} = ${t_message.from_user} )
            `);//LIMIT 0 , 5
    }

    getLast = async (num) => {
        //let filter = {}
        return await this.addFilter().orderDESC(t_message.date).query(`SELECT ${t_message.id}, 
            ${t_message.text}, ${t_message.date}, 
            from_u.${t_user.username.name} AS from_user, from_u.${t_user.img.name} AS from_img
            FROM ${t_message}
            LEFT JOIN ${t_user} AS from_u ON ( from_u.${t_user.id.name} = ${t_message.from_user} )
           `);//LIMIT 0 , 5
    }

    set = async (obj) => {
        obj[t_message.from_user.name] = obj['user'][t_user.id.name];
        delete obj['user'];
        //let isNew = Helper.isEmpty(obj[this.primary_key]);
        //return await super.set(obj).catch(e=>console.log(e));
        let isNew = Helper.isEmpty(obj[this.primary_key]);
        if (isNew) {
            return this.add(obj);//.catch(callback);
        } else {
            return this.update(obj);
        }
    }
}

module.exports = Message