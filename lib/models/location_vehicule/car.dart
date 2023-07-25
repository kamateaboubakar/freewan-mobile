import 'package:wan_mobile/models/location_vehicule/image_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/marque_vehicule.dart';
import 'package:wan_mobile/models/location_vehicule/option_vehicule.dart';
import 'package:wan_mobile/tools/types/types.dart';
import 'package:wan_mobile/tools/widgets/location_vehicule/proprietaire_vehicule.dart';

class Car {
  int? id;
  int? brandId;
  MarqueVehicule? brand;
  String? model;
  int? categoryId;
  String? year;
  String? maxSpeed;
  String? transmission;
  String? plateNumber;
  String? energy;
  int? priceWithDriver;
  int? priceWithoutDriver;
  String? power;
  String? motor;
  String? color;
  int? seats;
  String? createdAt;
  String? updatedAt;
  List<Options> options = [];
  List<ImageVehicule> images = [];
  PropietaireVehicule? propietaireVehicule;
  String? ownerId;

  Car(
      {this.id,
      this.brandId,
      this.model,
      this.categoryId,
      this.year,
      this.maxSpeed,
      this.transmission,
      this.plateNumber,
      this.energy,
      this.priceWithDriver,
      this.priceWithoutDriver,
      this.power,
      this.motor,
      this.color,
      this.seats,
      this.createdAt,
      this.updatedAt,
      this.options = const [],
      this.images = const [],
      this.propietaireVehicule,
      this.ownerId});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandId = json['brandId'];
    if (json['brand'] != null) {
      brand = MarqueVehicule.fromJson(json['brand']);
    }
    model = json['model'];
    categoryId = json['categoryId'];
    year = json['year'];
    maxSpeed = json['maxSpeed'];
    transmission = json['transmission'];
    plateNumber = json['plateNumber'];
    energy = json['energy'];
    priceWithDriver = json['priceWithDriver'];
    priceWithoutDriver = json['priceWithoutDriver'];
    power = json['power'];
    motor = json['motor'];
    color = json['color'];
    seats = json['seats'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }

    propietaireVehicule = json['propietaireVehicule'] != null
        ? PropietaireVehicule.fromJson(json['propietaireVehicule'])
        : null;

    if (json["carsPhotos"] is List) {
      images = (json["carsPhotos"] as List)
          .map((e) => ImageVehicule.fromJson(e))
          .toList();
    }
    ownerId = json['ownerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brandId'] = brandId;
    data['model'] = model;
    data['categoryId'] = categoryId;
    data['year'] = year;
    data['maxSpeed'] = maxSpeed;
    data['transmission'] = transmission;
    data['plateNumber'] = plateNumber;
    data['energy'] = energy;
    data['priceWithDriver'] = priceWithDriver;
    data['priceWithoutDriver'] = priceWithoutDriver;
    data['power'] = power;
    data['motor'] = motor;
    data['color'] = color;
    data['seats'] = seats;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['options'] = options.map((v) => v.toJson()).toList();
    data['ownerId'] = ownerId;
    data["carsPhotos"] = images.map((e) => e).toList();
    return data;
  }

  int getTotal(int nbDays, {bool withDriver = false}) {
    var price = (withDriver) ? priceWithDriver : priceWithoutDriver;
    return price.value * nbDays;
  }
}
