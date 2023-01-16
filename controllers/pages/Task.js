const EstateParent = require('../Estate');
class Estate extends EstateParent {
    constructor(controller) {
        super(controller);
    }

    index() {
        get();
    }
}

module.exports = Estate