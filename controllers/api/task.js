const Model = require('../../models/task');
const Page = require('../page');
class Task extends Page {
    constructor(controller) {
        super(controller);
    }
    get() {
        this.setAccess("<1");
        let req = this.controller.req;
        console.log(req.body);
        new Model().setAsTable(true).get(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }
    set() {
        this.setAccess("<1");
        let req = this.controller.req;
        console.log(req.body);
        new Model().set(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }
    del() {
        this.setAccess("<1");
        let req = this.controller.req;
        console.log(req.body);
        new Model().del(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }
}

module.exports = Task