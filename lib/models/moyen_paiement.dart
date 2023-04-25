class MoyenPaiement {
  String label;
  String icon;

  bool isMobileMoney;

  MoyenPaiement(
      {required this.label, required this.icon, this.isMobileMoney = true});
}
