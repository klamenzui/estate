const EstateModel = require('../../models/estate');
const Model = require('../../models/utilitymeter');
const UtilityserviceModel = require('../../models/utilityservice');
const Page = require('../page');
const t_utilityservice = require('../../models/db/tables/utilityservice');
class Utilitymeter extends Page {
    constructor(controller) {
        super(controller);
    }

    async get() {
        //let req = this.controller.req;
        //const id = req.params.id;
        try {
            let utilityservice = await new UtilityserviceModel().get();
            let results = await new EstateModel().getAddress(/*id ? id :*/ -1);
            console.log('-----------------------------------------------------------')
            console.log(utilityservice);
            let group = {};
            for (let i in utilityservice.rows){
                let key = utilityservice.rows[i][t_utilityservice.group.name];
                group[key] = key;
            }
            results['utilityformula'] = await new UtilityserviceModel().getFormula();
            results['utilitygroup'] = Object.keys(group);
            results['utilityservice'] = utilityservice.rows;
            this.sendData(results);
        }catch(e){
            this.sendData(e);
        }

    }
}

module.exports = Utilitymeter