import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';
import 'package:wan_mobile/views/static/job/views/employee/job_list/job_list_view.dart';

import '../../../../../models/job/job_entity.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../job_views.dart';
import 'job_offers_applied_page.dart';

class JobHomePage extends StatefulWidget {
  const JobHomePage({Key? key}) : super(key: key);

  @override
  State<JobHomePage> createState() => _JobHomePageState();
}

class _JobHomePageState extends State<JobHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Emplois"),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const JobOffersAppliedPage());
            },
            icon: const Icon(Icons.list_alt),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Trouvez un bon emploi',
                style: TextStyle(
                  color: Color(0xff0D339F),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CTextFormField(
                      hintText: "Chercher un emploi",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          "assets/images/search.png",
                          width: 5,
                          height: 5,
                        ),
                      ),
                      fillColor: const Color(0xffD8ECFE).withOpacity(.56),
                      hintColor: AssetColors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff0D339F),
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
              const SizedBox(height: 15),
              const Text(
                'Les plus populaires',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AssetColors.grey2,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: popularJobs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var selected = index == 0;
                    var jobs = popularJobs[index];
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Get.to(const JobDescriptionPage());
                        }
                      },
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              selected ? AssetColors.blueButton : Colors.white,
                        ),
                        padding: const EdgeInsets.all(8),
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
                                  const SizedBox(width: 10),
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
                            const SizedBox(height: 10),
                            Text(
                              jobs.jobTitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              jobs.companyName,
                              style: TextStyle(
                                fontSize: 14,
                                color: selected ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: ["Temps plein", "A distance", "Senior"]
                                  .map((e) => JobTag(
                                        title: e,
                                        fontSize: 12,
                                        selected: index == 1,
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
              const SizedBox(height: 25),
              const SizedBox(
                height: 35,
                child: JobSectorView(),
              ),
              const SizedBox(height: 25),
              const JobListView(),
            ],
          ),
        ),
      ),
    );
  }
}
