import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';

import '../../../../../tools/const/const.dart';
import '../../../../../tools/widgets/c_button.dart';
import '../../../../../tools/widgets/c_dropdown_field.dart';
import '../../../../../tools/widgets/c_textform_field.dart';
import '../../job_views.dart';

class JobDescriptionPage extends StatefulWidget {
  const JobDescriptionPage({Key? key}) : super(key: key);

  @override
  State<JobDescriptionPage> createState() => _JobDescriptionPageState();
}

class _JobDescriptionPageState extends State<JobDescriptionPage> {
  final TextEditingController _coverLetterCtrl = TextEditingController();

  bool isResumeUploaded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Détails de l’offre"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0xff4F9D4D).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/tokopedia.png',
                              width: 60,
                              height: 60,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Senior Project Manager",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Tokopedia - A distance, ID",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Expanded(
                                        child: JobTag(
                                      title: "Temps plein",
                                      fontSize: 9,
                                    )),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: JobTag(
                                      title: "A distance",
                                      fontSize: 9,
                                    )),
                                    SizedBox(width: 5),
                                    Expanded(
                                        child: JobTag(
                                      title: "Senior",
                                      fontSize: 9,
                                    )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: AssetColors.blueButton,
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Description',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Color(0xffF5F5F5),
                              child: Text(
                                'Entreprise',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AssetColors.grey3),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: AssetColors.grey3,
                            fontFamily: Const.defaultFont.fontFamily,
                          ),
                          children: [
                            TextSpan(
                              text: "Description de l'offre\n",
                              style: TextStyle(
                                color: AssetColors.grey2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "Les chefs de projet jouent le rôle principal dans la planification, l'exécution, le suivi, le contrôle et la clôture des projets. Ils sont responsables de l'ensemble de la portée du projet, de l'équipe et des ressources du projet, du budget du projet et du succès ou de l'échec du projet.\n\n",
                              style: TextStyle(
                                color: AssetColors.grey3,
                              ),
                            ),
                            TextSpan(
                              text: "Pré-requis\n\n",
                              style: TextStyle(
                                color: AssetColors.grey2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: """
\u2022 Licence en informatique, en commerce ou dans un domaine connexe.
\u2022 5 à 8 ans d'expérience en gestion de projet ou dans un domaine connexe
\u2022 Certification de professionnel de la gestion de projet (PMP) souhaitée
\u2022 Capacité avérée à résoudre les problèmes de manière créative
\u2022 Connaissance approfondie des outils logiciels de gestion de projet, des méthodologies et des meilleures pratiques.
\u2022 Expérience de la gestion de projets tout au long de leur cycle de vie
\u2022 Excellentes compétences analytiques
\u2022 Solides compétences interpersonnelles et extrême ingéniosité
\u2022 Capacité avérée à mener à bien des projets en respectant le champ d'application, le budget et le calendrier définis.
                              """,
                              style: TextStyle(
                                color: AssetColors.grey3,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            CButton(
              onPressed: () {
                Get.to(JobApplicationPage());
              },
              height: 48,
              child: const Text(
                "Postuler",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
