const availableDoctors = {
    "a": "бойлер",
    "b": "кровать",
    "c": "кран",
};
const t_estate = require('../../models/db/tables/Estate');
class Expense {
    object;
    amount;
    date;
    main() {
        return this.add();
    }
    add() {
        let res = '';
        // All the required data to book is present => process the reservation
        if (this.object && this.amount) {
            res = 'Сделано, покупка '+this.object+' на сумму ' + this.amount+(this.date?' '+this.date:'');
        } else {
            this.nextIntent = "expense.add";
            res =  "Прошу прощения, укажи ";

            // The user hasn't provided the name of the doctor => Ask them to choose
            // out of the available ones
            if (!(this.object)) {
                res += "на что были потрачены деньги:\n";
                for (let i = 0; i < Object.keys(availableDoctors).length; i++) {
                    res += availableDoctors[Object.keys(availableDoctors)[i]] + "\n";
                }
            }
            /*
            // The user hasn't given the date or time. Ask them about it, while
            // staying on "user.book" intent.
            if (!(data.date)) {
              res +=  "дату";
            }
            */
            if (!(this.amount)) {
                res +=  "потраченную сумму";
            }
        }
        console.log('Expense:',res);
        return res;
    }
}

module.exports = Expense;