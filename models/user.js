const Model = require('./db/model');
const t_user = require('./db/tables/user');
class User extends Model {
    constructor() {
        super();
    }
}

module.exports = User