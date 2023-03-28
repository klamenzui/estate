const Helper = require("../utils/Helper");
const BotModel = require("../models/Bot");
const ChatModel = require("../models/Bot_chat");
//const t_address = require('./db/tables/address');
//const t_bot = require('./db/tables/bot');
const t_bot_chat = require('../models/db/tables/bot_chat');
const TelegramBotAPI = require('node-telegram-bot-api');
const {NlpManager} = require("node-nlp");
const fs = require('fs');


class BotManager {
    bot_chat;
    bot;
    _chats = [];
    _users = [];
    manager;
    nextIntent;
    req;
    correction_step = 0;
    lastReq;
    actions = {};

    constructor(name, callback) {
        this.init(name, callback);
    }

    isUserAllow(user) {
        return this.users.indexOf(user.toLowerCase()) > -1;
    }

    isChatOn(chatId) {
        return this._chats[chatId] && this._chats[chatId].status;
    }

    get users() {
        return this._users;
    }

    set users(value) {
        this._users = value.toLowerCase().split(',');
    }

    setChat(chat) {
        if (typeof this._chats[chat.id] == "undefined") {
            chat[t_bot_chat.code.name] = chat.id;
            this.bot_chat.add(chat).then(res => {
                console.log(res);
                this._chats[chat.id] = chat;
            });
        }
        return this;
    }

    sendMessage = async (chat, res, opt) => {
        let chatId = typeof chat == 'object' ? chat[t_bot_chat.code.name] : chat;
        console.log(res);
        if (this.isChatOn(chatId)) {
            await this.bot.sendMessage(chatId, res, opt);
        }
    }
    onText = async (msg, match) => {
        console.log(msg);
        console.log('msg', msg);
        console.log('match', match);
        const chatId = msg.chat.id;
        this.setChat(msg.chat);
        const messageId = msg.message_id;
        //if(msg.from.username.toLowerCase() == settings.chat_access_username.toLowerCase()){
        let access = this.isUserAllow(msg.from.username ? msg.from.username : msg.from.first_name + msg.from.last_name);
        console.log('access', access);
        if (this.isChatOn(chatId) && access && match && match[1]) {
            /*await this.cmdExec(msg, match[1], res => {
                if(res){
                    this.sendMessage(chatId, res, {reply_to_message_id: messageId});
                }
            })*/
            var estate_id = msg.chat.title.match('#([0-9]+):');
            if (estate_id.length > 1) {
                estate_id = estate_id[1];
                console.log('cmdExec: estate_id = ', estate_id);
                console.log('cmdExec: ', msg.text);
                let response = await this.manager.process('ru', msg.text);
                console.log(response);
                response = await this.onIntent(response);
                console.log(response.answer);
                if (response.answer) {
                    //await msg.reply.text(response.answer);
                    await this.sendMessage(chatId, response.answer);
                    /*console.log(this.manager.nlp.toJSON());
                    fs.writeFile(app.locals.base + 'utils/data.json', JSON.stringify(this.manager.nlp.toJSON()), function (err) {
                        if (err) return console.log(err);
                        console.log('nlp saved');
                    });*/
                }
            }
        }
        //this.bot.sendMessage(chatId, 'ok');

        /*this.bot.onReplyToMessage(chatId, messageId, (result) => {
            console.log('onReplyToMessage',result);
        });*/
        /*this.cmdExec(msg.chat.title, match[1]).then((result) => {
            console.log('it5',result);
            if(result){
                this.bot.sendMessage(chatId, result);
            }
        });*/
        //} else {
        //	bot.sendMessage(chatId, 'access denay');
        //}
    }
    init = async (name, callback) => {
        const dirActions = app.locals.base + 'bot/actions/';
        const dirData = app.locals.base + 'bot/data/';
        let files = fs.readdirSync(dirActions);
        for (let i in files) {
            let file = files[i].toLowerCase().split('.').slice(0, -1).join('.');
            console.log(dirActions + file);
            this.actions[file] = require(dirActions + file);
        }
        console.log(this.actions);
        //https://github.com/axa-group/nlp.js/blob/master/examples/14-ner-corpus/corpus.json
        this.manager = new NlpManager({
            "autoLoad": true,
            "autoSave": true,
            "forceNER": true,
            languages: ['ru']
        });//{ languages: ['ru'], forceNER: true }
        //---------

        //this.manager.addCorpus(app.locals.base + "utils/corpus.json");
        const corpus = require(dirData + "data.json");
        if (corpus.settings) {
            this.manager.fromObj(corpus);
            let objects = {
                "1": [
                    "бойлер",
                    "автомат до бойлера"
                ],
                "2": [
                    "кровать",
                    "диван"
                ],
                "3": [
                    "кран",
                    "кран в кухню",
                    "кран в ванную"
                ]
            }
            const objectKeys = Object.keys(objects);
            for (let i = 0; i < objectKeys.length; i += 1) {
                this.manager.nlp.addNerRuleOptionTexts('ru', 'object', objectKeys[i], objects[objectKeys[i]]);
            }
            //this.manager.load(app.locals.base +"utils/data.json");
        } else {
            this.manager.addCorpus(corpus);
            await this.manager.train();
            //this.manager.save();
            this.manager.save(dirData + "data.json");
        }
        /*
        this.select(t_estate,t_address)
            .andWhere(t_estate.id, '=', 1)
            .orWhere(t_estate.id, '=', 2)
            .exec();
            */
        let model = new BotModel();
        model.get({name: name}).then((results) => {
            try {
                let row = results.rows[0];
                console.log('bot', row);
                this.bot = new TelegramBotAPI(row.token, JSON.parse(row.options));
                this.users = row.useraccess;
                this.bot.onText(new RegExp(row.pattern), this.onText);
                console.log(app.locals.config.ip);

                this.bot_chat = new ChatModel();
                this.bot_chat.table = `${t_bot_chat}`;
                this.bot_chat.get().then(results => {
                    if (results && results.rows) {
                        for (let i in results.rows) {
                            if (typeof this._chats[results.rows[i]] == 'undefined') {
                                this._chats[results.rows[i][t_bot_chat.code.name]] = results.rows[i];
                            }
                        }
                    }
                });
            } catch (e) {
                console.log(e);
            }
            callback(this);
        });
    }


