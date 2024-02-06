import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/routes/routes.dart';

class CategorizedHomeVctl extends ViewController {
  late String selectedCategorie;
  Routes routes = Routes();

  CategorizedHomeVctl() {
    selectedCategorie = routes.groupes.first;
  }

  var search = "";
}
