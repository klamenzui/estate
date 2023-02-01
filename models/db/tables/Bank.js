const Entity = require("../Entity");
class Bank extends Entity {
    _editable = {"estate_id":[1,"estate_id"],"amount":[2,"amount"],"currency":[3,"currency","{\"0\":\"hryvnia\",\"1\":\"euro\",\"2\":\"dollar\"}"],"hrn_equivalent":[4,"hrn_equivalent"],"direction":[5,"direction","{\"0\":\"incoming\",\"1\":\"outcoming\"}"]};
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
  "amount": {
    "name": "amount",
    "type": "float",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "currency": {
    "name": "currency",
    "type": {
      "0": "hryvnia",
      "1": "euro",
      "2": "dollar"
    },
    "letNull": false,
    "default": "hryvnia",
    "key": "",
    "extra": ""
  },
  "hrn_equivalent": {
    "name": "hrn_equivalent",
    "type": "float",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "direction": {
    "name": "direction",
    "type": {
      "0": "incoming",
      "1": "outcoming"
    },
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;estate_id;amount;currency;hrn_equivalent;direction;
    constructor () {
        super();
    }
}
module.exports = new Bank();