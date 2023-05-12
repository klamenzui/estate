const EstateModel = require('../models/estate');
const Page = require('./page');

const fs = require('fs');

class Estate extends Page {
    /**
     * @description add new data
     * @param { data: String } = req.body
     * @response {error(boolean), message(String), response(object:any)}
     */
    add() {
        let req = this.controller.req;
        const {data} = req.body
        if (!data) {
            throw new Error("Enter Data")
        }
        new EstateModel().add({data}).then((results) => {
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }

    /**
     * @description get all data from a specific table order by a field
     * @param {field} field name
     * @response {error(boolean), message(String), response(object:any)}
     */
    get() {
        let req = this.controller.req;
        const value = req.query ? req.query.id : undefined;
        if (typeof value == 'undefined') {
            this.getAll();
        } else {
            this.getDetails();
            /*new EstateModel().getOne(field, value, (err, results) => {
                this.sendData(err, results);
                this.render();
            })*/
        }

    }

    /**
     * @description get all data from a specific table order by a field
     * @param {field} field name
     * @response {error(boolean), message(String), response(object:any)}
     */
    getAll(asTable) {
        let req = this.controller.req;
        new EstateModel().setAsTable(asTable).get(req.params.filter).then((res)=>{
            this.sendData(res);
        }).catch((e)=>{
            this.sendData(e);
        });
    }//end getAll

    /**
     * @description get all data from a specific table order by a field using pagination
     * @param {field} field name
     * @param {page} 1,2,3,4.. (page number)
     * @response {error(boolean), message(String), response(object:any)}
     */
    getPaginateList() {
        let req = this.controller.req;
        const page = req.params.page
        const field = req.params.field
        //error, message, data: response
        new EstateModel().setAsTable(true).getPaginateList(page, field).then((results) => {
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }//end getPaginateList

    getAddress() {
        let req = this.controller.req;
        const id = req.params.id;
        new EstateModel().getAddress(id ? id : -1).then((results) => {
            this.sendData(results);
        }).catch((e) => {
            this.sendData(e);
        });
    }

    getDetails() {
        let req = this.controller.req;
        const id = req.query ? req.query.id : undefined;
        new EstateModel().getDetails(id ? id : -1).then((results) => {
            console.log('loop:');
            let base_path = req.app.locals.static;
            if(results.rows!== null && typeof results.rows != 'undefined'){
                for (var i in results.rows) {
                    //rows[i].date_start = new Date(rows[i].date_start).toISOString().slice(0, 10);//.replace('T', ' ');
                    if (fs.existsSync(base_path + '/img/' + results.rows[i]['photos'])) {
                        console.log('path:' + base_path + '/img/' + results.rows[i]['photos']);
                        results.rows[i]['url'] = 'https://www.google.de/maps/@' + results.rows[i]['longitude'] + ',' + results.rows[i]['latitude'] + ',200m/data=!3m1!1e3';
                        results.rows[i]['photos_list'] = [];
                        let files = fs.readdirSync(base_path + '/img/' + results.rows[i]['photos']);
                        for (let findex in files) {
                            results.rows[i]['photos_list'].push('/static/img/' + results.rows[i]['photos'] + '/' + files[findex]);
                            console.log(files[findex]);
                        }
                    }
                }
            } else {
                results['error'] = 'no data';
            }
            this.sendData(results);
            //this.render();
        }).catch((e) => {
            this.sendData(e);
        });
    }
}

module.exports = Estate