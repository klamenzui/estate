const ContractModel = require('../models/contract');
const PaymentModel = require('../models/payment');
const t_contract = require('../models/db/tables/contract');
const t_payment = require('../models/db/tables/payment');

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
                console.log('contract:', contract);
                await new PaymentModel().createUntilNow({
                    [t_payment.contract_id.name]: contract[t_contract.id.name]
                });
                let toPay = await contractModel.debt(contract);
                //toPay = toPay.rows[0];
                if (toPay > 0 && app.locals.bot.bot_chat) {
                    try {
                        let chat_res = await app.locals.bot.bot_chat.getByTitle(contract[t_contract.estate_id.name]);
                        console.log('chat:', chat_res);
                        if (chat_res && chat_res.rows) {
                            let chat = chat_res.rows[0];
                            if (chat) {
                                await app.locals.bot.sendMessage(chat, 'to pay:' + toPay + ' ' + contract.first_name + ' ' + contract.last_name);
                            } else {
                                console.log('chat was not found:', contract[t_contract.estate_id.name]);
                            }
                        }
                    } catch (e) {
                        console.log(e);
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