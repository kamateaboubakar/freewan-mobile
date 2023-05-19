import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';

import '../../../../../tools/const/const.dart';
import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_dropdown_field.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../job_views.dart';

class JobHomePage extends StatefulWidget {
  const JobHomePage({Key? key}) : super(key: key);

  @override
  State<JobHomePage> createState() => _JobHomePageState();
}

class _JobHomePageState extends State<JobHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    List<String> tags = [
      "Tous",
      "UI Designer",
      "FE Dev",
      "PM",
      "Graphic",
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Emplois"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Trouvez un bon emploi',
                style: TextStyle(
                  color: Color(0xff0D339F),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: CTextFormField(
                        hintText: "Chercher un emploi",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            "assets/images/search.png",
                            width: 5,
                            height: 5,
                          ),
                        ),
                        fillColor: Color(0xffD8ECFE).withOpacity(.56),
                        hintColor: AssetColors.blue,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff0D339F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/job_settings.png',
                      width: 25,
                      height: 25,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Text(
                'Les plus populaires',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AssetColors.grey2,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: popularJobs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var selected = index == 0;
                    var jobs = popularJobs[index];
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Get.to(JobDescriptionPage());
                        }
                      },
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              selected ? AssetColors.blueButton : Colors.white,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: jobs.iconBackgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      jobs.icon,
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      jobs.salary,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: selected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              jobs.jobTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5),
                            Text(
                              jobs.companyName,
                              style: TextStyle(
                                fontSize: 14,
                                color: selected ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: ["Temps plein", "A distance", "Senior"]
                                  .map((e) => JobTag(
                                        title: e,
                                        fontSize: 12,
                                        backgroundColor: selected
                                            ? Colors.white
                                            : Color(0xffF2F2F2),
                                        textColor: AssetColors.blueButton,
                                      ))
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                height: 35,
                child: ListView.separated(
                    itemCount: tags.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      var selected = index == 0;
                      return JobTag(
                        title: tags[index],
                        fontSize: 16,
                        textColor: selected ? Colors.white : AssetColors.grey3,
                        backgroundColor: selected
                            ? AssetColors.blueButton
                            : Color(0xffE0E0E0),
                      );
                    }),
              ),
              SizedBox(height: 25),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return JobItem(
                    canDelete: false,
                    jobEntity: jobs[index],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
