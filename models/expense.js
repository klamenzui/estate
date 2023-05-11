const Model = require("./db/Model");
const Helper = require("../utils/Helper");
const t_expense = require('./db/tables/expense');
const t_accessory = require('./db/tables/accessory');
const t_ref = require('./db/tables/ref_estate_accessory');

class Expense extends Model {
    constructor() {
        super();
    }

    get = async (filter) => {
        this.setFilter(filter);
        //app.locals.knex().select(table_scheme.expense.id.full, table_scheme.expense.summe.full, `DATE_FORMAT(${(table_scheme.expense.date.full)}, '%d.%m.%Y') as ${(table_scheme.expense.date.field)}`)
        //    .join('users', 'users.id', 'posts.user_id')
        //   .where({user_id: id})
        return this.query(`SELECT ${(t_expense.id)}, ${(t_expense.amount)}, ${(t_expense.date.format("%d.%m.%Y"))}, 
            ${(t_expense.description)}, ${(t_expense.estate_id)}, ${(t_expense.type)},
            ${(t_accessory.name)}
            FROM ${(t_expense)}
            left join ${(t_ref)} on( ${(t_ref.id)} = ${(t_expense.ref_estate_accessory_id)} )
            left join ${(t_accessory)} on( ${t_accessory.id} = ${(t_ref.accessory_id)} )
            ${(this.where())}
            order by ${(t_expense.date)} DESC`);
    }


}

module.exports = Expense