import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wan_mobile/tools/utils/tools.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:wan_mobile/views/static/achat_unite/achat_unite_page.dart';
import 'package:wan_mobile/views/static/bills/views/bills_company_selection_dialog.dart';
import 'package:wan_mobile/views/static/boutique/boutique_page.dart';
import 'package:wan_mobile/views/static/construction/construction_page.dart';
import 'package:wan_mobile/views/static/donation/campagne_page.dart';
import 'package:wan_mobile/views/static/gaz/pages/gaz_map_page.dart';
import 'package:wan_mobile/views/static/job/job_views.dart';
import 'package:wan_mobile/views/static/location_vehicule/location_vehicule.dart';
import 'package:wan_mobile/views/static/loyer/loyer_bottom_sheet.dart';
import 'package:wan_mobile/views/static/pressing/pages/pressing_map_page.dart';
import 'package:wan_mobile/views/static/recevoir_paiement/recevoir_paiement.dart';
import 'package:wan_mobile/views/static/tontine/tontine_page.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_selection_dialog.dart';

class CategorizedHomeVctl extends GetxController {
  String selectedCategorie = "Finance";
  var search = "";
  List<String> categories = [
    "Finance",
    "Social",
    "Location",
    "BTP",
    "Abonnement",
    "Paris sportifs",
    "Job",
    "Ticketerie",
    "Achats",
    "Service"
  ];

  List<ButtonMenu> menuItems = [
    ButtonMenu(
      categorie: "Paris sportifs",
      icon: Image.asset("assets/images/42ba0891133d09b46e2e"
          "dd0537c2f2265350876d-1.png"),
      title: "Lonaci",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Paris sportifs",
      icon: Image.asset("assets/images/5b28ce4349be5-"
          "pmu-lonaci-cote-ivoire.png"),
      title: "PMU",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Paris sportifs",
      icon: Image.asset("assets/images/1xbet.png"),
      title: "1xBet",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Paris sportifs",
      icon: Image.asset("assets/images/premier_bet.webp"),
      title: "Premier Bet",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Paris sportifs",
      icon: Image.asset("assets/images/sport_cash.png"),
      title: "Sport cash",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Ticketerie",
      icon: Image.asset("assets/images/icons/icons8-arrêt-de-bus-64.png"),
      title: "Bus et Car",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Ticketerie",
      icon: Image.asset("assets/images/icons8-ticket.gif"),
      title: "Ticket de cinéma",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Ticketerie",
      icon: Image.asset(
        "assets/images/icons/icons8-events-64.png",
      ),
      title: "Evènements",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Service",
      icon: Image.asset("assets/images/icons8-hôtel-5-étoiles-48.png"),
      title: "Hotels",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Ticketerie",
      icon: Image.asset("assets/images/icons8-train-64.png"),
      title: "Métro",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Ticketerie",
      icon: Image.asset("assets/images/icons8-avion-vue-de-face-64.png"),
      title: "Billet d'avion",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "BTP",
      icon: Image.asset(
        "assets/images/icons/icons8-construction-96.png",
      ),
      title: "Construction de maison",
      onPressed: () => Get.to(() => const ConstructionPage()),
    ),
    ButtonMenu(
      categorie: "Finance",
      icon: Image.asset(
        "assets/images/icons8-tirelire.gif",
        // "assets/images/icons/recevoir_argent.png",
      ),
      title: "Recevoir argent",
      onPressed: () => Get.to(() => const RecevoirPaiement()),
    ),
    ButtonMenu(
      categorie: "Finance",
      icon: Image.asset("assets/images/icons8-échange-de-cartes.gif"),
      title: "Transfert bancaire",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Finance",
      icon: Image.asset("assets/images/icons/paiement_loyer.png"),
      title: "Paiement Loyer",
      onPressed: () => Tools.openBottomSheet(const LoyerBottomSheet()),
    ),
    ButtonMenu(
      categorie: "Finance",
      icon: Image.asset("assets/images/icons/paiement_assurance.png"),
      title: "Paiement Assurances",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Job",
      icon: Image.asset("assets/images/icons8-mallette.gif"),
      title: "Job",
      onPressed: () {
        Tools.openBottomSheet(const JobProfileSelectionDialog());
      },
    ),
    ButtonMenu(
      categorie: "Social",
      icon: Image.asset("assets/images/icons8-exchange-money-64.png"),
      title: "Tontine",
      onPressed: () => Get.to(() => const TontinePage()),
    ),
    ButtonMenu(
      categorie: "Social",
      icon: Image.asset("assets/images/icons8-confiance.gif"),
      title: "Don",
      onPressed: () => Get.to(() => const DonationPage()),
    ),
    ButtonMenu(
      categorie: "Location",
      icon: Image.asset("assets/images/icons/icons8-voiture-64.png"),
      title: "Location de véhicule",
      onPressed: () => Get.to(() => const LocationVehicule()),
    ),
    ButtonMenu(
      categorie: "Construction",
      icon: Image.asset("assets/images/icons/icons8-construction-96.png"),
      title: "Construction de maison",
      onPressed: () => Get.to(() => const ConstructionPage()),
    ),
    ButtonMenu(
      categorie: "Achats",
      icon: Image.asset("assets/images/icons/boutique.png"),
      title: "Boutique",
      onPressed: () => Get.to(() => const BoutiquePage()),
    ),
    ButtonMenu(
      categorie: "Service",
      icon: Image.asset("assets/images/icons8-durabilite.gif"),
      title: "Gaz",
      onPressed: () => Get.to(() => const GazMapPage()),
    ),
    ButtonMenu(
      categorie: "Pressing",
      icon: Image.asset("assets/images/icons/icons8-repassage-64.png"),
      title: "Pressing",
      onPressed: () => Get.to(
        () => const PressingMapPage(),
      ),
    ),
    ButtonMenu(
      categorie: "Social",
      icon: Image.asset("assets/images/icons8-cadeau.gif"),
      title: "Cadeau",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Achats",
      icon: Image.asset("assets/images/icons8-liquor-shelf-64.png"),
      title: "Brasserie",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Achats",
      icon: Image.asset("assets/images/icons/achat_unite.png"),
      title: "Achat d’unités",
      onPressed: () => Get.to(() => const AchatUnitePage()),
    ),
    ButtonMenu(
      categorie: "Achats",
      icon: Image.asset("assets/images/icons/acaht_data.png"),
      title: "Achat de pass",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Facture",
      icon: Image.asset("assets/images/icons/facture_electricite.png"),
      title: "Facture d’électricité",
      onPressed: () => Tools.openBottomSheet(
        const BillsCompanySelectionDialog(),
      ),
    ),
    ButtonMenu(
      categorie: "Facture",
      icon: Image.asset("assets/images/icons8-entrepot-96.png"),
      title: "CIE Prépayé",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Facture",
      icon: Image.asset("assets/images/icons/abonnement_tele.png"),
      title: "Abonnement\nTélé",
      onPressed: () {
        Tools.openBottomSheet(const TvBillsSelectionDialog());
      },
    ),
    ButtonMenu(
      categorie: "Abonnement",
      icon: Image.asset("assets/images/icons/abonnement_payage.png"),
      title: "Abonnement\nPéage",
      onPressed: () {},
    ),
    ButtonMenu(
      categorie: "Abonnement",
      icon: Image.asset("assets/images/icons/abonnement_fibre.png"),
      title: "Abonnement\nFibre",
      onPressed: () {},
    ),
  ];
}
