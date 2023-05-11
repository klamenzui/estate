const ErrorController = require("../Error");
class Error extends ErrorController{
    constructor(controller) {
        super(controller);
    }
}

module.exports = Error