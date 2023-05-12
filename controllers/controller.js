/**
 * @design by milon27
 */
const Error = require('./error')
const fs = require('fs');

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
        //me.page = "home";
        console.log(me.path, me.folder, me.clazz, me.method);
        me.all = {};
        const normalizedPath = require('path').join(__dirname, me.folder);

        let files = fs.readdirSync(normalizedPath);
        for (let i in files) {
            me.all[files[i].toLowerCase().substring(0, files[i].indexOf('.'))] = require("./" + me.folder + "/" + files[i]);
        }
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
            console.log(me.clazz, me.method);
            if (typeof me.all[me.clazz] === 'undefined') {
                //me.clazz = "Error";
                //me.method = "404";
                new Error(me)['404']();
            } else {
                let pageInst = new (me.all[me.clazz])(me);
                pageInst.execMethod();
            }
        } catch (err) {
            new Error(me).sendData(err);
        }
    }


}

module.exports = Controller