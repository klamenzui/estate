class Payment {
    date;
    price;

    add() {
        let res = '';
        // All the required data to book is present => process the reservation
        res = 'Сделано, добавил оплату '+(this.date?' за '+this.date:'')+', сумма ' + this.price;
        console.log(res);
        return res;
    }
}

module.exports = Payment;