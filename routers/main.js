// app/routes.js
//const fs = require('fs');
//const {estates,payment,expense,estateMenu} = require('../models/estate');
var passport = app.locals.passport;
const Controller = require('../controllers/controller.js');
console.log(Controller)
app.get('/:clazz/:method', function (req, res) {
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

app.use(error);

function error(err, req, res, next) {
    // log it
    console.error(err.stack);
    if (req.isAuthenticated()) console.error(err.stack);
    if (err.status == 404) {
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