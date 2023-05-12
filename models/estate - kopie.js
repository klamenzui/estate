const mysql = require('mysql');
const fs = require('fs');
const dbconfig = require('./config_db');
const connection = mysql.createConnection(dbconfig.connection);
connection.connect();
connection.query('USE ' + dbconfig.database);

module.exports = class Product {
    constructor(t) {
        this.title = t
    }
}
//connection.end();
// expose this function to our app using module.exports
exports.payment = function payment(data, done) {
    let answer = "";

    const rows = connection.query(`SELECT p.id,p.summe, p.period,
											client.first_name,
											c.id contract_id,
											c.accommodation_id,
											c.period_type,
											c.price,
											c.date_start
										FROM contract AS c
											LEFT JOIN payment p on (p.contract_id = c.id)
											LEFT JOIN client on ( client.id = c.client_id )
										WHERE c.accommodation_id = ? ORDER BY p.period DESC `, [data.accommodation_id], function (err, rows) {
        try {
            if (err)
                return done(err);
            if (!rows.length) {
                return done({'message': 'No data.'}); // req.flash is the way to set flashdata using connect-flash
            }
            return done({data: rows});
        } catch (e) {
            return done({'error': e});
        }
    });

    return answer;
}
exports.expense = function expense(data, done) {
    let answer = "";

    const rows = connection.query(`SELECT e.id, e.summe, e.date,a.name, e.description, e.accommodation_id, e.type
    FROM expense AS e
    left join ref_accommodation_accessory ref_acc_acc on( ref_acc_acc.id = e.ref_acc_acc )
    left join accessory a on( a.id = ref_acc_acc.accessory_id )
    WHERE e.accommodation_id = ?
    order by e.date DESC`, [data.accommodation_id], function (err, rows) {
        try {
            if (err)
                return done(err);
            if (!rows.length) {
                return done({'message': 'No data.'}); // req.flash is the way to set flashdata using connect-flash
            }
            return done({data: rows});
        } catch (e) {
            return done({'error': e});
        }
    });

    return answer;
}
exports.estates = function estates(req, done) {
    let where = '';
    let params = [];
    let a_id=-1;
    const r = req;
    if(typeof(req.query) != 'undefined' && typeof(req.query.id) != 'undefined'){
        a_id= req.query.id;
        where = ' where a.id = ?';
        params.push(a_id);
    }
    connection.query(`SELECT addr.id as accommodation_id, addr.street as street,
									addr.longitude,
									addr.latitude,
									co.name as country, state.name as state, ci.name as city,
									a.house_number, a.apartment_number, a.square, a.photos,
									client.first_name,
									contract.id contract_id,
									contract.period_type,
									contract.price,
									contract.date_start,
									profit.total profit_total
								FROM
									accommodation AS a

								LEFT JOIN address as addr on ( addr.id = a.address_id )
								LEFT JOIN country as co on (co.id = addr.country_id)
								LEFT JOIN city as ci on (ci.id = addr.city_id)
								LEFT JOIN state on (state.id = addr.state_id)
								LEFT JOIN contract on (contract.accommodation_id = a.id and contract.status = 'active')
								LEFT JOIN client on ( client.id = contract.client_id )
								LEFT JOIN (
										select
											contract.accommodation_id,
											sum(payment.summe) total
										from contract
										LEFT JOIN payment on ( contract.id = payment.contract_id )
									group by contract.accommodation_id
									) as profit on ( profit.accommodation_id = a.id )
								`+where+`
								group by a.id
								order by profit.total desc`, params, function (err, rows) {
        try {
            if (err)
                return done(err);
            if (!rows.length) {
                return done({'message': 'No data.'}); // req.flash is the way to set flashdata using connect-flash
            }

            // all is well, return successful user
            console.log('loop:');
            let base_path = r.app.locals.static;
            for (var i in rows) {
                if (fs.existsSync(base_path+'/img/' + rows[i]['photos'])) {
                    console.log('path:'+base_path+'/img/' + rows[i]['photos']);
                    rows[i]['url'] = 'https://www.google.de/maps/@' + rows[i]['longitude'] + ',' + rows[i]['latitude'] + ',200m/data=!3m1!1e3';
                    rows[i]['photos_list'] = [];
                    let files = fs.readdirSync(base_path+'/img/' + rows[i]['photos']);
                    for(let findex in files) {
                        rows[i]['photos_list'].push('/static/img/' + rows[i]['photos']+'/'+files[findex]);
                        console.log(files[findex]);
                    };

                }
            }
            return done({data: rows});
        } catch (e) {
            return done({'error': e});
        }
    });
}

exports.estatesMenu = function estatesMenu(req, done) {
    let where = '';
    let params = [];
    let a_id=-1;
    const r = req;
    if(typeof(req.query) != 'undefined' && typeof(req.query.id) != 'undefined'){
        a_id= req.query.id;
        where = ' where a.id = ?';
        params.push(a_id);
    }
    connection.query(`SELECT addr.id as accommodation_id, addr.street as street, a.house_number, a.apartment_number
								FROM
									accommodation AS a

								LEFT JOIN address as addr on ( addr.id = a.address_id )
								
								`+where+`
								order by addr.id asc`, params, function (err, rows) {
        try {
            if (err)
                return done(err);
            if (!rows.length) {
                return done({'message': 'No data.'}); // req.flash is the way to set flashdata using connect-flash
            }
            return done({data: rows});
        } catch (e) {
            return done({'error': e});
        }
    });
}