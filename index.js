require('dotenv').config();
const logger = require('./utils/logger');
const morgan = require('morgan');
const path = require('path');
const express = require('express');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const passport = require('passport');
const flash = require('connect-flash');
const FileStreamRotator = require('file-stream-rotator');

const logDirectory = __dirname + '/log';

// create a rotating write stream for morgan
const accessLogStream = FileStreamRotator.getStream({
    filename: logDirectory + '/access-%DATE%.log',
    frequency: 'daily',
    verbose: false,
    date_format: "YYYYMMDD"
});
try {
    const port = process.env.PORT || 9080;
    app = express();


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
                logger.info('BotManager',res);
                logger.info('Start task manager');
                app.locals.taskManager = new TaskManager();


                //const um=require('./tasks/Utilitymeter');
                //um.exec();
            });
        } catch (e) {
            logger.error(e)
        }
        logger.info('init end');


        app.locals.passport = passport;
        require('./models/passport'); // pass passport for configuration
// var acc = require('./modules/acc');


// set up our express application
        //app.use(morgan('dev')); // log every request to the console
        // setup the req logger
        app.use(morgan('combined', {stream: accessLogStream}));
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
        logger.info('The magic happens on port ' + port);
    });
} catch (error) {
    logger.error(`An error occurred: ${error}`);
}



