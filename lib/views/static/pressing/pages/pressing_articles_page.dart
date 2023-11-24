import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/tools/utils/amount_util.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_articles_vctl.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_services_vctl.dart';
import 'package:wan_mobile/views/static/pressing/pressing_view.dart';
import 'package:wan_mobile/views/static/pressing/widgets/pressing_article_item.dart';
import '../../../controllers/pressing/pressing_vctl.dart';
import '../../paiement/paiement_mode_paiement.dart';
import '../../paiement/paiement_operation_success.dart';

class PressingArticlesPage extends StatefulWidget {
  final Function() showArticle;

  const PressingArticlesPage({
    Key? key,
    required this.showArticle,
  }) : super(key: key);

  @override
  State<PressingArticlesPage> createState() => _PressingArticlesPageState();
}

class _PressingArticlesPageState extends State<PressingArticlesPage> {
  PressingController _pressingController = Get.put(PressingController());
  PressingServiceController _pressingServiceController =
      Get.put(PressingServiceController());

  PressingArticlesController _pressingArticlesController =
      Get.put(PressingArticlesController());

  Pressing? _pressing;

  final DateFormat _dateFormat = DateFormat("HH:mm:ss dd-MM-yyyy");

  bool isLoading = false;

  @override
  void initState() {
    _pressing = _pressingController.pressing;
    _pressingController.resetInfoRecuperation();
    _pressingArticlesController.reset();
    _pressingServiceController.reset();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getPressingArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _pressing?.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Services",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Vous pouvez sélectionner plusieurs services",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff7D8EA3),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 120,
                        child: GetBuilder(
                          init: _pressingServiceController,
                          builder: (controller) {
                            _pressingServiceController = controller;
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var service = _pressingServiceController
                                    .pressingServices![index];
                                var selected = _pressingServiceController
                                    .isSelected(service);
                                return SizedBox(
                                  width: 120,
                                  child: InkWell(
                                    onTap: () {
                                      if (_pressingArticlesController
                                          .pressingArticleCategories!
                                          .isEmpty) return;
                                      _pressingServiceController
                                          .updateSelectedService(service);
                                      if (_pressingServiceController
                                          .hasSelectedServices) {
                                        _getUpdateArticlesPrice();
                                      }
                                    },
                                    child: PressingServiceItem(
                                      image: service.imageUrl,
                                      label: service.name!,
                                      selected: selected,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 20);
                              },
                              itemCount: _pressingServiceController
                                  .pressingServices!.length,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Type d'article",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Vous pouvez sélectionner plusieurs articles",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff7D8EA3),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GetBuilder(
                          init: _pressingArticlesController,
                          builder: (controller) {
                            _pressingArticlesController = controller;
                            var response = _pressingArticlesController.response;
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
                              return InkWell(
                                onTap: () {
                                  _getPressingArticles();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      response.message,
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Icon(Icons.refresh),
                                  ],
                                ),
                              );
                            }

                            var pressingCategories = response.data ?? [];
                            int selectedCategoryIndex =
                                _pressingArticlesController
                                    .selectedCategoryIndex;
                            var articles = pressingCategories.isNotEmpty
                                ? pressingCategories[selectedCategoryIndex]
                                        .articles ??
                                    []
                                : [];

                            if (articles.isEmpty) {
                              return const Center(
                                child: Text('Aucun article'),
                              );
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: ListView.separated(
                                      itemCount: pressingCategories.length,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(width: 10),
                                      itemBuilder: (context, index) {
                                        var pressingCategory =
                                            pressingCategories[index];
                                        var selected =
                                            index == selectedCategoryIndex;
                                        return PressingArticleTag(
                                          title: pressingCategory.name!,
                                          fontSize: 14,
                                          selected: selected,
                                          onTap: () {
                                            var result =
                                                _pressingArticlesController
                                                    .updateSelectedCategoryIndex(
                                                        index);
                                            if (result &&
                                                _pressingServiceController
                                                    .hasSelectedServices) {
                                              _getUpdateArticlesPrice();
                                            }
                                          },
                                        );
                                      }),
                                ),
                                const SizedBox(height: 10),
                                GridView.builder(
                                  itemCount: articles.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                          childAspectRatio: 2 / 2.5),
                                  itemBuilder: (context, index) {
                                    var article = articles[index];
                                    var quantity = _pressingArticlesController
                                        .getArticleQuantity(article);

                                    return PressingArticleItem(
                                      item: article,
                                      increase: () {
                                        if (_pressingServiceController
                                            .hasSelectedServices) {
                                          _pressingArticlesController
                                              .increaseQuantity(article);
                                        }
                                      },
                                      decrease: () {
                                        if (_pressingServiceController
                                            .hasSelectedServices) {
                                          _pressingArticlesController
                                              .decreaseQuantity(article);
                                        }
                                      },
                                      quantity: quantity,
                                    );
                                  },
                                ),
                              ],
                            );
                          }),
                      const SizedBox(height: 15),
                      const Text(
                        'Heure de récupération du linge',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.to(const PressingHourSelectionPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AssetColors.blueButton.withOpacity(0.15),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset('assets/images/pin.png',
                                        width: 10),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: GetBuilder(
                                        init: _pressingController,
                                        builder: (controller) {
                                          _pressingController = controller;
                                          var deliveryTime = _pressingController
                                              .timeDeliverySelection;
                                          var deliveryHour =
                                              _pressingController.deliveryHour;
                                          return Text(
                                            deliveryHour != null
                                                ? deliveryHour.format(context)
                                                : deliveryTime.title,
                                            style: const TextStyle(
                                                color: AssetColors.blueButton),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Lieu de récupération du linge',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.to(const PressingDeliveryAddressPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AssetColors.blueButton.withOpacity(0.15),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 18),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Utiliser cette localisation',
                                    ),
                                    Row(
                                      children: [
                                        Image.asset('assets/images/pin.png',
                                            width: 10),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: GetBuilder(
                                            init: _pressingController,
                                            builder: (controller) {
                                              _pressingController = controller;
                                              var userLocalisation =
                                                  _pressingController
                                                      .userLocalisation;
                                              return Text(
                                                userLocalisation?.address ??
                                                    'Sélectionner votre adresse',
                                                style: const TextStyle(
                                                  color: AssetColors.blueButton,
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        trailing: Checkbox(
                          value: false,
                          onChanged: (value) {},
                          checkColor: const Color.fromRGBO(229, 229, 229, 1),
                        ),
                        title: const Text(
                          'Utiliser comme lieu de livraison du linge',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        GetBuilder(
            init: _pressingArticlesController,
            builder: (controller) {
              _pressingArticlesController = controller;
              var articleCount =
                  _pressingArticlesController.selectedArticleCount;
              var totalAmount = _pressingArticlesController.totalPrice;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      // Shadow color
                      spreadRadius: 5,
                      // Spread radius
                      blurRadius: 10,
                      // Blur radius
                      offset: const Offset(0, 3), // Offset
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFC5E93).withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Total',
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      articleCount == 0 || articleCount == 1
                                          ? '$articleCount article'
                                          : '$articleCount articles',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Text(
                                    totalAmount.toString().formatAmount,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                    CButton(
                      height: 50,
                      onPressed: () {
                        if (isFormValid(articleCount)) {
                          _submitPayment();
                          //Get.to(const PressingPaymentRecapPage());
                        }
                      },
                      color: isFormValid(articleCount)
                          ? AssetColors.blueButton
                          : const Color(0xffEDF2F9),
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Text(
                              "Payer",
                              style: TextStyle(
                                color: isFormValid(articleCount)
                                    ? Colors.white
                                    : const Color(0xffB5C4D8),
                              ),
                            ),
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }

  bool isFormValid(int articleCount) =>
      articleCount > 0 && _pressingController.hasUserLocalisation;

  void _getUpdateArticlesPrice() {
    _pressingArticlesController.getUpdateArticlesPrice(
        _pressing!, _pressingServiceController.selectedServices);
  }

  void _getPressingArticles() {
    _pressingArticlesController.getPressingArticle(_pressing!.id ?? 0);
  }

  _submitPayment() async {
    var rep =
        await Tools.showChoiceMessage(message: "Confirmez-vous le paiement ?");
    if (rep == true) {
      var page = Get.currentRoute;
      await Get.to(
        () => PaiementModePaiement(
          route: page,
          motifPaiement: "Paiement de pressing",
          montant: _pressingArticlesController.totalPrice.toInt(),
          frais: 0,
          service: "Paiement Pressing",
        ),
      );

      var result = Get.parameters['paiementResult'];
      if (result == "true") {
        _submitOrder();
      } else {
        Tools.messageBox(
            message: "Désolé, le paiement n'a pas pu être effectué.");
      }
    }
  }

  void _submitOrder() async {
    var pr = Tools.progressDialog(isDismissible: true);
    pr.show();
    var currentDate = DateTime.now();
    var recuperationDate = '';
    if (_pressingController.deliveryHour != null) {
      var deliveryHour = _pressingController.deliveryHour!;
      var hours = deliveryHour.hour < 10
          ? "0${deliveryHour.hour}"
          : "${deliveryHour.hour}";
      var minutes = deliveryHour.minute < 10
          ? '0${deliveryHour.minute}'
          : deliveryHour.minute;
      recuperationDate =
          "$hours:$minutes:00 ${currentDate.day < 10 ? '0${currentDate.day}' : currentDate.day}-${currentDate.month < 10 ? '0${currentDate.month}' : currentDate.month}-${currentDate.year}";
    } else {
      recuperationDate = _dateFormat.format(currentDate.add(
          Duration(minutes: _pressingController.timeDeliverySelection.value)));
    }

    var response = await _pressingController.submitOrder(
      userLocalisation: _pressingController.userLocalisation!,
      pressingId: _pressingController.pressing!.id!,
      articles: _pressingArticlesController.selectedArticles,
      services: _pressingServiceController.selectedServices,
      totalAmount: _pressingArticlesController.totalPrice,
      recuperationDate: recuperationDate,
    );
    Get.back();
    if (!response.status) {
      Tools.messageBox(message: response.message);
      return;
    }

    Get.to(
      () => const PaiementOperationSucess(
        animationAsset: "assets/lotties/88063-delivery-icon.json",
        description: "Nous venons récupérer votre\nlinge à l’heure indiquée",
      ),
    );
  }
}
