const Model = require("./db/Model");
const Helper = require('../utils/Helper');

const t_bot_chat = require('./db/tables/bot_chat');
class Bot_chat extends Model {
    constructor() {
        super();
    }

    getByTitle = async (e_id, callback) => {
        return await this.select(t_bot_chat).where(t_bot_chat.title.name,'LIKE','#'+e_id+':%').exec(callback);
    }


}

module.exports = Bot_chat