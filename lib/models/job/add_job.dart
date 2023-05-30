class AddJob {
  int? id;
  int? contractTypeId;
  int? countryId;
  int? companyId;
  int? activitySectorId;
  int? workExperienceId;
  int? categoryId;
  String? label;
  String? workPlace;
  String? expectedSalary;
  String? description;
  bool? available;

  AddJob({
    this.id,
    this.contractTypeId,
    this.countryId,
    this.companyId,
    this.activitySectorId,
    this.workExperienceId,
    this.categoryId,
    this.label = '',
    this.workPlace = '',
    this.expectedSalary = '',
    this.description = '',
    this.available = true,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) data['id'] = id;
    if (contractTypeId != null) data['contractTypeId'] = contractTypeId;
    if (countryId != null) data['countryId'] = countryId;
    if (companyId != null) data['companyId'] = companyId;
    if (activitySectorId != null) data['activitySectorId'] = activitySectorId;
    if (workExperienceId != null) data['workExperienceId'] = workExperienceId;
    if (categoryId != null) data['categoryId'] = categoryId;
    if (label != null) data['label'] = label;
    if (workPlace != null) data['workPlace'] = workPlace;
    if (expectedSalary != null) data['expectedSalary'] = expectedSalary;
    if (description != null) data['description'] = description;
    if (available != null) data['available'] = available;
    return data;
  }
}