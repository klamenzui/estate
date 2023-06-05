const fs = require('fs');
const path = require('path');
Loader = {
    modelExists(model_name) {
        let res = fs.existsSync(path.resolve(__dirname, model_name + '.js') );
        return res;
    },
    model(model_name, instance = true) {
        let modelPath = this.modelExists(model_name)
            ?path.resolve(__dirname, model_name) :
            path.resolve(__dirname, 'db/model');
        const Model = require(modelPath);
        return (instance? new Model(model_name): Model);
    }
}

module.exports = Loader