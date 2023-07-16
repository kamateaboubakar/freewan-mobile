import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/tools/utils/amount_util.dart';
import 'package:wan_mobile/tools/utils/asset_colors.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_articles_vctl.dart';
import 'package:wan_mobile/views/controllers/pressing/pressing_services_vctl.dart';
import 'package:wan_mobile/views/static/pressing/pages/pressing_hour_selection_page.dart';
import 'package:wan_mobile/views/static/pressing/pressing_view.dart';
import 'package:wan_mobile/views/static/pressing/widgets/pressing_article_item.dart';

import '../../../../tools/widgets/c_button.dart';
import '../../../../tools/widgets/payment_account_selection_item.dart';
import '../../../controllers/pressing/pressing_vctl.dart';
import '../../job/widgets/job_tag.dart';

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

  @override
  void initState() {
    _pressing = _pressingController.pressing;
    _pressingController.resetInfoRecuperation();
    _pressingArticlesController.reset();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getPressingArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                SizedBox(height: 20),
                Text(
                  "Services",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Vous pouvez sélectionner plusieurs services",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff7D8EA3),
                  ),
                ),
                SizedBox(height: 20),
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
                          var selected =
                              _pressingServiceController.isSelected(service);
                          return SizedBox(
                            width: 120,
                            child: InkWell(
                              onTap: () {
                                if (_pressingArticlesController
                                    .pressingArticleCategories!.isEmpty) return;
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
                          return SizedBox(width: 20);
                        },
                        itemCount:
                            _pressingServiceController.pressingServices!.length,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Type d'article",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Vous pouvez sélectionner plusieurs articles",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff7D8EA3),
                  ),
                ),
                SizedBox(height: 20),
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
                          _pressingArticlesController.selectedCategoryIndex;
                      var articles = pressingCategories.isNotEmpty
                          ? pressingCategories[selectedCategoryIndex]
                                  .articles ??
                              []
                          : [];

                      if (articles.isEmpty) {
                        return Center(
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
                                  var selected = index == selectedCategoryIndex;
                                  return PressingArticleTag(
                                    title: pressingCategory.name!,
                                    fontSize: 14,
                                    selected: selected,
                                    onTap: () {
                                      var result = _pressingArticlesController
                                          .updateSelectedCategoryIndex(index);
                                      if (result) {
                                        _getUpdateArticlesPrice();
                                      }
                                    },
                                  );
                                }),
                          ),
                          SizedBox(height: 10),
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
                                  _pressingArticlesController
                                      .increaseQuantity(article);
                                },
                                decrease: () {
                                  _pressingArticlesController
                                      .decreaseQuantity(article);
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
                  onTap: (){
                      Get.to(PressingHourSelectionPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AssetColors.blueButton.withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset('assets/images/pin.png', width: 10),
                              const SizedBox(width: 5),
                              Expanded(
                                child: GetBuilder(
                                  init: _pressingController,
                                  builder: (controller){
                                    _pressingController = controller;
                                    var deliveryTime = _pressingController.timeDeliverySelection;
                                    var deliveryHour = _pressingController.deliveryHour;
                                    return Text(
                                      deliveryHour != null ? deliveryHour.format(context) : deliveryTime.title,
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AssetColors.blueButton.withOpacity(0.15),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
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
                                Image.asset('assets/images/pin.png', width: 10),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    'Rue M66',
                                    style: const TextStyle(
                                        color: AssetColors.blueButton),
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
                ListTile(
                  trailing: Checkbox(
                    value: false,
                    onChanged: (value) {},
                    checkColor: const Color.fromRGBO(229, 229, 229, 1),
                  ),
                  title: Text(
                    'Utiliser comme lieu de livraison du linge',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Paiement',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                PaiementAccountSelectionItem(
                  title: "**** **** **** **02",
                  onTap: () {},
                  image: 'assets/images/master_card.png',
                  imageWidth: 25,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 10),
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
                        offset: Offset(0, 3), // Offset
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFC5E93).withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(8),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        articleCount == 0 || articleCount == 1
                                            ? '${articleCount} article'
                                            : '${articleCount} articles',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Text(
                                      totalAmount.toString().formatAmount,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                      CButton(
                        height: 50,
                        onPressed: () {},
                        color: articleCount > 0
                            ? AssetColors.blueButton
                            : const Color(0xffEDF2F9),
                        child: Text(
                          "Payer",
                          style: TextStyle(
                            color: articleCount > 0
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
      ),
    );
  }

  void _getUpdateArticlesPrice() {
    _pressingArticlesController.getUpdateArticlesPrice(
        _pressing!, _pressingServiceController.selectedServices);
  }

  void _getPressingArticles() {
    _pressingArticlesController.getPressingArticle(_pressing!.id ?? 0);
  }
}