    async onIntent(input) {
        this.req = input;

        //console.log('output.intent:',output.intent);
        // Check if output has to be a logical continuation of the prior conversation's flow.
        // If it is, change the classified intent to the predefined one.
        console.log('output:', JSON.stringify(this.req));
        if (!this.nextIntent && this.correction_step === 1) {
            console.log('----[addDoc]-----');
            console.log('last:', this.lastReq);
            if (this.lastReq && (this.lastReq.optionalUtterance || this.lastReq.utterance)) {
                this.addData(this.lastReq.optionalUtterance || this.lastReq.utterance, this.req.intent);
                this.req.answer = "Спасибо, исправился :)";
            } else {
                console.log('nothing to add');
            }
            this.correction_step = 0;
        } else {
            if (this.nextIntent) {
                this.req.intent = this.nextIntent;
                this.nextIntent = undefined;
            }
            //console.log('output.intent:',output.intent);
            //console.log('output.entities:',output.entities);
            // Check if the user want to book something
            let action = this.req.intent.split('.');
            if (this.actions[action[0]]) {
                try {
                    this.req.answer = this.exec(new this.actions[action[0]](), action[1]);
                } catch (e) {
                    console.log(e);
                }
            } else if (this.req.intent === "None") {
                this.req.answer = "Прости, Я не понял. Можешь перефразировать?";
                this.correction_step = 1;
                this.lastReq = this.req;
            }
            if (this.correction_step === 0) {
                this.lastReq = this.req;
            }
        }
        return this.req;
    }

    /**
     * Translate a natural language string to a Date format
     * @param {String} textDate - the string from which to extract the datetime
     * @param {Boolean} isTime - if set to true, process the string as a time,
     * in which case only the time offset in miliseconds from the beginning of
     * the day will be returned.
     * @returns {Date} - js Date or number. If isTime, returns offset in miliseconds.
     * If not isTime, returns a Date
     */
    static processDate(textDate, isTime = false) {
        let date = Date.create(textDate);

        if (isTime) {
            let dayStartTime = date.clone();

            // Is modified in-place
            dayStartTime.beginningOfDay();
            return date - dayStartTime;
        }
        return date;
    }

    addData(utterance, intent) {
        this.manager.addDocument('ru', utterance, intent);
        // Train also the NLG
        //this.manager.addAnswer('ru', 'greetings.bye', 'Till next time');
        this.manager.train().then(r => {
            this.manager.save(app.locals.base + "data/data.json");
        });
    }

    exec(obj, func) {
        obj.nextIntent = this.nextIntent;
        obj.lastReq = this.lastReq;
        obj.addData = this.addData;
        if (this.req.entities) {
            // Go throught all found entities and add the important ones to instance variables
            for (let i = 0; i < this.req.entities.length; i++) {
                /*{
                  "start": 15,
                  "end": 17,
                  "len": 3,
                  "accuracy": 0.95,
                  "sourceText": "500",
                  "utteranceText": "500",
                  "entity": "number",
                  "resolution": {
                    "strValue": "500",
                    "value": 500,
                    "subtype": "integer"
                  }
                }*/
                let key = this.req.entities[i].entity;
                let val = this.req.entities[i].option;
                switch (key) {
                    case "month":
                    case "date":
                        let date = this.req.entities[i].sourceText;
                        if (this.req.entities[i].entity === 'month') {
                            date = this.req.entities[i].option;
                        }
                        date = this.constructor.processDate(date);
                        val = date;
                        break;
                    case "number":
                        key = 'amount';
                        val = this.req.entities[i].sourceText;
                        break;
                }
                if (obj.hasOwnProperty(key)) {
                    obj[key] = val;
                }
            }
        }
        let res = obj[func]();
        this.nextIntent = obj.nextIntent;
        this.lastReq = obj.lastReq;
        console.log(obj);
        return res;
    }

}

module.exports = BotManager