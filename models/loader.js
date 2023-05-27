const fs = require('fs');
Loader = {
    model(model_name) {
        let modelPath = fs.existsSync('./' + model_name + '.js')
            ?'./' + model_name :
            './db/model';
        const Model = require(modelPath);
        return new Model(model_name);
    }
}

module.exports = Loader