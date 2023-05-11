const Helper = require('../../utils/helper');
const ModelUtilitymeter = require('../../models/utilitymeter');
const  t_utilitymeter = require('../../models/db/tables/utilitymeter');
class Utilitymeter {
    id;
    current;

    main() {
        return this.up();
    }

    async up() {
        let msg = '';
        // All the required data to book is present => process the reservation

        let data = {};
        data[t_utilitymeter._primary_key]=this.id;
        data[t_utilitymeter.meter_current.name]=this.current;
        console.log(data);
        let res={};
        try{
            res = await new ModelUtilitymeter().updateCurrent(data);
        }catch (e){
            res = e;
        }
        if(res[0]){
            console.log('Utilitymeter.up', res);
            msg = 'Сделано, текущие показания счетчика '+this.id+' записаны ' + this.current;
        }else{
            console.log('err', res);
            msg = ('не удалось записать показания счетчика '+this.id);
        }
        return msg;
    }

    async get() {
        let msg = '';
        let um = new ModelUtilitymeter();
        let meter = await um.get(this.id);
        console.log('Utilitymeter.get meter',meter);
        let res = await um.calc(meter);
        console.log('Utilitymeter.get res',res);
        msg = ('Счетчик '+this.id+', всего к оплате ' + res);
        return msg;
    }
}

module.exports = Utilitymeter;