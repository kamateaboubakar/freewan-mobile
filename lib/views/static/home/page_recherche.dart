import 'package:flutter/material.dart';
import 'package:tools_flutter_project/widgets/c_textform_field.dart';
import 'package:tools_flutter_project/widgets/wrapper_body_listview.dart';

class PageRecherche extends StatelessWidget {
  const PageRecherche({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Recherche"),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CTextFormField(
              autofocus: true,
              hintText: "Recherchez un service",
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Divider(),
          Expanded(
            child: WrapperBodyListView(
              loading: false,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
