class Tontine {
  int? id;
  String? label;
  int? montant, nbParticipants;
  String? methodeReversement;
  String? versement, detailContribution;

  Tontine({
    this.label,
    this.montant,
    this.methodeReversement,
    this.versement,
    this.detailContribution,
    this.nbParticipants,
  });
}
