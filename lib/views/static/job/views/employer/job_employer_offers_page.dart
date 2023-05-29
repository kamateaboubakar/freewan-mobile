import 'package:flutter/material.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/views/controllers/job/job_list_vctl.dart';
import 'package:wan_mobile/views/controllers/job/job_offer_employer_vctl.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';

import '../../../../../models/job/job_offer.dart';
import '../../../../../tools/widgets/error_view.dart';
import '../../job_views.dart';
import 'employer_views.dart';

class JobEmployerOffersPage extends StatefulWidget {
  const JobEmployerOffersPage({Key? key}) : super(key: key);

  @override
  State<JobEmployerOffersPage> createState() => _JobEmployerOffersPageState();
}

class _JobEmployerOffersPageState extends State<JobEmployerOffersPage> {
  JobOfferEmployerController _jobOfferEmployerController =
      Get.put(JobOfferEmployerController());
  final JobListController _jobListController = Get.put(JobListController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getJobOfferEmployer();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isOfferAdded = true;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Offres"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder(
          init: _jobOfferEmployerController,
          builder: (controller) {
            _jobOfferEmployerController = controller;
            var response = controller.response;

            if (response == null) {
              return const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (!response.status) {
              return ErrorView(
                message: response.message,
                retry: () {
                  _getJobOfferEmployer();
                },
              );
            }

            var jobOffers = response.data ?? [];

            if (jobOffers.isEmpty) {
              return noOfferView(screenWidth);
            }

            return jobListView(jobOffers);
          },
        ),
      ),
      floatingActionButton: GetBuilder(
        init: _jobOfferEmployerController,
        builder: (controller){
          _jobOfferEmployerController = controller;
          var response = _jobOfferEmployerController.response;
          if(response == null){
            return Container();
          }

          if(!response.status){
            return Container();
          }

          var jobOffers = response.data ?? [];

          if(jobOffers.isEmpty){
            return Container();
          }

          return FloatingActionButton(
            backgroundColor: AssetColors.blueButton,
            onPressed: () => Get.to(const AddJobOfferInformationPage()),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          );
        },
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
                Get.to(AddJobOfferInformationPage());
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

  Widget jobListView(List<JobOffer> jobOffers) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: jobOffers.length,
      itemBuilder: (context, index) {
        var jobOffer = jobOffers[index];
        return JobItem(
          jobEntity: jobOffer,
          canDelete: true,
          onTap: () {
            _jobListController.updateSelectedJobOffer(jobOffer);
            _jobListController.updateEditPostState(true);
            _jobListController.updateAlreadySubmitApplicationState();
            Get.to(JobDescriptionPage());
          },
          deleteCall: () async {
            var result = await Tools.showChoiceMessage(
                message: "Voulez-vous supprimer cette offre ?");
            if (result != null && result) {
              _deleteJobOffer(jobOffer);
            }
          },
        );
      },
    );
  }

  _getJobOfferEmployer() {
    _jobOfferEmployerController.getJobOffers();
  }

  _deleteJobOffer(JobOffer jobOffer) async {
    var pr = Tools.progressDialog();
    pr.show();
    var response = await _jobOfferEmployerController.deleteJobOffer(jobOffer.id!);
    Get.back();
    Tools.messageBox(message: response.status ? "Offre d'emploi supprimée" : response.message, onConfirm: (){
      if(response.status){
        _getJobOfferEmployer();
      }
    });
  }
}
