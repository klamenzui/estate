const Model = require("./db/Model");
const t_utilityservice_formula = require('./db/tables/Utilityservice_formula');
class Utilityservice extends Model {
    constructor() {
        super();
    }

    getFormula = async (filter) => {
        return this.select(
            t_utilityservice_formula.id,
            t_utilityservice_formula.group,
            t_utilityservice_formula.formula,
        )
            .setFilter(filter)
            .exec();
    }
}

module.exports = Utilityservice