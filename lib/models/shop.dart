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
        brands!.add(new Brands.fromJson(v));
      });
    }
  }

  bool get isOpen => open == 1;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['available_work_days'] = this.availableWorkDays;
    data['description'] = this.description;
    data['available_week_end_time'] = this.availableWeekEndTime;
    data['available_work_begin_time'] = this.availableWorkBeginTime;
    data['latitude'] = this.latitude;
    data['address'] = this.address;
    data['available_work_end_time'] = this.availableWorkEndTime;
    data['available_week_begin_time'] = this.availableWeekBeginTime;
    data['available_week_days'] = this.availableWeekDays;
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['open'] = this.open;
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
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
    data['description'] = this.description;
    data['id'] = this.id;
    data['picture_name'] = this.pictureName;
    data['name'] = this.name;
    return data;
  }
}
