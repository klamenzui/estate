// server.js
// get all the tools we need
const path = require('path')
var express = require('express');
var session = require('express-session');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var morgan = require('morgan');


var port = /*process.env.PORT ||*/ 9080;

app = express();

var passport = require('passport');
var flash = require('connect-flash');

// configuration ===============================================================
app.locals.base = __dirname + '/';
app.locals.static = path.join(__dirname, '/views/static');
// connect to our database
app.locals.config = require('./utils/init');
init = async function () {
    await app.locals.config.loadScheme();//.then(r => {

//});
}
init().then(r => {
    try {
        const BotManager = require('./bot/botmanager');
        const TaskManager = require('./models/taskmanager');
        app.locals.bot = new BotManager('KrHome', (res) => {
            console.log(res);
            console.log('Start task manager');
            app.locals.taskManager = new TaskManager();


            //const um=require('./tasks/Utilitymeter');
            //um.exec();
        });
    } catch (e) {
        console.log(e)
    }
    console.log('init end');


    app.locals.passport = passport;
    require('./models/passport'); // pass passport for configuration
// var acc = require('./modules/acc');


// set up our express application
    app.use(morgan('dev')); // log every request to the console
    app.use(cookieParser()); // read cookies (needed for auth)
    app.use(bodyParser.urlencoded({
        extended: true
    }));
    app.use(bodyParser.json());


//app.engine('.html', require('ejs').__express);
//app.engine('html', require('ejs').renderFile);
    app.set('views', __dirname + '/views/pages/');
    app.set('view engine', 'ejs'); // set up ejs for templating
//app.use(express.static('views'))
    app.use('/static', express.static(app.locals.static));
// required for passport
    app.use(session({
        secret: 'vidyapathaisalwaysrunning',
        resave: true,
        saveUninitialized: true
    })); // session secret
    app.use(passport.initialize());
    app.use(passport.session()); // persistent login sessions
    app.use(flash()); // use connect-flash for flash messages stored in session


// routes ======================================================================
//require('./routers/routes.js')(app, passport); // load our routes and pass in our app and fully configured passport
    require('./routers/main');
//app.use('/routes', require('./routers/main'));
// launch ======================================================================
    app.listen(port);
    console.log('The magic happens on port ' + port);
});


