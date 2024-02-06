import 'package:flutter/material.dart';
import 'package:wan_mobile/routes/routes.dart';
import 'package:wan_mobile/routes/tools/actions/go_to_page_action.dart';
import 'package:wan_mobile/tools/widgets/pageable_menu.dart';

class TransactionRecurrenteSection extends StatelessWidget {
  final Routes route;
  const TransactionRecurrenteSection(this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GoToRouteAction.moreUsedRoutes(),
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        } else {
          return PageableMenu(
            title: "Transactions reccurentes",
            children: route
                .routesByList(menus: snapshot.data!.toSet(), sorted: false)
                .map((e) => e.button)
                .toList(),
          );
        }
      },
    );
  }
}
