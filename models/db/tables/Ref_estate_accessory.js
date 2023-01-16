const Entity = require("../Entity");
class Ref_estate_accessory extends Entity {
    _editable = {"estate_id":[1,"estate_id"],"accessory_id":[2,"accessory_id"],"status":[3,"status","{\"0\":\"new\",\"1\":\"almost_new\",\"2\":\"normal\",\"3\":\"old\"}"]};
    _fields = {
  "id": {
    "name": "id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "PRI",
    "extra": "auto_increment"
  },
  "estate_id": {
    "name": "estate_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "accessory_id": {
    "name": "accessory_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "status": {
    "name": "status",
    "type": {
      "0": "new",
      "1": "almost_new",
      "2": "normal",
      "3": "old"
    },
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;estate_id;accessory_id;status;
    constructor () {
        super();
    }
}
module.exports = new Ref_estate_accessory();