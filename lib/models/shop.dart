class Shop {
  String? availableWorkDays;
  String? description;
  String? availableWeekEndTime;
  String? availableWorkBeginTime;
  double? latitude;
  String? address;
  String? availableWorkEndTime;
  String? availableWeekBeginTime;
  String? availableWeekDays;
  int? id;
  String? name;
  double? longitude;
  int? open;
  List<Brands>? brands;

  Shop(
      {this.availableWorkDays,
      this.description,
      this.availableWeekEndTime,
      this.availableWorkBeginTime,
      this.latitude,
      this.address,
      this.availableWorkEndTime,
      this.availableWeekBeginTime,
      this.availableWeekDays,
      this.id,
      this.name,
      this.longitude,
      this.open,
      this.brands});

  Shop.fromJson(Map<String, dynamic> json) {
    availableWorkDays = json['available_work_days'];
    description = json['description'];
    availableWeekEndTime = json['available_week_end_time'];
    availableWorkBeginTime = json['available_work_begin_time'];
    latitude = json['latitude'];
    address = json['address'];
    availableWorkEndTime = json['available_work_end_time'];
    availableWeekBeginTime = json['available_week_begin_time'];
    availableWeekDays = json['available_week_days'];
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    open = json['open'];
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
  }

  bool get isOpen => open == 1;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['available_work_days'] = availableWorkDays;
    data['description'] = description;
    data['available_week_end_time'] = availableWeekEndTime;
    data['available_work_begin_time'] = availableWorkBeginTime;
    data['latitude'] = latitude;
    data['address'] = address;
    data['available_work_end_time'] = availableWorkEndTime;
    data['available_week_begin_time'] = availableWeekBeginTime;
    data['available_week_days'] = availableWeekDays;
    data['id'] = id;
    data['name'] = name;
    data['longitude'] = longitude;
    data['open'] = open;
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  String? description;
  int? id;
  String? pictureName;
  String? name;

  Brands({this.description, this.id, this.pictureName, this.name});

  Brands.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    pictureName = json['picture_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['description'] = description;
    data['id'] = id;
    data['picture_name'] = pictureName;
    data['name'] = name;
    return data;
  }
}
