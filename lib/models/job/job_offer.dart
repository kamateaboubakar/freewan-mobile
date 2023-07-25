import 'package:wan_mobile/models/job/category.dart';
import 'package:wan_mobile/models/job/jobs_sector.dart';
import 'package:wan_mobile/models/job/work_experience.dart';

import '../pays.dart';
import 'company.dart';
import 'contract_type.dart';

class JobOffer {
  int? id;
  ContractType? contractType;
  JobSector? activitySector;
  JobCategory? category;
  Pays? country;
  Company? company;
  WorkExperience? workExperience;
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
    this.workExperience,
    this.category,
  });

  JobOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contractType = json['contractType'] != null
        ? ContractType.fromJson(json['contractType'])
        : null;
    activitySector = json['activitySector'] != null
        ? JobSector.fromJson(json['activitySector'])
        : null;
    workExperience = json['workExperience'] != null
        ? WorkExperience.fromJson(json['workExperience'])
        : null;

    category = json['category'] != null
        ? JobCategory.fromJson(json['category'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (contractType != null) {
      data['contractType'] = contractType!.toJson();
    }
    if (activitySector != null) {
      data['activitySector'] = activitySector!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['label'] = label;
    data['workPlace'] = workPlace;
    data['expectedSalary'] = expectedSalary;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['available'] = available;
    return data;
  }
}
