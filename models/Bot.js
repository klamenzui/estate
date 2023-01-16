const Helper = require("../utils/Helper");
const Model = require("./db/Model");
const ChatModel = require("./Bot_chat");
const t_address = require('./db/tables/address');
const t_estate = require('./db/tables/estate');
const t_bot = require('./db/tables/bot');
const t_bot_chat = require('./db/tables/bot_chat');
const TelegramBotAPI = require ( 'node-telegram-bot-api');
class Bot extends Model {
    bot_chat;
    name;
    bot;
    _chats = [];
    _users = [];
    cmd_arr = [
        ['set payment', 'set p'],
        ['set expense', 'set e'],
        ['get payment', 'get p'],
        ['get expense', 'get e'],
    ];

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
        await this.bot.sendMessage(chatId, res, opt);
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
                await this.cmdExec(msg, match[1], res => {
                    if(res){
                        this.sendMessage(chatId, res, {reply_to_message_id: messageId});
                    }
                })

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
    init = (name, callback) => {

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

    async cmdExec(msg, cmd, callback){
        //'#1: Пацаева 10-87'
        var estate_id = msg.chat.title.match('#([0-9]+):');
        if(estate_id.length > 1) {
            estate_id = estate_id[1];
            console.log('cmdExec: estate_id=',estate_id);
            console.log('cmdExec:', cmd);
            let words = msg.text.split(/\s+/);
            console.log(words);
            if(words.length > 1) {
                /*this.table = 'estate';
                await this.get({id: estate_id}, res => {
                    console.log(res.rows);
                    callback(JSON.stringify(res.rows));
                });
            } else {*/

                //let t_estate = require('./db/tables/estate');
                let t_contract = require('./db/tables/contract');
                let t_payment = require('./db/tables/payment');
                var input_arr = this.cmdSimilarity(cmd.trim());
                console.log(input_arr);
                var result = input_arr[0] + '; ' + input_arr[1].join(' ')+ '; ' + input_arr[2].join(' ');
                try {
                    switch(input_arr[0]) {
                        case "get payment":
                        case "set payment":
                            this.table = 'contract';
                            let filter = {};
                            filter[t_contract.estate_id.name] = estate_id;
                            filter[t_contract.status.name] = 'active';
                            filter[t_contract.period_type.name] = 'monthly';
                            await this.get(filter,res => {
                                console.log(res.rows);
                                if(res.rows && res.rows[0]){
                                    let contract = res.rows[0];
                                    console.log(contract);
                                    var summe = input_arr[2].indexOf('num');
                                    if (summe > -1) {
                                        summe = input_arr[1][summe];
                                    } else {
                                        summe = contract['price'];
                                    }
                                    var period = input_arr[2].indexOf('date');
                                    if (period > -1) {
                                        period = input_arr[1][period];
                                    } else {
                                        period = Helper.getDate();
                                    }
                                    this.table = 'payment';
                                    if(input_arr[0] == "set payment") {
                                        //var rows = await q(`INSERT INTO payment(contract_id, summe, period) VALUES (`+contract[0]['id']+`,`+summe+`,'`+period+`')`);
                                        //console.log(rows);
                                        let data = {};
                                        data[t_payment.contract_id.name] = contract[t_contract._primary_key];
                                        data[t_payment.summe.name] = summe;
                                        data[t_payment.period.name] = period;
                                        this.add(data, (res)=>{
                                            console.log('add', res);
                                            callback('сделано, я добавил оплату: сумма - ' + summe + ', дата - ' + period);
                                        });
                                    } else {
                                        period = period.substring(0,7);
                                        this.table = 'payment';
                                        let filter = {};
                                        filter[t_payment.contract_id.name] = contract[t_contract._primary_key];
                                        this.setFilter(filter);
                                        this.query( `SELECT sum(${t_payment.summe}) total FROM ${t_payment} 
                                            ${(this.where)} and ${t_payment.period} LIKE '` + period + `%'`, res => {
                                            console.log(res.rows);
                                            if (res.rows &&res.rows[0]) {
                                                let rows = res.rows[0];
                                                callback('всего за период ' + period + ' оплат на сумму - ' + (rows['total'] == null ? 0 : rows['total']));
                                            } else {
                                                callback('not found payments');
                                            }
                                        });
                                    }
                                } else {
                                    callback('contract not found');
                                }
                            });

                            break;
                        case "get expense":
                        case "set expense":
                            break;
                        default:
                            result = 'прошу прощения, я не понял';
                            callback(result);
                    }
                    //res = cmd_val;
                    //res = execSync(cmd_val).toString("utf8");
                }catch(e){
                    //message('out', e);
                    console.log('cmdExec', e);
                    callback(false);
                }
            }
        }
    }

    cmdSimilarity(str) {
        var words_arr = this.findParams(str);
        console.log(words_arr);

        var similarity_max = 0;
        var similarity_index = -1;
        try {
            for(var i in this.cmd_arr) {
                for(var j in this.cmd_arr[i]) {
                    var similarity_sum = 0;
                    var words = this.cmd_arr[i][j].split(' ');
                    for(var wa in words_arr[0]) {
                        similarity_sum += this.wordsSimilarity(words, words_arr[0][wa]);
                        //console.log(similarity_sum, similarity_arr)
                    }
                    console.log(similarity_index, similarity_max, similarity_sum)
                    if(similarity_max < similarity_sum){
                        similarity_max = similarity_sum;
                        similarity_index = i;
                    }
                }
            }
        } catch (e) {
            console.log('cmdSimilarity',e);
        }
        console.log(similarity_index, similarity_max, this.cmd_arr[similarity_index]);
        return [this.cmd_arr[similarity_index][0], words_arr[1], words_arr[2]]
    }

    findParams(str) {
        console.log(str);
        var words_arr = str.toLocaleLowerCase().split(/[ ]+/);
        console.log(words_arr);
        var words = [];
        var params = [];
        var ptypes = [];
        var similarity_max = 0;
        var similarity_index = -1;
        try {
            for(var i in words_arr) {
                var similarity_cur = this.wordsSimilarity(Helper.month_arr, words_arr[i], true);
                var date = Helper.getDate(words_arr[i]);
                var num = Helper.toNum(words_arr[i]);
                console.log(similarity_cur, num);
                if(similarity_cur[1] > 0.5) {
                    params.push(Helper.getDate(Helper.month_arr[similarity_cur[0]], true));
                    ptypes.push('date');
                    //words.push('%param%');
                } else if(date != null) {
                    params.push(date);
                    ptypes.push('date');
                    //words.push('%param%');
                } else if(num != null) {
                    params.push(words_arr[i]);
                    ptypes.push('num');
                    //words.push('%param%');
                } else {
                    words.push(words_arr[i]);
                }
            }
        } catch (e) {
            console.log('findParams',e);
        }
        console.log(similarity_index, similarity_max, this.cmd_arr[similarity_index]);
        return [words, params, ptypes]
    }

    wordsSimilarity(words_arr, str, returnIndex) {
        var similarity_res = [-1, 0];
        var words = str.split(' ');
        try {
            for(var wa in words_arr) {
                var similarity_arr = [];
                for(var w in words) {
                    similarity_arr.push(this.similarity(words_arr[wa], words[w]));
                }
                var similarity_sum = Math.max(...similarity_arr);
                if(similarity_res[1] < similarity_sum){
                    similarity_res[0] = wa;
                    similarity_res[1] = similarity_sum;
                }
            }
        } catch (e) {
            console.log('wordsSimilarity',e);
        }
        return returnIndex? similarity_res: similarity_res[1];
    }

    similarity(s1, s2) {
        var longer = s1;
        var shorter = s2;
        if (s1.length < s2.length) {
            longer = s2;
            shorter = s1;
        }
        var longerLength = longer.length;
        if (longerLength == 0) {
            return 1.0;
        }
        return (longerLength - this.editDistance(longer, shorter)) / parseFloat(longerLength);
    }

    editDistance(s1, s2) {
        s1 = s1.toLowerCase();
        s2 = s2.toLowerCase();

        var costs = new Array();
        for (var i = 0; i <= s1.length; i++) {
            var lastValue = i;
            for (var j = 0; j <= s2.length; j++) {
                if (i == 0)
                    costs[j] = j;
                else {
                    if (j > 0) {
                        var newValue = costs[j - 1];
                        if (s1.charAt(i - 1) != s2.charAt(j - 1))
                            newValue = Math.min(Math.min(newValue, lastValue), costs[j]) + 1;
                        costs[j - 1] = lastValue;
                        lastValue = newValue;
                    }
                }
            }
            if (i > 0)
                costs[s2.length] = lastValue;
        }
        return costs[s2.length];
    }

}

module.exports = Bot