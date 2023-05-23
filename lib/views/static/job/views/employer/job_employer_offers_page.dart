import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:get/get.dart';

import '../../job_views.dart';
import 'employer_views.dart';

class JobEmployerOffersPage extends StatefulWidget {
  const JobEmployerOffersPage({Key? key}) : super(key: key);

  @override
  State<JobEmployerOffersPage> createState() => _JobEmployerOffersPageState();
}

class _JobEmployerOffersPageState extends State<JobEmployerOffersPage> {
  bool isOfferAdded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Offres"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isOfferAdded ? jobListView() : noOfferView(screenWidth),
      ),
      floatingActionButton: Visibility(
        visible: isOfferAdded,
        child: FloatingActionButton(
          backgroundColor: AssetColors.blueButton,
          onPressed: () => Get.to(const AddJobOfferInformationPage()),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget noOfferView(double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset("assets/images/no_offer.png", height: 200),
        const SizedBox(height: 10),
        const Text(
          'Aucune offre',
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: screenWidth * 0.6,
            child: InkWell(
              onTap: () {
                setState(() {
                  isOfferAdded = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: AssetColors.blueButton,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Stack(
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.add,
                        color: AssetColors.blueButton,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Créer une offre",
                        style: TextStyle(
                            color: AssetColors.blueButton, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget jobListView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return const JobItem();
      },
    );
  }
}
