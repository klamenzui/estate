/*
const Sugar = require("sugar");

Sugar.extend();
Date.addLocale('ru', {});

console.log(Date.getAllLocales());
console.log(Date.create('завтра','ru'));

 */
/*
const Helper = require("../utils/Helper");
const Task = require("./db/Entity");
let t = new Task();
console.log(process.version);
console.log(Object.keys(t));
console.log(Object.getOwnPropertyNames(t));
console.log(Object.getPrototypeOf(t));
console.log(Object.getOwnPropertyNames(Object.getPrototypeOf(t)));
//console.log(Helper.getMethod(t, "get"));
*/
var express = require('express');
app = express();
app.locals.base = '../';
app.locals.config = require('../utils/init');

const Bot_entity = require("./Bot_entity");
const Bot_intent = require("./Bot_intent");
const Model = require("./Utilitymeter");
const t_utilityservice = require("./db/tables/Utilityservice");
const t_scheme = require("./db/tables/Utilitymeter");
const Utilityservice = require("./Utilityservice");
const t_utilityservice_formula = require("./db/tables/Utilityservice_formula");
const vm = require("vm");
/*const knex = require('knex')({
    client: 'mysql',
    connection: {
        'host': 'localhost',
        'port': 3307,
        'user': 'root',
        'password': 'usbw',
        'database': 'estate',
        //timezone: 'gmt+6'  //<-here this line was missing 'utc'
        //paginate_page_size: 10
    }
});

knex.on('query', data => {
    console.log('----------[query]-------------');
    console.log(data);
    console.log('-----------------------');
});

knex.on('query-response', (data, obj, builder) => {
    console.log('----------[query-response]-------------');
    console.log(data, obj, builder);
    console.log('-----------------------');
});

knex.on('query-error', function (err, obj) {
    console.log('----------[query-error]-------------');
    console.log(err, obj);
    console.log('-----------------------');
});

 */
async function intent() {
    const data = require('../bot/data/data_backup.json');

    for (let i in data.data) {
        console.log(data.data[i].intent);
        let res = await knex.raw(`INSERT INTO bot_intent (name)
                                  VALUES (?);`, [data.data[i].intent]);
        let intent_id = res[0].insertId;
        for (let j in data.data[i].utterances) {
            let utterance = data.data[i].utterances[j];
            console.log('utterance', utterance);
            await knex.raw(`INSERT INTO bot_utterance (bot_intent_id,text)
                                  VALUES (?,?);`, [intent_id,utterance]);
        }
        for (let j in data.data[i].answers) {
            let answer = data.data[i].answers[j].answer ? data.data[i].answers[j].answer : data.data[i].answers[j];
            console.log('answer', answer);
            await knex.raw(`INSERT INTO bot_answer (bot_intent_id,text)
                                  VALUES (?,?);`, [intent_id,answer]);
        }
    }

}
async function entity() {
    const data = require('../bot/data/data_backup.json');

    for (let ent in data.entities) {
        for (let opt in data.entities[ent].options) {
            console.log(ent,opt);
            let res = await knex.raw(`INSERT INTO bot_entity (name)
                                  VALUES (?);`, [ent+'.'+opt]);
            let ent_id = res[0].insertId;
            for (let i in data.entities[ent].options[opt]) {
                let opt_text = data.entities[ent].options[opt][i];
                console.log(opt_text);
                await knex.raw(`INSERT INTO bot_entity_option (bot_entity_id,text)
                                  VALUES (?,?);`, [ent_id,opt_text]);
            }
        }
    }

}

async function init() {
    let bot_data = {
        name: "Corpus",
        locale: "ru-Ru",
        data:[],
        entities:{}
    };
    let intent_rows = await new Bot_intent().get();
    intent_rows = intent_rows.rows;
    let intents = {};
    for (let i in intent_rows) {
        let row = intent_rows[i];
        if(!intents[row.name]){
            intents[row.name] = {
                intent: row.name
            }
        }
        if(row.text){
            if(!intents[row.name].utterances) intents[row.name]['utterances'] = [];
            if(intents[row.name].utterances.indexOf(row.text) === -1)
                intents[row.name].utterances.push(row.text);
        }
        if(row.bot_answer_text){
            if(!intents[row.name].answers) intents[row.name]['answers'] = [];
            if(intents[row.name].answers.indexOf(row.bot_answer_text) === -1)
                intents[row.name].answers.push(row.bot_answer_text);
        }
    }
    bot_data.data = Object.values(intents);
    let entity_rows = await new Bot_entity().get();
    entity_rows = entity_rows.rows;
    let entities = {};
    for (let i in entity_rows) {
        let row = entity_rows[i];
        let entity_option = row.name.split('.');
        /*
{
  "id": 1,
  "name": "how.name",
  "bot_entity_option_id": 1,
  "text": "твое имя"
}
         */
        if(!entities[entity_option[0]]){
            entities[entity_option[0]] = {
                "options": {
                }
            }
        }
        let options = [];
        if(entity_option[0] === 'object'){
            let res = await app.locals.knex.raw(`SELECT *
                                                 FROM ${entity_option[1]} LIMIT 0 , 30;`);
            for(let r in res[0]){
                options.push(res[0][r].name);
            }

        } else{
            if(entities[entity_option[0]]['options'][entity_option[1]]){
                options = entities[entity_option[0]]['options'][entity_option[1]];
            }
            options.push(row.text);
        }
        entities[entity_option[0]]['options'][entity_option[1]] = options;
    }
    bot_data.entities=entities;
    console.log(bot_data);
}
app.locals.config.loadScheme().then(r => {
    // const BotManager = require('./bot/BotManager');
    // const TaskManager = require('./models/TaskManager');
    // app.locals.bot = new BotManager('KrHome', (res)=>{
    //     console.log(res);
    // });
    // console.log('Start task manager');
    // app.locals.taskManager = new TaskManager();

    // const um=require('./tasks/Utilitymeter');
    // um.exec();

    //init();

    exec().then(r => console.log(r));
});
//entity()
//intent();
async function exec() {
    let res = await app.locals.knex.raw(`SELECT * FROM utilityservice_formula ;`);
    let data = await app.locals.knex.raw(`SELECT * FROM utilitymeter WHERE ?? = ? and ?? = ? order by ??;`,['estate_id','5', 'group', 'electricity', 'index']);
    data = data[0];
    if (res && res[0]) {
        for (let i in res[0]) {
            let row = res[0][i];
            console.log('Utilitymeter:',row);
            let formula = row[t_utilityservice_formula.formula.name];
            if(formula){
                console.log(formula);
                let context = {
                    'data':data,
                    'sum': 0
                };
                vm.createContext(context);
                vm.runInContext(formula, context);
                console.log(context.sum, context);
            }

        }
    }
}