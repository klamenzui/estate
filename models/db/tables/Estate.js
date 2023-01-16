const Entity = require("../Entity");
class Estate extends Entity {
    _editable = {"comment":[0,"comment"],"address_id":[2,"address_id"],"house_number":[3,"house_number"],"apartment_number":[4,"apartment_number"],"square":[5,"square"],"photos":[6,"photos"]};
    _fields = {
  "comment": {
    "name": "comment",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
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
  "address_id": {
    "name": "address_id",
    "type": [
      "int",
      11
    ],
    "letNull": false,
    "default": null,
    "key": "MUL",
    "extra": ""
  },
  "house_number": {
    "name": "house_number",
    "type": [
      "varchar",
      10
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "apartment_number": {
    "name": "apartment_number",
    "type": [
      "int",
      10
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "square": {
    "name": "square",
    "type": [
      "int",
      4
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "photos": {
    "name": "photos",
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
    comment;id;address_id;house_number;apartment_number;square;photos;
    constructor () {
        super();
    }
}
module.exports = new Estate();