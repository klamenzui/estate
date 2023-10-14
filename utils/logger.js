const winston = require('winston');
const fs = require('fs');
const path = require('path');
const { combine, timestamp, label, printf } = winston.format;
const getCallerFile = () => {
    const originalFunc = Error.prepareStackTrace;

    let callerFile;
    try {
        const err = new Error();
        Error.prepareStackTrace = function (err, stack) { return stack; };
        const currentfile = path.basename(__filename);
        const stack = err.stack;
        stack.shift(); // removes this file (logger.js) from the stack
        stack.shift(); // removes this file (printf.js) from the stack
        while (stack.length) {
            const code = stack.shift();
            let [line,file,func] = [code.getLineNumber(),code.getFileName(),code.getFunctionName()];
            func = func || code.getMethodName();
            file = file.indexOf('node_modules')>-1 || file.indexOf('node:')>-1?'node_modules':path.basename(file);
            callerFile = `${line}:${file} ${func}`;
            if( [currentfile, 'node_modules','node:events'].indexOf(file) === -1) {
                break;
            }
        }
    } catch (e) {}

    Error.prepareStackTrace = originalFunc;

    return callerFile;
}

const myFormat = printf(({ level, message, timestamp}) => {
    let stringified;
    try {
        stringified = JSON.stringify(message, (key, value) => {
            return value;
        }, 2);
    } catch (e) {
        stringified = String(message); // Fallback to string conversion
    }
    return `${timestamp} [${getCallerFile()}] ${level}: ${stringified}`;
});


const logDirectory = path.join(__dirname, '/../log');

fs.existsSync(logDirectory) || fs.mkdirSync(logDirectory); // ensure log directory exists


const logger = winston.createLogger({
    level: 'info',
    format:combine(timestamp(),myFormat),
        //winston.format.json(),
    defaultMeta: { service: 'estate' },
    transports: [
        new winston.transports.File({ filename: logDirectory + '/error.log', level: 'error' }),
        new winston.transports.File({ filename: logDirectory + '/combined.log' }),
    ]
});

if (process.env.NODE_ENV !== 'production') {
    logger.add(new winston.transports.Console({
        format: winston.format.simple()
    }));
}

// handle exceptions
process.on('uncaughtException', function(err) {
    logger.error('Caught exception: ' + err);
});

module.exports = logger;