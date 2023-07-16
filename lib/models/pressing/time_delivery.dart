class TimeDeliverySelection {
  final String title;
  final int value;

  TimeDeliverySelection(this.title, this.value);

  static List<TimeDeliverySelection> times = [
    TimeDeliverySelection("Dès que possible", -1),
    TimeDeliverySelection("Maintenant", 0),
    TimeDeliverySelection("Dans 30 minutes", 30),
    TimeDeliverySelection("Dans 45 minutes", 45),
    TimeDeliverySelection("Dans 1 heure", 60),
    TimeDeliverySelection("Dans 2 heures", 120),
  ];
}
