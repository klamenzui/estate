const Model = require('../../models/expense');
const Helper = require('../../utils/helper');
const Page = require('../page');

class Expense extends Page {
    constructor(controller) {
        super(controller);
    }

    get() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().setAsTable(true).get(req.body).then((results) => {
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }

    set() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().set(req.body).then((results) => {
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }

    del() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().del(req.body).then((results) => {
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }
}

module.exports = Expense