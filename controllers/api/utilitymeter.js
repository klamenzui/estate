const Model = require('../../models/Utilitymeter');
const Page = require('../Page');
class Utilitymeter extends Page {
    constructor(controller) {
        super(controller);
    }
    get() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().setAsTable(true).get(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }
    set() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().set(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }
    del() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().del(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }

    calc() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().calc(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }
    updateCurrent() {
        let req = this.controller.req;
        console.log(req.body);
        new Model().updateCurrent(req.body).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }
}

module.exports = Utilitymeter