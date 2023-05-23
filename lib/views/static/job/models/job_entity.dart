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
        iconBackgroundColor: const Color(0xff3A77FF).withOpacity(0.1),
        icon: "assets/images/olx.png",
      ),
    ];

List<JobEntity> get jobs => [
      JobEntity(
        companyName: "Google - A distance, ID",
        jobTitle: "FE Developer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xff34A853).withOpacity(0.1),
        icon: "assets/images/grommet-icons_google.png",
      ),
      JobEntity(
        companyName: "Facebook - A distance, MIT",
        jobTitle: "Finance",
        salary: "FCFA 750 000 / Mo",
        iconBackgroundColor: const Color(0xff236CF6).withOpacity(0.1),
        icon: "assets/images/facebook.png",
      ),
      JobEntity(
        companyName: "Bukal - Abidjan, ID",
        jobTitle: "Graphic Designer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xffE31E52).withOpacity(0.1),
        icon: "assets/images/bukalapak-icon-secondary 1.png",
      ),
      JobEntity(
        companyName: "Go4ek - San Pedro, CIV",
        jobTitle: "UX Writer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xff00AA13).withOpacity(0.1),
        icon: "assets/images/go4ek.png",
      ),
      JobEntity(
        companyName: "Apple - A distance, ID",
        jobTitle: "FE Developer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: Colors.black.withOpacity(0.1),
        icon: "assets/images/apple.png",
      ),
      JobEntity(
        companyName: "Twitter - A distance, ID",
        jobTitle: "FE Developer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xff00ACED).withOpacity(0.1),
        icon: "assets/images/twitter.png",
      ),
    ];
