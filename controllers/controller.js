/**
 * @design by milon27
 */
const Error = require('./error')
const fs = require('fs');
const path = require('path');

//new Controller('Estate.js','test').navigate();
class Controller {
    constructor() {
    }

    init(req, res) {
        let me = this;
        me.req = req;
        me.app = req.app;
        me.res = res;
        me.path = req.originalUrl.toLowerCase().substring(1);//req.params.page.toLowerCase();
        let tmp = me.path.split('/');
        //let isConstructor = false;
        if (tmp.length === 3) {
            //:folder/:clazz/:method
            me.folder = req.params.folder;
            me.clazz = req.params.clazz;
            me.method = req.params.method;
        } else {
            //:clazz/:method
            //:clazz
            me.folder = 'pages';
            me.clazz = req.params.clazz;
            me.method = (typeof req.params.method == 'undefined' ? 'index' : req.params.method);
        }
        //isConstructor = me.clazz === 'constructor';
        //me.page = "home";
        console.log(me.path, me.folder, me.clazz, me.method);
        me.all = {};
        /*if(isConstructor){
            me.all['constructor'] = require('./constructor');
        }else{*/
        const normalizedPath = path.join(__dirname, me.folder);
        let files = fs.readdirSync(normalizedPath);
        for (let i in files) {
            me.all[files[i].toLowerCase().substring(0, files[i].indexOf('.'))] = require('./' + (me.folder? me.folder + '/':'') + files[i]);
        }
         //}
        console.log(me.all);
        return me;
    }

    request(req, res) {
        let me = this.init(req, res);
        try {
            //this.page = this.clazz+"."+this.method;
            switch (me.clazz) {
                case "index":
                    me.clazz = "home";
                    break;
            }
            let clazz = '' + me.clazz;
            console.log(me.clazz, me.method);
            let tplIndex = (app.locals.config.gui.router[me.folder] ? app.locals.config.gui.router[me.folder].indexOf(me.clazz): -1);
            let isDef = typeof me.all[clazz] !== 'undefined';
            if ( !isDef && tplIndex === -1) {
                //me.clazz = "Error";
                //me.method = "404";
                new Error(me)['404']();
            } else {
                let pageInst = null;
                if(isDef){
                    pageInst = new (me.all[clazz])(me);
                } else {
                    let tpl = app.locals.config.gui.router[me.folder][tplIndex];
                    pageInst =  require('./tpl/' + me.folder).init(me);
                    pageInst.title = clazz;
                }
                pageInst.execMethod();
            }
        } catch (err) {
            console.log(err);
            new Error(me).sendData(err);
        }
    }


}

module.exports = Controller