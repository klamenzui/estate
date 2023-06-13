const Model = require('./db/model');
const t_alert = require('./db/tables/alert');
const t_payment = require('./db/tables/payment');

class Alert extends Model {
    constructor() {
        super();
    }

    create = async (parent, row) => {
        let obj = {};
        obj[t_alert.type.name] = ''+parent.constructor.name.toLowerCase();
        switch (obj[t_alert.type.name]) {
            case 'payment':
                obj[t_alert.text.name] = 'Pending payment ('+row[t_payment.contract_id.name]+'):' + row[t_payment.amount.name]
                break;
        }
        return await this.set(obj);
    }
}

module.exports = Alert