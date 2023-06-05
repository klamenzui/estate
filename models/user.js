const Model = require('./db/model');
const t_user = require('./db/tables/user');
class User extends Model {
    constructor() {
        super();
    }

    get = async (filter) => {
        return this.select(
            t_user.id,
            t_user.username,
            t_user.email,
            t_user.password,
            t_user.description,
            t_user.img,
            t_user.role_id,
        )
            .setFilter(filter).exec();
    }
}

module.exports = User