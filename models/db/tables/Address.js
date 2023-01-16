const Entity = require("../Entity");
class Address extends Entity {
    _editable = {"street":[1,"street"],"city_id":[2,"city_id"],"state_id":[3,"state_id"],"country_id":[4,"country_id"],"zip_code":[5,"zip_code"],"longitude":[6,"longitude"],"latitude":[7,"latitude"]};
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
  "street": {
    "name": "street",
    "type": [
      "varchar",
      255
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "city_id": {
    "name": "city_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": "1",
    "key": "MUL",
    "extra": ""
  },
  "state_id": {
    "name": "state_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "MUL",
    "extra": ""
  },
  "country_id": {
    "name": "country_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": "1",
    "key": "MUL",
    "extra": ""
  },
  "zip_code": {
    "name": "zip_code",
    "type": [
      "varchar",
      10
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "longitude": {
    "name": "longitude",
    "type": [
      "varchar",
      255
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "latitude": {
    "name": "latitude",
    "type": [
      "varchar",
      255
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;street;city_id;state_id;country_id;zip_code;longitude;latitude;
    constructor () {
        super();
    }
}
module.exports = new Address();