import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job/job.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_assets/tools/web/app_http_hearders.dart';
import 'package:pharmacie/views/static/pharmacie_home_page.dart';
import 'package:tools_flutter_project/functions/tools.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';

import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/achat_fibre/achat_fibre_page.dart';
import 'package:wan_mobile/views/static/achat_pass/achat_pass_page.dart';
import 'package:wan_mobile/views/static/achat_unite/achat_unite_page.dart';
import 'package:wan_mobile/views/static/bills/bills_views.dart';
import 'package:wan_mobile/views/static/boutique/boutique_page.dart';
import 'package:wan_mobile/views/static/construction/construction_page.dart';
import 'package:wan_mobile/views/static/donation/campagne_page.dart';
import 'package:wan_mobile/views/static/envoyer_vers_mobile/envoyer_vers_mobile.dart';
import 'package:wan_mobile/views/static/gaz/gaz_view.dart';
import 'package:wan_mobile/views/static/home/categorized_home.dart';
import 'package:wan_mobile/views/static/home/more_option_home_page.dart';
import 'package:wan_mobile/views/static/lebedoo/lebedoo_page.dart';
import 'package:wan_mobile/views/static/location_vehicule/location_vehicule.dart';
import 'package:wan_mobile/views/static/loyer/loyer_bottom_sheet.dart';
import 'package:wan_mobile/views/static/peage/peage_page.dart';
import 'package:wan_mobile/views/static/pressing/pressing_view.dart';
import 'package:wan_mobile/views/static/recevoir_paiement/recevoir_paiement.dart';
import 'package:wan_mobile/views/static/scolarite/scolarite_page.dart';
import 'package:wan_mobile/views/static/solde_historique/solde_historique_page.dart';
import 'package:wan_mobile/views/static/tontine/tontine_page.dart';
import 'package:wan_mobile/views/static/tv_bills/tv_bills_selection_dialog.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';
import 'package:wan_mobile/views/tools/route_item.dart';

