import 'package:wan_mobile/models/job/jobs_sector.dart';

import '../pays.dart';
import 'company.dart';
import 'contract_type.dart';

class JobOffer {
  int? id;
  ContractType? contractType;
  JobSector? activitySector;
  Pays? country;
  Company? company;
  String? label;
  String? workPlace;
  String? expectedSalary;
  String? description;
  String? prerequisites;
  String? createdAt;
  bool? available;
  bool? remote;

  JobOffer({
    this.id,
    this.contractType,
    this.activitySector,
    this.country,
    this.company,
    this.label,
    this.workPlace,
    this.expectedSalary,
    this.description,
    this.createdAt,
    this.available,
    this.remote,
  });

  JobOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractType = json['contractType'] != null
        ? ContractType.fromJson(json['contractType'])
        : null;
    activitySector = json['activitySector'] != null
        ? JobSector.fromJson(json['activitySector'])
        : null;
    country = json['country'] != null ? Pays.fromJson(json['country']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    label = json['label'];
    workPlace = json['workPlace'];
    expectedSalary = json['expectedSalary'];
    description = json['description'];
    createdAt = json['createdAt'];
    available = json['available'];
    prerequisites = json['prerequisites'];
    remote = json['remote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.contractType != null) {
      data['contractType'] = this.contractType!.toJson();
    }
    if (this.activitySector != null) {
      data['activitySector'] = this.activitySector!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['label'] = this.label;
    data['workPlace'] = this.workPlace;
    data['expectedSalary'] = this.expectedSalary;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['available'] = this.available;
    return data;
  }
}
