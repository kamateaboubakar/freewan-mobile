import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:wan_mobile/models/numeros_utils/numeros_utils.dart';

class NumerosUtilsHomePage extends StatelessWidget {
  NumerosUtilsHomePage({super.key});

  final List<NumeroUtils> numerosUtils = [
    const NumeroUtils(libelle: "Pompiers", numero: "180"),
    const NumeroUtils(libelle: "Défense nationale", numero: "199"),
    const NumeroUtils(libelle: "Service SAMU", numero: "185"),
    const NumeroUtils(libelle: "Police secours", numero: "110"),
    const NumeroUtils(libelle: "Dépannage SODECI", numero: "175"),
    const NumeroUtils(libelle: "Dépannage CIE", numero: "179"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Numéros utiles")),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, i) {
          var e = numerosUtils[i];
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: Colors.blue.shade50,
            title: Text(
              e.libelle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              e.numero,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            trailing: const Icon(
              Icons.call,
              color: Colors.green,
            ),
            onTap: e.call,
          );
        },
        separatorBuilder: (context, i) => const Gap(10),
        itemCount: numerosUtils.length,
      ),
    );
  }
}
