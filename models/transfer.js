const Model = require('./db/model');
const t_transfer = require('./db/tables/transfer');
const Loader = require('../models/loader');

class Transfer extends Model {
    transactions = [];
    constructor() {
        super();
    }

    addTransaction(src_table, src_id, target_id, amount, description){
        src_table = src_table || 'card';
        this.transactions.push({
            [t_transfer.src_table.name]: src_id,
            [t_transfer.from_src.name]: src_id,
            [t_transfer.to_card.name]: target_id,
            [t_transfer.to_card.amount.name]: amount,
            [t_transfer.description.name]: description || 'from ' + src_table,
        });
    }

    confirm = async () => {
        if(this.transactions){
            for(let i in this.transactions){
                let data = this.transactions[i];
                await this.add(data);
                try {
                    if(Loader.modelExists('tables/' + data[t_transfer.src_table.name])){
                        let srcModel = Loader.model(data[t_transfer.src_table.name]);
                        srcModel.param = {
                            'status': 'transferred'
                        };
                        srcModel.where(srcModel.primary_key, '=', data[t_transfer.from_src.name])
                        srcModel.query(`UPDATE ${(srcModel.table)} SET ? = ? WHERE ${this.primary_key} = ?`);
                        //let sql = ;
                        //await this.db.raw(sql, [this.row, obj[this.primary_key]]);
                    }
                } catch (e) {

                }

            }
        }
    }
}

module.exports = Transfer