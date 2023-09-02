import 'package:flutter/material.dart';
import 'package:wan_mobile/views/static/pressing/pages/pages.dart';

class PressingDetailsPage extends StatefulWidget {
  final ScrollController scrollController;
  final Function() togglePanel;

  const PressingDetailsPage(
    this.scrollController, {
    Key? key,
    required this.togglePanel,
  }) : super(key: key);

  @override
  State<PressingDetailsPage> createState() => _PressingDetailsPageState();
}

class _PressingDetailsPageState extends State<PressingDetailsPage> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Center(
          child: InkWell(
            onTap: () {
              if (isOpen) {
                widget.togglePanel();
                toogleView();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width * 0.15,
              height: 8,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: !isOpen
              ? PressingInfoPage(
                  showArticle: () {
                    widget.togglePanel();
                    toogleView();
                  },
                )
              : PressingArticlesPage(showArticle: () {}),
        )
      ],
    );
  }

  void toogleView() {
    setState(() {
      isOpen = !isOpen;
    });
  }
}
