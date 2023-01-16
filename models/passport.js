// config/passport.js

// load all the things we need
var LocalStrategy = require('passport-local').Strategy;

// load up the user model
var bcrypt = require('bcrypt-nodejs');
var connection = app.locals.knex;
//connection.end();
// expose this function to our app using module.exports
var passport = app.locals.passport;

// =========================================================================
// passport session setup ==================================================
// =========================================================================
// required for persistent login sessions
// passport needs ability to serialize and unserialize users out of session

// used to serialize the user for the session
passport.serializeUser(function (user, done) {
    done(null, user.id);
});

// used to deserialize the user
passport.deserializeUser(function (id, done) {
    //connection.connect();
    connection.raw("SELECT * FROM user WHERE id = ? ", [id]).then( function (rows) {
        done(false, rows[0][0]);
    }).catch(err => {
        //if(error instanceof DatabaseError) { // ...
        done(err);
        });
    //connection.end();
});

// =========================================================================
// LOCAL SIGNUP ============================================================
// =========================================================================
// we are using named strategies since we have one for login and one for signup
// by default, if there was no name, it would just be called 'local'

passport.use(
    'local-register',
    new LocalStrategy({
            // by default, local strategy uses username and password, we will override with email
            usernameField: 'username',
            passwordField: 'password',
            passReqToCallback: true // allows us to pass back the entire request to the callback
        },
        function (req, username, password, done) {
            // find a user whose email is the same as the forms email
            // we are checking to see if the user trying to login already exists
            //connection.connect();
            try {

                connection.raw("SELECT * FROM user WHERE username = ?", [username]).then(function (rows) {
                    rows = rows[0];
                    if (rows.length) {
                        return done(null, false, req.flash('signupMessage', 'That username is already taken.'));
                    } else {
                        // if there is no user with that username
                        // create the user
                        var newUserMysql = {
                            username: username,
                            password: bcrypt.hashSync(password, null, null)  // use the generateHash function in our user model
                        };

                        var insertQuery = "INSERT INTO user ( username, password ) values (?,?)";
                        //connection.connect();
                        connection.raw(insertQuery, [newUserMysql.username, newUserMysql.password], function (rows) {
                            newUserMysql.id = rows.insertId;

                            return done(null, newUserMysql);
                        });
                        //connection.end();
                    }
                }).catch(err => {
                    //if(error instanceof DatabaseError) { // ...
                    done(err);
                });
            } catch (err){
                console.log(err)
            }
            //connection.end();
        })
);

// =========================================================================
// LOCAL LOGIN =============================================================
// =========================================================================
// we are using named strategies since we have one for login and one for signup
// by default, if there was no name, it would just be called 'local'

passport.use(
    'local-login',
    new LocalStrategy({
            // by default, local strategy uses username and password, we will override with email
            usernameField: 'username',
            passwordField: 'password',
            passReqToCallback: true // allows us to pass back the entire request to the callback
        },
        function (req, username, password, done) { // callback with email and password from our form
            //connection.connect();
            connection.raw("SELECT * FROM user WHERE username = ?", [username]).then(function (rows) {
                rows = rows[0];
                if (!rows.length) {
                    return done(null, false, req.flash('loginMessage', 'No user found.')); // req.flash is the way to set flashdata using connect-flash
                }

                // if the user is found but the password is wrong
                if (!bcrypt.compareSync(password, rows[0].password))
                    return done(null, false, req.flash('loginMessage', 'Oops! Wrong password.')); // create the loginMessage and save it to session as flashdata

                // if the user have no access (not admin)
                if (rows[0].role_id > 0)
                    return done(null, false, req.flash('loginMessage', 'Oops! You have no access.')); // create the loginMessage and save it to session as flashdata

                // all is well, return successful user
                return done(null, rows[0]);
            }).catch(err => {
                //if(error instanceof DatabaseError) { // ...
                done(err);
            });
            //connection.end();
        })
);

passport.use(
    'local-reset',
    new LocalStrategy({
            // by default, local strategy uses username and password, we will override with email
            emailField: 'email',
            passReqToCallback: true // allows us to pass back the entire request to the callback
        },
        function (req, email, done) { // callback with email and password from our form
            //connection.connect();
            connection.raw("SELECT * FROM user WHERE email = ?", [email]).then(function (rows) {
                rows = rows[0];
                if (!rows.length) {
                    return done(null, false, req.flash('loginMessage', 'No user found.')); // req.flash is the way to set flashdata using connect-flash
                }

                // if the user have no access (not admin)
                if (rows[0].role > 0)
                    return done(null, false, req.flash('loginMessage', 'Oops! You have no access.')); // create the loginMessage and save it to session as flashdata

                let password = "newpass";
                connection.raw("UPDATE user SET password = ? WHERE id = ?", [bcrypt.hashSync(password, null, null), rows[0].id]).then(function (err, rows) {
                    return done(null, rows[0]);
                }).catch(err => {
                    //if(error instanceof DatabaseError) { // ...
                    done(err);
                });


            }).catch(err => {
                //if(error instanceof DatabaseError) { // ...
                done(err);
            });
            //connection.end();
        })
);
