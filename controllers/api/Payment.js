const Model = require('../../models/Payment');
const Page = require('../Page');

class Payment extends Page {
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

module.exports = Payment