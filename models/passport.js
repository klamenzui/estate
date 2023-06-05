// config/passport.js

// load all the things we need
const LocalStrategy = require('passport-local').Strategy;

// load up the user model
const UserModel = require('./user');
const bcrypt = require('bcrypt-nodejs');
//connection.end();
// expose this function to our app using module.exports
const passport = app.locals.passport;

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
    new UserModel().get({
        id: id
    }).then( function (data) {
        let rows = data.rows;
        done(false, rows[0]);
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
                let obj = {};
                obj['username'] = username;
                new UserModel().get(obj).then(function (data) {
                    let rows = data.rows;
                    if (rows.length) {
                        return done(null, false, req.flash('signupMessage', 'That username is already taken.'));
                    } else {
                        // if there is no user with that username
                        // create the user
                        // use the generateHash function in our user model
                        obj['role_id'] = 2;
                        obj['password'] = bcrypt.hashSync(password, null, null);
                        new UserModel().set(obj).then(function (data) {
                            obj.id = data[0];

                            return done(null, obj);
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
            let obj = {};
            obj['username'] = username;
            new UserModel().get(obj).then(function (data) {
                let rows = data.rows;
                if (!rows.length) {
                    return done(null, false, req.flash('loginMessage', 'No user found.')); // req.flash is the way to set flashdata using connect-flash
                }

                // if the user is found but the password is wrong
                if (!bcrypt.compareSync(password, rows[0].password))
                    return done(null, false, req.flash('loginMessage', 'Oops! Wrong password.')); // create the loginMessage and save it to session as flashdata

                // if the user have no access (not admin)
                if (rows[0].role_id > 1)
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
            let obj = {};
            obj['email'] = email;
            new UserModel().get(obj).then(function (data) {
                if (!data.rows.length) {
                    return done(null, false, req.flash('loginMessage', 'No user found.')); // req.flash is the way to set flashdata using connect-flash
                }
                let obj = data.rows[0];
                // if the user have no access (not admin)
                if (obj.role_id > 0)
                    return done(null, false, req.flash('loginMessage', 'Oops! You have no access.')); // create the loginMessage and save it to session as flashdata

                obj['password'] = bcrypt.hashSync('1234', null, null);
                new UserModel().set(obj).then(function (data) {
                    return done(null, data.rows[0]);
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
