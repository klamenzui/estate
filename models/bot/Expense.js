const availableDoctors = {
    "a": "бойлер",
    "b": "кровать",
    "c": "кран",
};
class Expense {
    object;
    price;
    date;
    add() {
        let res = '';
        // All the required data to book is present => process the reservation
        if (this.object && this.price) {
            res = 'Сделано, покупка '+this.object+' на сумму ' + this.price+(this.date?' '+this.date:'');
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
            if (!(this.price)) {
                res +=  "потраченную сумму";
            }
        }
        console.log(res);
        return res;
    }
}

module.exports = Expense;