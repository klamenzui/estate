const Helper = require('../../utils/helper');
const Page = require('../page');
const moment = require('moment');

class Alert extends Page {
    res;

    constructor(controller) {
        super(controller);
        this.req = this.controller.req;
        this.tpl = 'part.ejs';
        this.addMethodToTpl = false;
        this.res = []
    }

    async preview() {
        const Model = require('../../models/alert');
        const t_table = require('../../models/db/tables/alert');
        let alert = await new Model().get();
        this.res = [];
        if(alert && alert.rows){
            console.log(alert.rows);
            for(let i in alert.rows){
                //<div class="icon-circle bg-warning"> <i class="fas fa-exclamation-triangle text-white"></i></div>
                //<div class="icon-circle bg-success"><i class="fas fa-donate text-white"></i></div>
                //<div class="icon-circle bg-primary"><i class="fas fa-file-alt text-white"></i></div>
                this.res.push({
                    header: {
                        bg: 'primary',
                        icon: alert.rows[i].type === 'payment'? 'donate':'exclamation-triangle'
                    },
                    body: alert.rows[i].text,
                    footer: Helper.formatDate(alert.rows[i].date_start,'h:m:s D.M.Y')
                });
            }
        }
        this.sendData(this.res);
    }

}

module.exports = Alert