import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wan_mobile/tools/widgets/wrapper_body_listview.dart';
import 'package:wan_mobile/views/controllers/tontine/tontine_liste_page_vctl.dart';

class HistoriqueTontinePage extends StatelessWidget {
  final TontineListePageVctl ctl;
  const HistoriqueTontinePage(this.ctl, {super.key});

  @override
  Widget build(BuildContext context) {
    return WrapperBodyListView(
      loading: false,
      // emptyText: "Aucune tontine",
      children: [],
    );
  }
}
