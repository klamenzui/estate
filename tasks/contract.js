const ContractModel = require('../models/Contract');
const t_contract = require('../models/db/tables/contract');

class Contract {
    constructor() {
    }

    async exec() {
        console.log('---Contract---');
        let contractModel = new ContractModel();
        let res = await contractModel.get({[t_contract.status]: 'active'});
        if (res && res.rows) {
            for (let i in res.rows) {
                let contract = res.rows[i];
                console.log('contract:',contract);
                let toPay = await contractModel.debt(contract);
                //toPay = toPay.rows[0];
                if(toPay > 0){
                    let chat_res = await app.locals.bot.bot_chat.getByTitle(contract[t_contract.estate_id.name]);
                    console.log('chat:', chat_res);
                    if (chat_res && chat_res.rows) {
                        let chat = chat_res.rows[0];
                        if(chat){
                            await app.locals.bot.sendMessage(chat, 'to pay:'+ toPay+' '+ contract.first_name+' '+ contract.last_name);
                        } else {
                            console.log('chat was not found:',contract[t_contract.estate_id.name]);
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

module.exports = new Contract();