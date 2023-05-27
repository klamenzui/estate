const Model = require('../../models/message');
const Page = require('../page');
class Message extends Page {
    constructor(controller) {
        super(controller);
    }

    get() {
        let req = this.controller.req;
        console.log(req.body);
        console.log('user data: ',req.user);
        new Model().setAsTable(true).get(req.body).then((results) => {
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }

    set() {
        let me = this;
        let req = me.controller.req;
        console.log(req.body);
        req.body['user'] = req.user;
        new Model().set(req.body).then((results) => {
            this.sendData(results);
            app.locals.wsSend({clazz:me.clazz ,method: me.method});

        }).catch((e) => {
            this.sendData(e);
        });
    }

    del() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().del(req.body).then((results) => {
            app.locals.wsSend(results);
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }
}

module.exports = Message