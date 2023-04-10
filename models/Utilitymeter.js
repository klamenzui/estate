const Model = require("./db/Model");
const t_utilitymeter = require('./db/tables/Utilitymeter');
const t_utilityservice = require('./db/tables/Utilityservice');
class Utilitymeter extends Model {
    constructor() {
        super();
    }
    get = async (filter) => {
        return this.select(
            t_utilitymeter.id,
            t_utilitymeter.code,
            t_utilitymeter.meter_before,
            t_utilitymeter.meter_current,
            t_utilitymeter.price,
            t_utilitymeter.date,
            t_utilitymeter.estate_id,
            t_utilityservice.name,
            t_utilityservice.unit,
            t_utilityservice.tariff_url,
            t_utilityservice.tariff_selector,
        )
            .setFilter(filter)
            .order(t_utilitymeter.id).exec();
    }
    updateCurrent = async (data) => {
        let filter = {};
        filter[t_utilitymeter._primary_key] = data[t_utilitymeter._primary_key];
        let res = await this.get(filter);
        data[t_utilitymeter.meter_before.name]=res[t_utilitymeter.meter_current.name];
        return await this.up(data);
    }
    calc = async (data) => {
        let res = 0;
        let current = data[t_utilitymeter.meter_current.name];
        let before = data[t_utilitymeter.meter_before.name];
        let price = data[t_utilitymeter.price.name];
        if((!current || !before || !price) && data[t_utilitymeter._primary_key]){
            data = await this.get(data);
            current = data[t_utilitymeter.meter_current.name];
            before = data[t_utilitymeter.meter_before.name];
            price = data[t_utilitymeter.price.name];
        }
        if(current && before && price){
            res = (current-before)*price;
        }
        return res;
    }
}

module.exports = Utilitymeter