class Routes extends ViewController {
  List<RouteItem> get routes => [
        RouteItem(
          groupe: "Mobile money",
          menuButtonEnum: MenuButtonEnum.envoyerVersMobile,
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons8-envoyé.gif",
            ),
            title: "Envoyer vers mobile",
            onPressed: () => Get.to(() => const EnvoyerVersMobilePage()),
          ),
        ),
        RouteItem(
          groupe: "Mobile money",
          menuButtonEnum: MenuButtonEnum.recevoirArgent,
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons8-tirelire.gif",
            ),
            title: "Recevoir argent",
            onPressed: () => Get.to(() => const RecevoirPaiement()),
          ),
        ),
        RouteItem(
          groupe: "Banques",
          menuButtonEnum: MenuButtonEnum.bankEtMicrofinance,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons8-échange-de-cartes.gif"),
            title: "Banks &\nmicrofinances",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Mobile money",
          menuButtonEnum: MenuButtonEnum.lebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/mon_bedoo.png"),
            title: "Lebedoo",
            onPressed: () => Get.to(() => const LebedooPage()),
          ),
        ),
        RouteItem(
          groupe: "Comptes",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/historique_transaction.png"),
            title: "Solde & historique",
            onPressed: () => Get.to(() => const SoldeHistoriquePage()),
          ),
          menuButtonEnum: MenuButtonEnum.soldeHistorique,
        ),
        RouteItem(
          groupe: "Finance",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/paiement_loyer.png"),
            title: "Paiement Loyer",
            onPressed: () => Tools.openBottomSheet(const LoyerBottomSheet()),
          ),
          menuButtonEnum: MenuButtonEnum.paiementLoyer,
        ),
        RouteItem(
          groupe: "Service",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons/paiement_assurance.png",
            ),
            title: "Assurances",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.assurances,
        ),
        RouteItem(
          groupe: "Service",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons8-mallette.gif",
            ),
            title: "Job",
            onPressed: () => Get.to(
              () => JobPage(
                user: user,
                jwtToken: AppHttpHeaders.jwtToken,
              ),
            ),
          ),
          menuButtonEnum: MenuButtonEnum.job,
        ),
        RouteItem(
          groupe: "Social",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons8-exchange-money-64.png",
            ),
            title: "Tontine",
            onPressed: () => Get.to(() => const TontinePage()),
          ),
          menuButtonEnum: MenuButtonEnum.tontine,
        ),
        RouteItem(
            groupe: "Social",
            button: ButtonMenu(
              icon: Image.asset(
                "assets/images/icons8-confiance.gif",
              ),
              title: "Don",
              onPressed: () => Get.to(() => const DonationPage()),
            ),
            menuButtonEnum: MenuButtonEnum.don),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons/icons8-voiture-64.png",
            ),
            title: "Location de véhicule",
            onPressed: () => Get.to(() => const LocationVehicule()),
          ),
          menuButtonEnum: MenuButtonEnum.locationDeVehicule,
        ),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons/icons8-construction-96.png",
            ),
            title: "Construction de maison",
            onPressed: () => Get.to(() => const ConstructionPage()),
          ),
          menuButtonEnum: MenuButtonEnum.constructionDeMaison,
        ),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/pharmacie.png"),
            title: "Pharmacies",
            onPressed: () => Get.to(() => const PharmacieHomePage()),
          ),
          menuButtonEnum: MenuButtonEnum.pharmacies,
        ),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset("assets/images/restaurant.png"),
            title: "Restaurants",
            onPressed: () => Get.to(() => const BoutiquePage()),
          ),
          menuButtonEnum: MenuButtonEnum.restaurants,
        ),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons8-durabilite.gif",
            ),
            title: "Gaz",
            onPressed: () => Get.to(() => const GazMapPage()),
          ),
          menuButtonEnum: MenuButtonEnum.gaz,
        ),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons/icons8-repassage-64.png",
            ),
            title: "Pressing",
            onPressed: () => Get.to(
              () => const PressingMapPage(),
            ),
          ),
          menuButtonEnum: MenuButtonEnum.pressing,
        ),
        RouteItem(
          groupe: "Service",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons8-cadeau.gif"),
            title: "Cadeau",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.cadeau,
        ),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons8-liquor-shelf-64.png"),
            title: "Brasserie",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.brasserie,
        ),
        RouteItem(
          groupe: "Service de proximité",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/caves.png"),
            title: "Caves",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.caves,
        ),
        RouteItem(
          groupe: "Service mobile",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/achat_unite.png"),
            title: "Achat d’unités",
            onPressed: () => Get.to(() => const AchatUnitePage()),
          ),
          menuButtonEnum: MenuButtonEnum.achatDUnite,
        ),
        RouteItem(
          groupe: "Service mobile",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/acaht_data.png"),
            title: "Achat de pass",
            onPressed: () => Get.to(() => const AchatPassPage()),
          ),
          menuButtonEnum: MenuButtonEnum.achatPass,
        ),
        RouteItem(
          groupe: "Factures",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/facture_electricite.png"),
            title: "Facture d’électricité",
            onPressed: () => Tools.openBottomSheet(
              const BillsCompanySelectionDialog(),
            ),
          ),
          menuButtonEnum: MenuButtonEnum.factureElectricite,
        ),
        RouteItem(
          groupe: "Factures",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/facture_eau.png"),
            title: "Facture d'eau",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.factureEau,
        ),
        RouteItem(
          groupe: "Factures",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_tele.png"),
            title: "Abonnement\nTélé",
            onPressed: () {
              Tools.openBottomSheet(const TvBillsSelectionDialog());
            },
          ),
          menuButtonEnum: MenuButtonEnum.abonnementTele,
        ),
        RouteItem(
            groupe: "Factures",
            button: ButtonMenu(
              icon: Image.asset("assets/images/icons/abonnement_payage.png"),
              title: "Abonnement\nPéage",
              onPressed: () => Get.to(() => const PeagePage()),
            ),
            menuButtonEnum: MenuButtonEnum.abonnementPeage),
        RouteItem(
          groupe: "Factures",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_fibre.png"),
            title: "Abonnement\nFibre",
            onPressed: () => Get.to(() => const AchatFibrePage()),
          ),
          menuButtonEnum: MenuButtonEnum.abonnementFibre,
        ),
        RouteItem(
          isFeature: false,
          button: ButtonMenu(
            icon: const CircleAvatar(
              backgroundColor: Color.fromRGBO(50, 132, 229, 0.16),
              child: Icon(
                Icons.arrow_forward,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            title: "Voir Plus",
            onPressed: () => Get.to(() => const MoreOptionHomePage()),
          ),
          menuButtonEnum: MenuButtonEnum.voirPlus,
        ),
        RouteItem(
          groupe: "Finance",
          button: ButtonMenu(
            icon:
                Image.asset("assets/images/icons/icons8-etudiant-homme-64.png"),
            title: "Scolarité",
            onPressed: () => Get.to(() => const ScolaritePage()),
          ),
          menuButtonEnum: MenuButtonEnum.scolarite,
        ),
        RouteItem(
          groupe: "Finance",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-casino-48.png"),
            title: "Lebedoo Jackpot",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.lebedooJackpot,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-roulette-80.png"),
            title: "La roulette de Lebedoo",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.laRouletteDeLebedoo,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-bet-62.png"),
            title: "Paris sportifs",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.parisSportifs,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-horse-racing-96.png"),
            title: "Paris courses de chevaux",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.parisCoursesDeChevaux,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/betclic.svg.png",
              height: 40,
            ),
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.betclic,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/5b28ce4349be5-"
              "pmu-lonaci-cote-ivoire.png",
              height: 40,
            ),
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.pmu,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/1xbet.png",
              height: 40,
            ),
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.oneXbet,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/premier_bet.jpg",
              height: 40,
            ),
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.premierBet,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/sportcash.png",
              height: 40,
            ),
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.sportCash,
        ),
        RouteItem(
          groupe: "Jeu hasard",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/casinocash.png",
              width: 100,
            ),
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.casinoCash,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons/icons8-google-play-store-96.png",
            ),
          ),
          menuButtonEnum: MenuButtonEnum.googlePlayStore,
        ),
        RouteItem(
          isFeature: false,
          button: ButtonMenu(
            icon: const CircleAvatar(
              backgroundColor: Color.fromRGBO(50, 132, 229, 0.16),
              child: Icon(
                Icons.arrow_forward,
                color: Color.fromRGBO(7, 21, 60, 1),
              ),
            ),
            title: "Voir Plus",
            onPressed: () => Get.to(() => const CategorizedHome()),
          ),
          menuButtonEnum: MenuButtonEnum.voirPlusCategorie,
        ),
        RouteItem(
          groupe: "Transport",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bus_car.png"),
            title: "Bus et Car",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.busEtCar,
        ),
        RouteItem(
          groupe: "Loisir",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons8-ticket.gif"),
            title: "Ticket de cinéma",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.ticketDeCinema,
        ),
        RouteItem(
          groupe: "Loisir",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons/icons8-events-64.png",
            ),
            title: "Evènements",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.evenements,
        ),
        RouteItem(
            groupe: "Hébergement",
            button: ButtonMenu(
              icon: Image.asset("assets/images/icons8-hôtel-5-étoiles-48.png"),
              title: "Hotels",
              onPressed: () {},
            ),
            menuButtonEnum: MenuButtonEnum.hotels),
        RouteItem(
          groupe: "Transport",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons8-avion-vue-de-face-64.png"),
            title: "Billet d'avion",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.billetDavion,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/playstation_store.png",
            ),
          ),
          menuButtonEnum: MenuButtonEnum.playstationStore,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/Xbox_store.jpg",
            ),
          ),
          menuButtonEnum: MenuButtonEnum.xboxStore,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/Steam_icon.png",
            ),
          ),
          menuButtonEnum: MenuButtonEnum.steam,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/Logo_App_Store_Apple.png",
            ),
          ),
          menuButtonEnum: MenuButtonEnum.appleStore,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/Virgin-logo.png",
            ),
          ),
          menuButtonEnum: MenuButtonEnum.virgin,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/Nintendo_logo.png",
            ),
          ),
          menuButtonEnum: MenuButtonEnum.nintendoStore,
        ),
        RouteItem(
          groupe: "Jeu",
          button: ButtonMenu(
            icon: Image.asset(
                "assets/images/icons/icons8-google-play-store-96.png"),
            title: "Google Play Recharge",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.googlePlayRecharge,
        ),
        RouteItem(
          groupe: "Banques",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/pret.png"),
            title: "Paiement prêts",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.payementPrets,
        ),
        RouteItem(
          groupe: "Banques",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/scolarite.png"),
            title: "Scolarité",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.pretScolarite,
        ),
        RouteItem(
          groupe: "Banques",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank_to_wallet.png"),
            title: "Bank to Wallet",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.bankToWallet,
        ),
        RouteItem(
          groupe: "Trading",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-buffle-64.png"),
            title: "Open Demat",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.openDemat,
        ),
        RouteItem(
          groupe: "Trading",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-argent-64.png"),
            title: "Investir avec\n10K Fcfa",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.invertirAvec10kFcfa,
        ),
        RouteItem(
          groupe: "Trading",
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/lebedoo_logo.png",
            ),
            title: "Lebedoo Money",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.lebedooMoney,
        ),
        RouteItem(
          groupe: "Trading",
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons8-bourse-48.png"),
            title: "Bourse\nd'investissement",
            onPressed: () {},
          ),
          menuButtonEnum: MenuButtonEnum.bourseDinvestissement,
        ),
      ];

  List<RouteItem> routesByList({List<MenuButtonEnum> menus = const []}) =>
      routes.where((e) => menus.contains(e.menuButtonEnum)).toList();

  List<RouteItem> routesByGroup({String? groupe}) => routes
      .where((e) => e.groupe.value.isNotEmpty)
      .where((e) => e.groupe == groupe)
      .toList();

  List<RouteItem> search({String? value}) => routes
      .where((e) => e.button.title.value.isNotEmpty)
      .where((e) => e.button.title.value
          .toLowerCase()
          .contains(value.value.toLowerCase()))
      .toList();

  List<String> get groupes => routes
      .where((e) => e.groupe.value.isNotEmpty)
      .map((e) => e.groupe.value)
      .toSet()
      .toList();
}
