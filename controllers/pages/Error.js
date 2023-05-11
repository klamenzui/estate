const ErrorController = require('../error');
class Error extends ErrorController{
    constructor(controller) {
        super(controller);
    }
}

module.exports = Error