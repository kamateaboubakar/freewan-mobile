import 'package:brasserie/views/static/brasserie_home_page.dart';
import 'package:cave/views/static/cave_home_page.dart';
import 'package:commande_carte_bancaire/views/static/commande_carte_bancaire_home.dart';
import 'package:construction/views/static/construction_home_page.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:guide_urbain/views/static/guide_urbain_home_page.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:lebedoo_wallets_transactions/views/static/moyens_paiements/cartes_bancaires/cartes_bancaires_page.dart';
import 'package:lebedoo_wallets_transactions/views/static/moyens_paiements/compte_bancaire/compte_bancaire_page.dart';
import 'package:mapping_gab/views/static/mapping_gab_home_page.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/gaz/gaz_view.dart';
import 'package:wan_mobile/views/static/home/cross_home_page/more_option_home_page.dart';
import 'package:wan_mobile/views/routes/groupe_route.dart';
import 'package:wan_mobile/views/routes/route_item.dart';
import 'package:wan_mobile/views/static/job/views/employee/employee_views.dart';
import 'package:wan_mobile/views/static/pressing/pressing_view.dart';

class Routes extends ViewController {
  List<RouteItem> get routes => [
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.retraitArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/gain.png"),
            title: "Retraits d'argent",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          isHidden: true,
          id: FeatureDictionnary.annulerTransfert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/annuler_transfert.png"),
            title: "Annuler transfert",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.paiementsAchats,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/depense.png"),
            title: "Paiements & achats",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Paiements & achats",
                menus: {
                  FeatureDictionnary.paiementTimbres,
                  FeatureDictionnary.paiementContravention,
                  FeatureDictionnary.factureEau,
                  FeatureDictionnary.factureElectricite,
                  FeatureDictionnary.rechargeYango,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.depotArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/depot_argent.png"),
            title: "Dépôt d'argent",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.bankToWaller,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank_to_wallet.png"),
            title: "Bank To Wallet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.transfertArgent,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/icons8-envoyé.gif"),
            title: "Transfert d'argent",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Transfert d'argent",
                menus: {
                  FeatureDictionnary.bankToWaller,
                  FeatureDictionnary.wallerToBank,
                  FeatureDictionnary.annulerTransfert,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.wallerToBank,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/wallet_to_bank.png"),
            title: "Wallet To Bank",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.historiqueTransactions,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/historique_transaction.png"),
            title: "Historique transactions",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.cartesBancaires,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/compte-bancaire.png"),
            title: "Comptes bancaires",
            onPressed: () => Get.to(() => const CompteBancairePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.comptesBancaires,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank.png"),
            title: "Banks & microfinances",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.gabAProximite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte_gab.png"),
            title: "GAB à proximité",
            onPressed: () => Get.to(() => const MappingGabHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.restaurant,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/restaurant.png"),
            title: "Restaurant",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.gaz,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/gaz.png"),
            title: "GAZ",
            onPressed: () => Get.to(() => const GazMapPage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.pressing,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-repassage-64.png"),
            title: "Pressing",
            onPressed: () => Get.to(() => const PressingMapPage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.materiauxConstruction,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-brique-96.png"),
            title: "Matériaux construction",
            onPressed: () => Get.to(() => const ConstructionHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.fraisScolarite,
          button: ButtonMenu(
            icon:
                Image.asset("assets/images/icons/icons8-etudiant-homme-64.png"),
            title: "Frais scolarité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.loyer,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/paiement_loyer.png"),
            title: "Loyer",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.jobs,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-mallette.gif"),
            title: "Jobs",
            onPressed: () => Get.to(() => const JobHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.pharmacie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/pharmacie.png"),
            title: "Pharmacie",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.brasserie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-liquor-shelf-64.png"),
            title: "Brasserie",
            onPressed: () => Get.to(() => const BrasserieHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.caves,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/caves.png"),
            title: "Caves",
            onPressed: () => Get.to(() => const CaveHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.achatUnite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/achat_unite.png"),
            title: "Achat unités",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.achatPass,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/acaht_data.png"),
            title: "Achat pass internet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.locationVehicules,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/location-de-voiture.png"),
            title: "Location de voitures",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.tontine,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/tontine.png"),
            title: "Tontines",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.dons,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/don.png"),
            title: "Dons",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.cadeaux,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-cadeau.gif"),
            title: "Cadeaux",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.vouchers,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/voucher.png"),
            title: "Vouchers",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Vouchers",
                menus: {
                  FeatureDictionnary.nintendo,
                  FeatureDictionnary.virgin,
                  FeatureDictionnary.xbox,
                  FeatureDictionnary.playstation,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.nounous,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/nounou.png"),
            title: "Nounous",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.eGov,
          id: FeatureDictionnary.paiementTimbres,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/timbre.png"),
            title: "Paiement de timbres",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.eGov,
          id: FeatureDictionnary.paimenentTaxes,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/taxe.png"),
            title: "Paiement de taxes",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.eGov,
          id: FeatureDictionnary.paiementContravention,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/sifflet.png"),
            title: "Paiement\ncontravention",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.factureElectricite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/cie.png"),
            title: "Factures d'électricité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.factureEau,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/SODECI.png"),
            title: "Factures d'eau",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.canalPlus,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/icons/Canal.png"),
            title: "Canal+",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.abonnementTele,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/tv.png"),
            title: "Abonnement\ntélé",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Abonnement télé",
                menus: {
                  FeatureDictionnary.canalPlus,
                  FeatureDictionnary.netflix,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.abonnementFibre,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_fibre.png"),
            title: "Abonnement\nfibre",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.abonnementPeage,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_payage.png"),
            title: "Abonnement\npéage",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.netflix,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/netflix.png"),
            title: "Netflix",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.tickets,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-ticket.gif"),
            title: "Tickets",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Tickets",
                menus: {
                  FeatureDictionnary.cinema,
                  FeatureDictionnary.stade,
                  FeatureDictionnary.concert,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.evenements,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-events-64.png"),
            title: "Evénements",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Evénements",
                //TODO à completer
                menus: {
                  FeatureDictionnary.tickets,
                  FeatureDictionnary.evenements,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.cinema,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-film.gif"),
            title: "Cinéma",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.stade,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-stade-100.png"),
            title: "Stade",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.concert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-concert.gif"),
            title: "Concert",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.ticketBus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bus_car.png"),
            title: "Tickets\nde Bus",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.ticketBateauBus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bateau.png"),
            title: "Tickets\nBateau Bus",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.billetAvion,
          button: ButtonMenu(
            icon: Image.asset(
                "assets/images/icons/icons8-avion-vue-de-face-64.png"),
            title: "Billets\nd'avion",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.hotels,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-hotel.png"),
            title: "Hôtels",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.guideUrbain,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/guide_urbain.gif"),
            title: "Guide urbain",
            onPressed: () => Get.to(() => const GuideUrbainHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.oneXBet,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/1xbet.png"),
            title: "1xBet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.pmu,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/pmu.png"),
            title: "PMU",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.betclic,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/betclic.png"),
            title: "Betclic",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.premierBet,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/premier_bet.jpg"),
            title: "Premier Bet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.cartesVirtuelles,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte_bancaire.png"),
            title: "Cartes virtuelles",
            onPressed: () => Get.to(() => const CartesBancairesPage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.commanderCarteCredit,
          button: ButtonMenu(
            icon: Image.asset(
              "assets/images/icons/commande_carte_bancaire.gif",
            ),
            title: "Commandez une carte",
            onPressed: () => Get.to(() => const CommandeCarteBancaireHome()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.ticketCar,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/car.png"),
            title: "Tickets\nde car",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.sportCash,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/sportcash.png"),
            title: "SportCash",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.lotoBonheur,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/lotobonheur.jpg"),
            title: "lotoBonheur",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.virtualGames,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/virtualGames.jpg"),
            title: "virtualGames",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.rouletteLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-roulette-80.png"),
            title: "Roulette Lebedoo",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.coursesChevauxLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-horse-racing-96.png"),
            title: "Courses chevaux Lebedoo",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.parisFootBallLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-bet-62.png"),
            title: "Paris Football Lebedoo",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.casinoLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-casino-48.png"),
            title: "Casino Lebedoo",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.virgin,
          button: ButtonMenu(
            icon: Image.asset("assets/images/Virgin-logo.png"),
            title: "Virgin",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.historiqueTransactions,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/historique_transaction.png"),
            title: "Transactions\nrécentes",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.nintendo,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/Nintendo_logo.png"),
            title: "Ninintendo",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.nintendo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/Steam_icon.png"),
            title: "Steam",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.nintendo,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/Xbox_store.jpg"),
            title: "Xbox",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.playstation,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/playstation_store.png"),
            title: "Playstation",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.taxi,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/taxi.png"),
            title: "Taxis",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: GroupeRoute.taxi,
                menus: {
                  FeatureDictionnary.treiizeTaxi,
                  FeatureDictionnary.yango,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.yango,
          button: ButtonMenu(
            icon: Image.asset("assets/images/yango.png"),
            title: "Yango",
            onPressed: () async {
              await LaunchApp.openApp(
                androidPackageName: 'com.yandex.yango',
                iosUrlScheme:
                    'https://apps.apple.com/fr/app/yango-more-than-taxi/id1437157286',
                appStoreLink:
                    'https://apps.apple.com/fr/app/yango-more-than-taxi/id1437157286',
                openStore: false,
              );
            },
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.treiizeTaxi,
          button: ButtonMenu(
            icon: Image.asset("assets/images/treiize_taxi.jpeg"),
            title: "Treiize Taxi",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.tirageGhana,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/tirageghana.jpg"),
            title: "Tirage Ghana",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.rechargeCartePrepayee,
          button: ButtonMenu(
            icon:
                Image.asset("assets/images/icons/recharge_carte_prepayee.png"),
            title: "Recharge de carte",
            onPressed: () {},
          ),
        ),
      ];

  List<RouteItem> routesByList(
      {Set<FeatureDictionnary> menus = const {}, bool sorted = true}) {
    var res = <RouteItem>[];
    if (sorted) {
      res = routes
          .where((e) => menus.contains(e.id))
          .where((e) => !e.isHidden)
          .toList()
        ..sort((a, b) => a.title.value.compareTo(b.title.value));
    } else {
      for (var e in menus) {
        res.addAll(routes
            .where((element) => element.id == e)
            .where((element) => !element.isHidden)
            .toList());
      }
    }
    return res;
  }

  List<RouteItem> routesByGroup({String? groupe}) => routes
      .where((e) => e.groupe.value.isNotEmpty)
      .where((e) => !e.isHidden)
      .where((e) => e.groupe == groupe)
      .toList();

  List<RouteItem> search({String? value}) => routes
      .where((e) => e.button.title.value.isNotEmpty)
      .where((e) => !e.isHidden)
      .where((e) => e.button.title.value
          .toLowerCase()
          .contains(value.value.toLowerCase()))
      .toList();

  List<String> get groupes => routes
      .where((e) => e.groupe.value.isNotEmpty && !e.isHidden)
      .where((e) => !e.isHidden)
      .map((e) => e.groupe.value)
      .toSet()
      .toList()
    ..sort((a, b) => a.compareTo(b));
}
