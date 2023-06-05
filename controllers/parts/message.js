const Helper = require('../../utils/helper');
const Page = require('../page');
const moment = require('moment');

class Message extends Page {
    res;

    constructor(controller) {
        super(controller);
        this.req = this.controller.req;
        this.tpl = 'part.ejs';
        this.addMethodToTpl = false;
        this.res = []
    }



    async preview() {
        this.setAccess("<2");
        const MessageModel = require('../../models/message');
        const t_message = require('../../models/db/tables/message');
        let message = await new MessageModel().get();
        this.res = [];
        if(message && message.rows){
            console.log(message.rows);
            for(let i in message.rows){
                this.res.push({
                    header: {
                        img: (message.rows[i].from_img?message.rows[i].from_img:'')
                    },
                    body: message.rows[i].text,
                    footer: (message.rows[i].from_user?message.rows[i].from_user+ ' ':'') + Helper.formatDate(message.rows[i].date,'h:m:s D.M.Y')
                });
            }
        }

        this.sendData(this.res);
    }

}

module.exports = Message