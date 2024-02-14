import 'package:lebedoo_assets/lebedoo_assets.dart';

class NumeroUtils {
  final String libelle;
  final String numero;

  const NumeroUtils({required this.libelle, required this.numero});

  void call() => launchUrl(
        Uri.parse("tel:$numero"),
        mode: LaunchMode.externalApplication,
      );
}
