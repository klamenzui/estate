const Model = require("./db/Model");
const bot_entity = require('./db/tables/bot_entity');
const bot_entity_option = require('./db/tables/bot_entity_option');

class Bot_entity extends Model {
  constructor() {
    super();
  }
  get = async (filter) => {
    return this.select(
        bot_entity.id,
        bot_entity.name,
        bot_entity_option.id,
        bot_entity_option.text,
    )
        .setFilter(filter)
        .order(bot_entity.id).exec();
  }
}

module.exports = Bot_entity