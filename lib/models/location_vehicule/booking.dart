import 'package:tools_flutter_project/tools_flutter_project.dart';

class Booking {
  int? carId;
  String? startDate;
  String? endDate;
  String? destination;
  String? price;
  String? customer;
  String? userId;
  int? paymentModeId;
  double? lat, long;
  String? creditCardOrPhoneNumber;

  Booking(
      {this.carId,
      this.startDate,
      this.endDate,
      this.destination,
      this.price,
      this.customer,
      this.userId,
      this.paymentModeId,
      this.lat,
      this.long,
      this.creditCardOrPhoneNumber});

  Booking.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    destination = json['destination'];
    price = json['price'];
    customer = json['customer'];
    userId = json['userId'];
    paymentModeId = json['paymentModeId'];
    lat = json['latitude'];
    long = json['longitude'];
    creditCardOrPhoneNumber = json['creditCardOrPhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carId'] = carId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['destinationAddress'] = destination;
    data['price'] = price;
    data['customer'] = customer.value;
    data['userId'] = userId;
    data['paymentModeId'] = paymentModeId;
    data['latitude'] = lat;
    data['longitude'] = long;
    data['creditCardOrPhoneNumber'] = creditCardOrPhoneNumber;
    return data;
  }
}
