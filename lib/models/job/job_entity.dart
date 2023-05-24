import 'package:flutter/material.dart';

class JobEntity {
  final String companyName;
  final String jobTitle;
  final String salary;
  final Color iconBackgroundColor;
  final String icon;

  JobEntity({
    required this.companyName,
    required this.jobTitle,
    required this.salary,
    required this.iconBackgroundColor,
    required this.icon,
  });
}

List<JobEntity> get popularJobs => [
  JobEntity(
    companyName: "Tokopedia - A distance, ID",
    jobTitle: "Senior Project Manager",
    salary: "FCFA 1 500 000 / Mo",
    iconBackgroundColor: Colors.white,
    icon: "assets/images/tokopedia.png",
  ),
  JobEntity(
    companyName: "OLX - Nigeria, ID",
    jobTitle: "Junior Graphic Designer",
    salary: "FCFA 1 500 000 / Mo",
    iconBackgroundColor: Color(0xff3A77FF).withOpacity(0.1),
    icon: "assets/images/olx.png",
  ),
];