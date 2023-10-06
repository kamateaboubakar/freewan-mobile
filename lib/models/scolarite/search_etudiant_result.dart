import 'package:wan_mobile/models/scolarite/classe.dart';
import 'package:wan_mobile/models/scolarite/etudiant.dart';
import 'package:wan_mobile/tools/types/types.dart';

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
      classe!.montantFraisScolarite.toInt() - totalPaiement.value;
}
