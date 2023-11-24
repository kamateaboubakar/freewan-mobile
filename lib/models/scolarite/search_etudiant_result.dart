import 'package:tools_flutter_project/tools/types/int.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/scolarite/classe.dart';
import 'package:wan_mobile/models/scolarite/etudiant.dart';

class SearchEtudiantResult {
  Etudiant? etudiant;
  Classe? classe;
  int? totalPaiement;

  SearchEtudiantResult({
    this.etudiant,
    this.classe,
  });

  SearchEtudiantResult.fromJson(Map<String, dynamic> json) {
    totalPaiement = json['total_paiement'] ?? 0;
    etudiant =
        json['etudiant'] != null ? Etudiant.fromJson(json['etudiant']) : null;
    classe = json['classe'] != null ? Classe.fromJson(json['classe']) : null;
  }

  int? get resteAPayer =>
      classe!.montantFraisScolarite.toInt().value - totalPaiement.value;
}
