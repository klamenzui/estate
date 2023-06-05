const Model = require('./db/model');
const t_bank = require('./db/tables/card');
const t_share = require('./db/tables/share');
class Share extends Model {
    constructor() {
        super();
    }

    getWithCard = async (filter, callback) => {
        return this.select(
            t_share.estate_id,
            t_share.percentage,
            t_bank.id,
            t_bank.user_id,
            t_bank.amount,
            t_bank.currency,
        ).setFilter(filter).andWhere(t_bank.currency,'=', 'hryvnia')
            .exec(callback);
    }
}

module.exports = Share