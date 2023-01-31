const Helper = require("../utils/Helper");
const Model = require("./db/Model");
const ChatModel = require("./Bot_chat");
const t_address = require('./db/tables/address');
const t_estate = require('./db/tables/estate');
const t_bot = require('./db/tables/bot');
const t_bot_chat = require('./db/tables/bot_chat');
const TelegramBotAPI = require ( 'node-telegram-bot-api');
const Sugar = require("sugar");
const {NlpManager} = require("node-nlp");
const fs = require('fs');

// Extend the built-in Date to add a few methods from Sugar's library
const Sugar = require("sugar");
Sugar.Date.setLocale('ru').extend();
// Imitate a system with a dynamic time slots for doctors


class Bot extends Model {
    bot_chat;
    name;
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
        super();
        this.name = name;
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
        if(typeof this._chats[chat.id] == "undefined"){
            chat[t_bot_chat.code.name] = chat.id;
            this.bot_chat.add(chat).then(res=>{
                console.log(res);
                this._chats[chat.id] = chat;
            });
        }
        return this;
    }

    sendMessage = async (chat, res, opt) => {
        let chatId = typeof chat == 'object' ? chat[t_bot_chat.code.name]: chat;
        console.log(res);
        if(this.isChatOn(chatId)){
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
        let access = this.isUserAllow(msg.from.username?msg.from.username:msg.from.first_name+msg.from.last_name);
            console.log('access', access);
            if(this.isChatOn(chatId) && access && match && match[1]) {
                /*await this.cmdExec(msg, match[1], res => {
                    if(res){
                        this.sendMessage(chatId, res, {reply_to_message_id: messageId});
                    }
                })*/
                var estate_id = msg.chat.title.match('#([0-9]+):');
                if(estate_id.length > 1) {
                    estate_id = estate_id[1];
                    console.log('cmdExec: estate_id=', estate_id);
                    console.log('cmdExec:', cmd);
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
     init = async(name, callback) => {
         const directory = app.locals.base + 'models/db/tables/';
         let files = fs.readdirSync(directory);
         for (let i in files) {
             this.actions[files[i].toLowerCase().substring(0, files[i].indexOf('.'))] = require("./" + me.folder + "/" + files[i]);
         }
        this.manager = new NlpManager({
            "autoLoad": true,
            "autoSave": true,
            "forceNER": true,
            languages: ['ru']
        });//{ languages: ['ru'], forceNER: true }
        //---------

        //this.manager.addCorpus(app.locals.base + "utils/corpus.json");
        //this.manager.addCorpus(app.locals.base + "utils/corpus.json");
        //const corpus = require(app.locals.base +"utils/data.json");
        //console.log(app.locals.base + "utils/data.json");
        //await this.manager.train(corpus);
        //await this.manager.train();
         //this.manager.nlp.fromJSON(corpus);
        //this.manager.save();

        //---------
        this.manager.load(app.locals.base +"utils/data.json");
        /*
        this.select(t_estate,t_address)
            .andWhere(t_estate.id, '=', 1)
            .orWhere(t_estate.id, '=', 2)
            .exec();
            */
        this.get({name: name}).then((results) => {
            try {
                let row = results.rows[0];
                console.log('bot', row);
                this.bot = new TelegramBotAPI(row.token, JSON.parse(row.options));
                this.users = row.useraccess;
                this.bot.onText(new RegExp(row.pattern), this.onText);
                console.log(app.locals.config.ip);

                this.bot_chat = new ChatModel();
                this.bot_chat.table = `${t_bot_chat}`;
                this.bot_chat.get().then(results=>{
                    if(results && results.rows){
                        for(let i in results.rows){
                            if(typeof this._chats[results.rows[i]]=='undefined'){
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
        console.log('output:',JSON.stringify(this.req));
        if(!this.nextIntent && this.correction_step === 1){
            console.log('----[addDoc]-----');
            console.log('last:',this.lastReq);
            if(this.lastReq && (this.lastReq.optionalUtterance || this.lastReq.utterance)){
                this.addData( this.lastReq.optionalUtterance || this.lastReq.utterance, this.req.intent);
                this.req.answer = "Спасибо, исправился :)";
            }else{
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
            let action = this.req.intent.split('.').join('_');
            const Model = require("./bot/" + action);
            if (this[action]) {
                try {
                    this.req.answer = this.exec(action);
                } catch(e){
                    console.log(e);
                }
            } else if (this.req.intent === "None") {
                this.req.answer = "Прости, Я не понял. Можешь перефразировать?";
                this.correction_step = 1;
                this.lastReq = this.req;
            }
            if(this.correction_step === 0){
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
        this.manager.train().then(r=>{
            this.manager.save(app.locals.base +"utils/data.json");
        });
    }

    exec(intent) {
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
                switch (this.req.entities[i].entity) {
                    case "how":
                        this['_'+intent]['how'] = this.req.entities[i].option;
                        break;
                    case "cmd":
                        this['_'+intent]['cmd'] = this.req.entities[i].option;
                        break;
                    case "object":
                        this['_'+intent]['object'] = this.req.entities[i].option;
                        break;
                    case "month":case "date":
                        let date = this.req.entities[i].sourceText;
                        if(this.req.entities[i].entity === 'month'){
                            date = this.req.entities[i].option;
                        }
                        date = this.constructor.processDate(date);
                        this['_'+intent]['date'] = date;
                        break;
                    case "number":
                        this['_'+intent]['price'] = this.req.entities[i].sourceText;
                        break;
                    /*case "datetime":
                      let reservationDatetime = output.entities[i].sourceText;
                      reservationDatetime = this.constructor.processDate(reservationDatetime);
                      this.datetime = reservationDatetime;
                      break;
                    case "time":
                      let reservationTime = output.entities[i].sourceText;
                      reservationTime = this.constructor.processDate(reservationTime, true);
                      this.time = reservationTime;
                      break;*/
                }
            }
        }
        console.log(this['_'+intent]);
        return this[intent]();
    }

}

module.exports = Bot