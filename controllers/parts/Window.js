const Helper = require("../../utils/Helper");
const Page = require('../Page');

class Window extends Page {
    res;

    constructor(controller) {
        super(controller);
        let req = this.controller.req;
        this.tpl = 'part.ejs';
        this.addMethodToTpl = false;
        this.res = {
            header: {
                title: ''
            },
            body: {
                readonly: !!req.body.readonly,
                attr: {
                    'callback': req.body.callback,
                    'action': req.body.action,
                    'baseurl': ''
                },
                fields: {},
                data: {}
            },
            footer: {
                html: [
                    {
                        tag: 'button',
                        attr: {
                            class: "btn btn-secondary",
                            type: "button",
                            'data-dismiss': "modal"
                        },
                        html: "Cancel"
                    },
                    {
                        tag: 'a',
                        attr: {
                            href: '#',
                            class: "btn btn-primary",
                            onclick: 'processModal();'
                        },
                        html: 'Submit'
                    }
                ]
            }
        }
    }

    payment() {
        this._sendData('payment');
    }

    expense() {
        this._sendData('expense');
    }

    contract() {
        this._sendData('contract');
    }

    client() {
        this._sendData('client');
    }

    task() {
        this._sendData('task');
    }

    logout() {
        this.res.header.title = 'Ready to Leave?';
        this.res.body = 'Select "Logout" below if you are ready to end your current session.';
        this.res.footer.html[1].text = 'Logout';
        this.res.footer.html[1].attr.href = '/logout';
        this.sendData(this._buildHtml());
    }

    _sendData(clazz) {
        let req = this.controller.req;
        const entity = require('../../models/db/tables/' + clazz);
        const Model = require('../../models/' + clazz);
        this.res.header.title = clazz;
        this.res.body.attr.baseurl = '/api/' + clazz + '/';
        this.res.body.fields = entity._fields;
        this.res.body.data = {};
        if (req.query && !Helper.isEmpty(req.body.data[entity._primary_key])) {
            new Model().get(req.body.data[entity._primary_key], (results) => {
                if (!Helper.isEmpty(results.rows)) {
                    this.res.body.data = results.rows[0];
                }
                this.sendData(this._buildHtml());
            });
        } else {
            for (let k in entity._fields) {
                if (typeof req.body.data[k] !== 'undefined') {
                    this.res.body.data[k] = req.body.data[k];
                }
            }
            this.sendData(this._buildHtml());
        }
    }

    _buildHtml() {
        for (let k in this.res) {
            if (this.res[k].html) {
                this.res[k].html = Helper.getHtml(this.res[k].html);
            }

            if (this.res[k].attr) {
                this.res[k].attr = Helper.getTag(this.res[k]);
            }
        }
        return this.res;
    }
}

module.exports = Window