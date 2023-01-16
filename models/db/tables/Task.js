const Entity = require("../Entity");
class Task extends Entity {
    _editable = {"title":[1,"title"],"name":[2,"name"],"data":[3,"data"],"status":[4,"status","{\"0\":\"active\",\"1\":\"closed\"}"],"date_start":[5,"date_start"],"interval":[6,"interval"]};
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
  "title": {
    "name": "title",
    "type": [
      "varchar",
      100
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "name": {
    "name": "name",
    "type": [
      "varchar",
      100
    ],
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "data": {
    "name": "data",
    "type": "text",
    "letNull": false,
    "default": null,
    "key": "",
    "extra": ""
  },
  "status": {
    "name": "status",
    "type": {
      "0": "active",
      "1": "closed"
    },
    "letNull": false,
    "default": "active",
    "key": "",
    "extra": ""
  },
  "date_start": {
    "name": "date_start",
    "type": "timestamp",
    "letNull": false,
    "default": "CURRENT_TIMESTAMP",
    "key": "",
    "extra": ""
  },
  "interval": {
    "name": "interval",
    "type": [
      "char",
      50
    ],
    "letNull": true,
    "default": null,
    "key": "",
    "extra": ""
  }
};
    _primary_key = "id";_auto_increment = "id";
    id;title;name;data;status;date_start;interval;
    constructor () {
        super();
    }
}
module.exports = new Task();