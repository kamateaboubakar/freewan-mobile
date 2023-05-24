import 'package:flutter/material.dart';

class JobOffer {
  final String companyName;
  final String jobTitle;
  final String salary;
  final Color iconBackgroundColor;
  final String icon;

  JobOffer({
    required this.companyName,
    required this.jobTitle,
    required this.salary,
    required this.iconBackgroundColor,
    required this.icon,
  });
}

List<JobOffer> get popularJobs => [
      JobOffer(
        companyName: "Tokopedia - A distance, ID",
        jobTitle: "Senior Project Manager",
        salary: "FCFA 1 500 000 / Mo",
        iconBackgroundColor: Colors.white,
        icon: "assets/images/tokopedia.png",
      ),
      JobOffer(
        companyName: "OLX - Nigeria, ID",
        jobTitle: "Junior Graphic Designer",
        salary: "FCFA 1 500 000 / Mo",
        iconBackgroundColor: const Color(0xff3A77FF).withOpacity(0.1),
        icon: "assets/images/olx.png",
      ),
    ];

List<JobOffer> get jobs => [
      JobOffer(
        companyName: "Google - A distance, ID",
        jobTitle: "FE Developer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xff34A853).withOpacity(0.1),
        icon: "assets/images/grommet-icons_google.png",
      ),
      JobOffer(
        companyName: "Facebook - A distance, MIT",
        jobTitle: "Finance",
        salary: "FCFA 750 000 / Mo",
        iconBackgroundColor: const Color(0xff236CF6).withOpacity(0.1),
        icon: "assets/images/facebook.png",
      ),
      JobOffer(
        companyName: "Bukal - Abidjan, ID",
        jobTitle: "Graphic Designer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xffE31E52).withOpacity(0.1),
        icon: "assets/images/bukalapak-icon-secondary 1.png",
      ),
      JobOffer(
        companyName: "Go4ek - San Pedro, CIV",
        jobTitle: "UX Writer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xff00AA13).withOpacity(0.1),
        icon: "assets/images/go4ek.png",
      ),
      JobOffer(
        companyName: "Apple - A distance, ID",
        jobTitle: "FE Developer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: Colors.black.withOpacity(0.1),
        icon: "assets/images/apple.png",
      ),
      JobOffer(
        companyName: "Twitter - A distance, ID",
        jobTitle: "FE Developer",
        salary: "FCFA 500 000 / Mo",
        iconBackgroundColor: const Color(0xff00ACED).withOpacity(0.1),
        icon: "assets/images/twitter.png",
      ),
    ];
