class Booking {
  int? carId;
  String? startDate;
  String? endDate;
  String? destination;
  String? price;
  int? customer;
  int? userId;
  int? paymentModeId;

  Booking(
      {this.carId,
      this.startDate,
      this.endDate,
      this.destination,
      this.price,
      this.customer,
      this.userId,
      this.paymentModeId});

  Booking.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    destination = json['destination'];
    price = json['price'];
    customer = json['customer'];
    userId = json['userId'];
    paymentModeId = json['paymentModeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = this.carId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['destination'] = this.destination;
    data['price'] = this.price;
    data['customer'] = this.customer;
    data['userId'] = this.userId;
    data['paymentModeId'] = this.paymentModeId;
    return data;
  }
}
