import 'package:brasserie/views/static/brasserie_home_page.dart';
import 'package:cave/views/static/cave_home_page.dart';
import 'package:commande_carte_bancaire/views/static/commande_carte_bancaire_home.dart';
import 'package:construction/views/static/construction_home_page.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:guide_urbain/views/static/guide_urbain_home_page.dart';
import 'package:lebedoo_assets/const/feature_dictionnary.dart';
import 'package:lebedoo_wallets_transactions/views/static/moyens_paiements/cartes_bancaires/cartes_bancaires_page.dart';
import 'package:lebedoo_wallets_transactions/views/static/moyens_paiements/compte_bancaire/compte_bancaire_page.dart';
import 'package:mapping_gab/views/static/mapping_gab_home_page.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/routes/tools/actions/go_to_more_page_action.dart';
import 'package:wan_mobile/routes/tools/actions/go_to_page_action.dart';
import 'package:wan_mobile/routes/tools/actions/on_pressed_action.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/assurances/assurances_home_page.dart';
import 'package:wan_mobile/views/static/bank_micro_finance/bank_home_page.dart';
import 'package:wan_mobile/views/static/bank_micro_finance/micro_finance_home_page.dart';
import 'package:wan_mobile/views/static/gaz/gaz_view.dart';
import 'package:wan_mobile/routes/groupe_route.dart';
import 'package:wan_mobile/routes/route_item.dart';
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
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          isHidden: true,
          id: FeatureDictionnary.annulerTransfert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/annuler_transfert.png"),
            title: "Annuler transfert",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.paiementsAchats,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/depense.png"),
            title: "Paiements & achats",
            action: const GoToMorePageAction(
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
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.depotArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/depot_argent.png"),
            title: "Dépôt d'argent",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.bankToWaller,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank_to_wallet.png"),
            title: "Bank To Wallet",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.transfertArgent,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/icons8-envoyé.gif"),
            title: "Transfert d'argent",
            action: const GoToMorePageAction(
              groupeTitle: "Transfert d'argent",
              menus: {
                FeatureDictionnary.bankToWaller,
                FeatureDictionnary.wallerToBank,
                FeatureDictionnary.annulerTransfert,
              },
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.wallerToBank,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/wallet_to_bank.png"),
            title: "Wallet To Bank",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.historiqueTransactions,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/historique_transaction.png"),
            title: "Historique transactions",
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.cartesBancaires,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/compte-bancaire.png"),
            title: "Comptes bancaires",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.cartesBancaires,
              page: CompteBancairePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.banks,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank.png"),
            title: "Banques",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.banks,
              page: BankHomePage(),
            ),
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.gabAProximite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte_gab.png"),
            title: "GAB à proximité",
            action: GoToRouteAction(
              feature: FeatureDictionnary.gabAProximite,
              page: MappingGabHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.restaurant,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/restaurant.png"),
            title: "Restaurant",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.gaz,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/gaz.png"),
            title: "GAZ",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.gaz,
              page: GazMapPage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.pressing,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-repassage-64.png"),
            title: "Pressing",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.pressing,
              page: PressingMapPage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.materiauxConstruction,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-brique-96.png"),
            title: "Matériaux construction",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.materiauxConstruction,
              page: ConstructionHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.fraisScolarite,
          button: ButtonMenu(
            icon:
                Image.asset("assets/images/icons/icons8-etudiant-homme-64.png"),
            title: "Frais scolarité",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.loyer,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/paiement_loyer.png"),
            title: "Loyer",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.jobs,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-mallette.gif"),
            title: "Jobs",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.jobs,
              page: JobHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.pharmacie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/pharmacie.png"),
            title: "Pharmacie",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.brasserie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-liquor-shelf-64.png"),
            title: "Brasserie",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.brasserie,
              page: BrasserieHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.caves,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/caves.png"),
            title: "Caves",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.caves,
              page: CaveHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.achatUnite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/achat_unite.png"),
            title: "Achat unités",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.achatPass,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/acaht_data.png"),
            title: "Achat pass internet",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.locationVehicules,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/location-de-voiture.png"),
            title: "Location de voitures",
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.tontine,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/tontine.png"),
            title: "Tontines",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.dons,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/don.png"),
            title: "Dons",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.cadeaux,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-cadeau.gif"),
            title: "Cadeaux",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.vouchers,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/voucher.png"),
            title: "Vouchers",
            action: const GoToMorePageAction(
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
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          id: FeatureDictionnary.nounous,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/nounou.png"),
            title: "Nounous",
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.eGov,
          id: FeatureDictionnary.paiementTimbres,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/timbre.png"),
            title: "Paiement de timbres",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.eGov,
          id: FeatureDictionnary.paimenentTaxes,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/taxe.png"),
            title: "Paiement de taxes",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.eGov,
          id: FeatureDictionnary.paiementContravention,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/sifflet.png"),
            title: "Paiement\ncontravention",
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.factureElectricite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/cie.png"),
            title: "Factures d'électricité",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.factureEau,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/SODECI.png"),
            title: "Factures d'eau",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.canalPlus,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/icons/Canal.png"),
            title: "Canal+",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.abonnementTele,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/tv.png"),
            title: "Abonnement\ntélé",
            action: const GoToMorePageAction(
              groupeTitle: "Abonnement télé",
              menus: {
                FeatureDictionnary.canalPlus,
                FeatureDictionnary.netflix,
              },
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.abonnementFibre,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_fibre.png"),
            title: "Abonnement\nfibre",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.abonnementPeage,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_payage.png"),
            title: "Abonnement\npéage",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          id: FeatureDictionnary.netflix,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/netflix.png"),
            title: "Netflix",
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.tickets,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-ticket.gif"),
            title: "E-tickets",
            action: const GoToMorePageAction(
              groupeTitle: "Tickets",
              menus: {
                FeatureDictionnary.cinema,
                FeatureDictionnary.stade,
                FeatureDictionnary.concert,
              },
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.evenements,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-events-64.png"),
            title: "Evénements",
            action: const GoToMorePageAction(
              groupeTitle: "Evénements",
              //TODO à completer
              menus: {
                FeatureDictionnary.tickets,
                FeatureDictionnary.evenements,
              },
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.cinema,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-film.gif"),
            title: "Cinéma",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.stade,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-stade-100.png"),
            title: "Stade",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          id: FeatureDictionnary.concert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-concert.gif"),
            title: "Concert",
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.ticketBus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bus_car.png"),
            title: "Tickets\nde Bus",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.ticketBateauBus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bateau.png"),
            title: "Tickets\nBateau Bus",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.billetAvion,
          button: ButtonMenu(
            icon: Image.asset(
                "assets/images/icons/icons8-avion-vue-de-face-64.png"),
            title: "Billets\nd'avion",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.hotels,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-hotel.png"),
            title: "Hôtels",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.guideUrbain,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/guide_urbain.gif"),
            title: "Guide urbain",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.guideUrbain,
              page: GuideUrbainHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.oneXBet,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/1xbet.png"),
            title: "1xBet",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.pmu,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/pmu.png"),
            title: "PMU",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.betclic,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/betclic.png"),
            title: "Betclic",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.premierBet,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/premier_bet.jpg"),
            title: "Premier Bet",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.cartesVirtuelles,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte_bancaire.png"),
            title: "Cartes virtuelles",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.cartesVirtuelles,
              page: CartesBancairesPage(),
            ),
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
            action: const GoToRouteAction(
              feature: FeatureDictionnary.commanderCarteCredit,
              page: CommandeCarteBancaireHome(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.ticketCar,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/car.png"),
            title: "Tickets\nde car",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.sportCash,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/sportcash.png"),
            title: "SportCash",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.lotoBonheur,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/lotobonheur.jpg"),
            title: "lotoBonheur",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.virtualGames,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/virtualGames.jpg"),
            title: "virtualGames",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.rouletteLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-roulette-80.png"),
            title: "Roulette Lebedoo",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.coursesChevauxLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-horse-racing-96.png"),
            title: "Courses chevaux Lebedoo",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.parisFootBallLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-bet-62.png"),
            title: "Paris Football Lebedoo",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.casinoLebedoo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-casino-48.png"),
            title: "Casino Lebedoo",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.virgin,
          button: ButtonMenu(
            icon: Image.asset("assets/images/Virgin-logo.png"),
            title: "Virgin",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          id: FeatureDictionnary.historiqueTransactions,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/historique_transaction.png"),
            title: "Transactions\nrécentes",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.nintendo,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/Nintendo_logo.png"),
            title: "Ninintendo",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.nintendo,
          button: ButtonMenu(
            icon: Image.asset("assets/images/Steam_icon.png"),
            title: "Steam",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.nintendo,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/Xbox_store.jpg"),
            title: "Xbox",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.playstation,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/playstation_store.png"),
            title: "Playstation",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.vouchers,
          id: FeatureDictionnary.taxi,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/taxi.png"),
            title: "Taxis",
            action: const GoToMorePageAction(
              groupeTitle: GroupeRoute.taxi,
              menus: {
                FeatureDictionnary.treiizeTaxi,
                FeatureDictionnary.yango,
              },
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.yango,
          button: ButtonMenu(
            icon: Image.asset("assets/images/yango.png"),
            title: "Yango",
            action: OnPressedAction(
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
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          id: FeatureDictionnary.treiizeTaxi,
          button: ButtonMenu(
            icon: Image.asset("assets/images/treiize_taxi.jpeg"),
            title: "Treiize Taxi",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          id: FeatureDictionnary.tirageGhana,
          button: ButtonMenu(
            withCircleIcon: false,
            icon: Image.asset("assets/images/tirageghana.jpg"),
            title: "Tirage Ghana",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          id: FeatureDictionnary.rechargeCartePrepayee,
          button: ButtonMenu(
            icon:
                Image.asset("assets/images/icons/recharge_carte_prepayee.png"),
            title: "Recharge de carte",
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.assurances,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/assurance.png"),
            title: "E-assurances",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.assurances,
              page: AssurancesHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.microfinances,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/microfinances.png"),
            title: "Micro-finances",
            action: const GoToRouteAction(
              feature: FeatureDictionnary.microfinances,
              page: MicroFinanceHomePage(),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          id: FeatureDictionnary.avanceSurSalaire,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/avance_sur_salaire.png"),
            title: "AVS",
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