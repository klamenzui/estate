const Helper = require('../utils/Helper');
const Model = require('../models/Utilitymeter');
const t_scheme = require('../models/db/tables/Utilitymeter');
const t_utilityservice = require('../models/db/tables/Utilityservice');
const SiteParser = require('../models/SiteParser')
class Utilitymeter {
    constructor() {
    }

    async exec() {
        console.log('---Utilitymeter---');
        let model = new Model();
        let res = await model.get();
        if (res && res.rows) {
            for (let i in res.rows) {
                let meter = res.rows[i];
                console.log('Utilitymeter:',meter);
                if(!Helper.isEmpty(meter[t_utilityservice.tariff_url.name])&&!Helper.isEmpty(meter[t_utilityservice.tariff_selector.name])){
                    let id = meter[t_scheme._primary_key];
                    let url = meter[t_utilityservice.tariff_url.name];
                    let selector = meter[t_utilityservice.tariff_selector.name].split("\n");
                    console.log('tariff_url:',url);
                    console.log('tariff_selector:',selector);
                    let sp = new SiteParser();
                    sp.parse(url,selector,function (res) {
                        res=Helper.toFloat(res);
                        if(res){
                            let row = {};
                            row[t_scheme._primary_key]=id;
                            row[t_scheme.price.name]=res;
                            console.log(row);
                            console.log(meter);
                            try {
                                model.update(row).then(result => console.log("Result:", result))
                                    .catch(e => console.log("err:", e));
                            }catch (e) {
                                console.log(e);
                            }
                        }


                    });
                    let eid = meter[t_scheme.estate_id.name];
                    let chat = await app.locals.bot.bot_chat.getByTitle(eid);
                    console.log('chat:', chat);
                    let monthDiff = Helper.getMonthDifference(new Date(meter[t_scheme.date.name]), new Date());
                    console.log('monthDiff:', monthDiff);
                    if (chat && chat.rows) {
                        chat = chat.rows[0];
                        if(chat){
                            if(monthDiff > 0){
                                await app.locals.bot.sendMessage(chat, "Пожалуйста, отправте показания счетчика указав также его номер("+id+"). Пример:\nпоказания счетчика "+id+"=123456");
                            }
                        } else {
                            console.log('chat was not found:',eid);
                        }
                    }
                }

            }
        }
        /*
        new Contract().debt(-1,(results) => {
            console.log(results);
        });*/
    }
}
module.exports = new Utilitymeter();