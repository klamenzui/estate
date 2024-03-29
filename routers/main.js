// app/routes.js
//const fs = require('fs');
//const {estates,payment,expense,estateMenu} = require('../models/estate');
const passport = app.locals.passport;
const Controller = require('../controllers/controller.js');
const expressWs = require('express-ws')(app);

console.log(Controller);
app.ws('/', function(ws, req) {
    app.locals.ws = ws;
    ws.on('message', function(msg) {
        if(req.cookies && req.cookies.ajs_user_id){
            try {
                //set auth for req.isAuthenticated()
                req['user'] = true;
                //console.log(req.headers.cookie);
                console.log(req.cookies);
                console.log(msg, req.body);
                msg = JSON.parse(msg);
                let url = msg.url.split('/');
                if(url.length === 4) {
                    let params = {
                        folder: url[1],
                        clazz: url[2],
                        method: url[3],
                    }
                    req.params = params;
                    req.body = msg.data;
                    req.originalUrl = '/'+ params.folder + '/'+ params.clazz + '/' + params.method;
                    //req.body =
                    let res = {
                        json:function(data){
                            console.log(data);
                            ws.send(JSON.stringify(data))
                        }
                    };
                    /*msg.req['originalUrl'] = 'ws';
                    msg.req['app'] = app;
                    msg.req['isAuthenticated'] = req.isAuthenticated;*/
                    (new Controller()).request(req, res);
                }
            } catch (e) {
                console.log(e);
            }
        }
    });
    console.log('socket', req.testing);
});

app.use(function (req, res, next) {
    console.log('middleware');
    req.testing = 'testing';
    return next();
});

app.get('/:clazz/:method', function (req, res) {
    console.log(req.cookies);
    (new Controller()).request(req, res);
});
app.get('/login', (req, res) => {
    res.redirect('/auth/login');
});
app.get('/logout', (req, res) => {
    res.redirect('/auth/logout');
});
app.get('/register', (req, res) => {
    res.redirect('/auth/register');
});
app.get('/forgot-password', (req, res) => {
    res.redirect('/auth/forgot-password');
});
app.get('/:clazz', function (req, res) {
    (new Controller()).request(req, res);
});
app.get('/home', function (req, res) {
    res.redirect('/home/index');
});
app.get('/', function (req, res) {
    res.redirect('/home/index');
});
// process the signup form
app.post('/register', passport.authenticate('local-register', {
    successRedirect: 'home', // redirect to the secure profile section
    failureRedirect: 'register', // redirect back to the signup page if there is an error
    failureFlash: true // allow flash messages
}));

// process the reset password
app.post('/reset', passport.authenticate('local-reset', {
        successRedirect: 'login', // redirect to the secure profile section
        failureRedirect: 'reset', // redirect back to the signup page if there is an error
        failureFlash: true // allow flash messages
    }),
    function (req, res) {
        console.log("reset");

        //if (req.body.email == 'some email') {
        // send email
        //res.redirect('/login');
        //} else {
        // flash error message
        //}
    }
);

app.post('/:folder/:clazz/:method', function (req, res) {
    (new Controller()).request(req, res);
});
/*
app.post('/api/payment', function (req, res) {
    console.log(req.body);
    payment(req.body, function (data) {
        res.json(data);
    });
});
app.post('/api/expense', function (req, res) {
    console.log(req.body);
    expense(req.body, function (data) {
        res.json(data);
    });
});
*/
// process the login form
app.post('/login', passport.authenticate('local-login', {
        successRedirect: 'home', // redirect to the secure profile section
        failureRedirect: 'login', // redirect back to the signup page if there is an error
        failureFlash: true // allow flash messages
    }),
    function (req, res) {
        console.log("hello");

        if (req.body.remember) {
            req.session.cookie.maxAge = 1000 * 60 * 3;
        } else {
            req.session.cookie.expires = false;
        }
        res.redirect('/');
    });

app.use(error);

function error(err, req, res, next) {
    // log it
    console.error(err.stack);
    if (req.isAuthenticated()) console.error(err.stack);
    if (err.status === 404) {
        res.status(404).send(
            "<h1>Page not found on the server</h1>");
        res.format({
            html: function () {
                res.render('404', {url: req.url})
            },
            json: function () {
                res.json({error: 'Not found'})
            },
            default: function () {
                res.type('txt').send('Not found')
            }
        })
    } else {
        // respond with 500 "Internal Server Error".
        res.status(err.status || 500).send('Internal Server Error');
    }


}

//module.exports = router