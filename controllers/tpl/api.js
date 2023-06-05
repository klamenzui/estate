module.exports.init = function (_controller) {
    const Loader = require('../../models/loader');
    const Page = require('../page');
    class Tpl extends Page {
        constructor(controller) {
            super(controller);
            this.model = Loader.model(_controller.clazz);
        }
        get() {
            this.setAccess("<2");
            let req = this.controller.req;
            console.log(req.body);
            this.model.setAsTable(true).get(req.body).then((results) => {
                this.sendData(results);
            }).catch((e) => {
                this.sendData(e);
            });
        }
        set() {
            this.setAccess("<1");
            let req = this.controller.req;
            console.log(req.body);
            this.model.set(req.body).then((results) => {
                this.sendData(results);
            }).catch((e) => {
                this.sendData(e);
            });
        }
        del() {
            this.setAccess("<1");
            let req = this.controller.req;
            console.log(req.body);
            this.model.del(req.body).then((results) => {
                this.sendData(results);
            }).catch((e) => {
                this.sendData(e);
            });
        }
    }
    return new Tpl(_controller);
};