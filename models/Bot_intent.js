const Model = require("./db/Model");
const bot_intent = require('./db/tables/bot_intent');
const bot_utterance = require('./db/tables/bot_utterance');
const bot_answer = require('./db/tables/bot_answer');
class Bot_intent extends Model {
  constructor() {
    super();
  }
  get = async (filter) => {
    return this.select(
        bot_intent.id,
        bot_intent.name,
        bot_utterance.id,
        bot_utterance.text,
        bot_answer.id,
        bot_answer.text
    )
        .setFilter(filter)
        .order(bot_intent.id).exec();
  }
}

module.exports = Bot_intent