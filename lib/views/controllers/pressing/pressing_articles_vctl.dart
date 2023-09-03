import 'package:wan_mobile/api/controllers/pressing_api_ctl.dart';
import 'package:wan_mobile/models/pressing/pressing.dart';
import 'package:wan_mobile/models/pressing/pressing_article_category.dart';
import 'package:wan_mobile/models/pressing/pressing_service.dart';
import 'package:wan_mobile/views/controllers/abstracts/view_controller.dart';

import '../../../models/pressing/pressing_article.dart';
import '../../../tools/utils/http_response.dart';

class PressingArticlesController extends ViewController {
  final PressingApiCtl _pressingApiCtl = PressingApiCtl();

  HttpResponse<List<PressingArticleCategory>>? _response;

  HttpResponse<List<PressingArticleCategory>>? get response => _response;

  List<PressingArticleCategory>? _pressingArticleCategories;

  List<PressingArticleCategory>? get pressingArticleCategories =>
      _pressingArticleCategories;

  final List<PressingArticle> _selectedArticles = [];

  List<PressingArticle> get selectedArticles => _selectedArticles;

  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  final List<PressingArticle> _updatePriceArticles = [];

  List<PressingArticle> get updatePriceArticles => _updatePriceArticles;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  increaseQuantity(PressingArticle article) {
    var index =
        _selectedArticles.indexWhere((element) => element.id == article.id);
    if (index == -1) {
      article.quantity = 1;
      _selectedArticles.add(article);
      _computeTotalPrice();
      update();
      return;
    }
    _selectedArticles[index].quantity = _selectedArticles[index].quantity! + 1;
    _computeTotalPrice();
    update();
  }

  decreaseQuantity(PressingArticle article) {
    var index =
        _selectedArticles.indexWhere((element) => element.id == article.id);
    if (index != -1) {
      var existArticle = _selectedArticles[index];
      if (existArticle.quantity! - 1 <= 0) {
        _selectedArticles.removeAt(index);
        _computeTotalPrice();
        update();
        return;
      }
      _selectedArticles[index].quantity =
          _selectedArticles[index].quantity! - 1;
      _computeTotalPrice();
      update();
    }
  }

  getPressingArticle(int pressingId) async {
    _response = null;
    update();
    _response =
        await _pressingApiCtl.getPressingArticles(pressingId: pressingId);
    if (_response!.status) {
      _pressingArticleCategories = response!.data!;
    }
    update();
  }

  bool updateSelectedCategoryIndex(int index) {
    if (index != _selectedCategoryIndex) {
      _selectedCategoryIndex = index;
      update();
      return true;
    }
    return false;
  }

  int get selectedArticleCount => _selectedArticles.fold(0, (prev, current) => prev + current.quantity!);

  void reset() {
    _pressingArticleCategories = null;
    _selectedCategoryIndex = 0;
    _selectedArticles.clear();
    _updatePriceArticles.clear();
    update();
  }

  int getArticleQuantity(PressingArticle article) {
    var index =
        _selectedArticles.indexWhere((element) => element.id == article.id);
    if (index == -1) return 0;
    return _selectedArticles[index].quantity!;
  }

  void getUpdateArticlesPrice(
      Pressing pressing, List<PressingService> selectedServices) async {
    _response = null;

    update();
    var response = await _pressingApiCtl.getUpdateArticlePrice(
        pressing,
        selectedServices,
        _pressingArticleCategories![_selectedCategoryIndex].articles!);
    if (!response.status) {
      _response = HttpResponse.error(message: response.message);
      update();
      return;
    }
    var updateArticles = response.data ?? [];
    _updateArticlePrices(updateArticles);
    _updateSelectedArticlePrices();
    _computeTotalPrice();
    _response = HttpResponse.success(data: _pressingArticleCategories);
    update();
  }

  void _updateArticlePrices(List<PressingArticle> updateArticles) {
    for (int i = 0; i < updateArticles.length; i++) {
      int index = _pressingArticleCategories![_selectedCategoryIndex]
          .articles!
          .indexWhere((element) => element.id == updateArticles[i].id!);
      _pressingArticleCategories![_selectedCategoryIndex]
          .articles![index]
          .price = updateArticles[i].price!;
    }
  }

  void _computeTotalPrice() {
    _totalPrice = _selectedArticles.isEmpty
        ? 0
        : _selectedArticles.fold(
            0,
            (previousValue, element) =>
                previousValue + (element.price! * element.quantity!),
          );
  }

  void _updateSelectedArticlePrices() {
    var articles =
        _pressingArticleCategories![_selectedCategoryIndex].articles!;
    for (int i = 0; i < _selectedArticles.length; i++) {
      var selectedArticle = _selectedArticles[i];
      var articleIndex =
          articles.indexWhere((element) => element.id == selectedArticle.id);
      if (articleIndex != -1) {
        _selectedArticles[i].price = articles[articleIndex].price;
      }
    }
  }
}
