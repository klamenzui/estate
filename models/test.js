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
const data = require("../bot/data/data_raw.json");
const knex = require('knex')({
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
//entity()
//intent();