import 'package:construction/views/static/construction_home_page.dart';
import 'package:flutter/material.dart';
import 'package:guide_urbain/views/static/guide_urbain_home_page.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/sub_home_page/more_option_home_page.dart';
import 'package:wan_mobile/views/tools/groupe_route.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';
import 'package:wan_mobile/views/tools/route_item.dart';

class Routes extends ViewController {
  List<RouteItem> get routes => [
        RouteItem(
          groupe: GroupeRoute.transactions,
          menuId: MenuButtonEnum.retraitArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/gain.png"),
            title: "Retraits d'argent",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          isHidden: true,
          menuId: MenuButtonEnum.annulerTransfert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/annuler_transfert.png"),
            title: "Annuler transfert",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          menuId: MenuButtonEnum.paiementsAchats,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/depense.png"),
            title: "Paiements & achats",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Paiements & achats",
                menus: {
                  MenuButtonEnum.paiementTimbres,
                  MenuButtonEnum.paiementContravention,
                  MenuButtonEnum.factureEau,
                  MenuButtonEnum.factureElectricite,
                  MenuButtonEnum.rechargeYango,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          menuId: MenuButtonEnum.depotArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/depot_argent.png"),
            title: "Dépôt d'argent",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          menuId: MenuButtonEnum.bankToWaller,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank_to_wallet.png"),
            title: "Bank To Wallet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          menuId: MenuButtonEnum.transfertArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons8-envoyé.gif"),
            title: "Transfert d'argent",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Transfert d'argent",
                menus: {
                  MenuButtonEnum.bankToWaller,
                  MenuButtonEnum.wallerToBank,
                  MenuButtonEnum.annulerTransfert,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          menuId: MenuButtonEnum.wallerToBank,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/wallet_to_bank.png"),
            title: "Wallet To Bank",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.transactions,
          menuId: MenuButtonEnum.historiqueTransactions,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/historique_transaction.png"),
            title: "Historique transactions",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          menuId: MenuButtonEnum.cartesBancaires,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte-bancaire_lbd.png"),
            title: "Cartes bancaires",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          menuId: MenuButtonEnum.comptesBancaires,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank.png"),
            title: "Banks & microfinances",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.gabAProximite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte_gab.png"),
            title: "GAB à proximité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.restaurant,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/restaurant.png"),
            title: "Restaurant",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.gaz,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/gaz.png"),
            title: "GAZ",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.pressing,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-repassage-64.png"),
            title: "Pressing",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.materiauxConstruction,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-brique-96.png"),
            title: "Matériaux construction",
            onPressed: () => Get.to(() => const ConstructionHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.fraisScolarite,
          button: ButtonMenu(
            icon:
                Image.asset("assets/images/icons/icons8-etudiant-homme-64.png"),
            title: "Frais scolarité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.loyer,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/paiement_loyer.png"),
            title: "Loyer",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.jobs,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-mallette.gif"),
            title: "Jobs",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.pharmacie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/pharmacie.png"),
            title: "Pharmacie",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.brasserie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-liquor-shelf-64.png"),
            title: "Brasserie",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.caves,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/caves.png"),
            title: "Caves",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.parisSportifs,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/paris.gif"),
            title: GroupeRoute.parisSportifs,
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.achatUnite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/achat_unite.png"),
            title: "Achat unités",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.achatPass,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/acaht_data.png"),
            title: "Achat pass internet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.locationVehicules,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/location-de-voiture.png"),
            title: "Location de voitures",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          menuId: MenuButtonEnum.tontine,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/tontine.png"),
            title: "Tontines",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          menuId: MenuButtonEnum.dons,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/don.png"),
            title: "Dons",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          menuId: MenuButtonEnum.cadeaux,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-cadeau.gif"),
            title: "Cadeaux",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          menuId: MenuButtonEnum.vouchers,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/voucher.png"),
            title: "Vouchers",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Vouchers",
                //TODO à completer
                menus: {
                  MenuButtonEnum.vouchers,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.serviceInnovant,
          menuId: MenuButtonEnum.nounous,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/nounou.png"),
            title: "Nounous",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.eGov,
          menuId: MenuButtonEnum.paiementTimbres,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/timbre.png"),
            title: "Paiement de timbres",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.eGov,
          menuId: MenuButtonEnum.paimenentTaxes,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/taxe.png"),
            title: "Paiement de taxes",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.eGov,
          menuId: MenuButtonEnum.paiementContravention,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/sifflet.png"),
            title: "Paiement\ncontravention",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          menuId: MenuButtonEnum.factureElectricite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/cie.png"),
            title: "Factures d'électricité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          menuId: MenuButtonEnum.factureEau,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/SODECI.png"),
            title: "Factures d'eau",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          menuId: MenuButtonEnum.canalPlus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/Canal.png"),
            title: "Canal+",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          menuId: MenuButtonEnum.abonnementTele,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/tv.png"),
            title: "Abonnement\ntélé",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Abonnement télé",
                menus: {
                  MenuButtonEnum.canalPlus,
                  MenuButtonEnum.netflix,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          menuId: MenuButtonEnum.abonnementFibre,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_fibre.png"),
            title: "Abonnement\nfibre",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          menuId: MenuButtonEnum.abonnementPeage,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_payage.png"),
            title: "Abonnement\npéage",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.facturesEtAbonnements,
          menuId: MenuButtonEnum.netflix,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/netflix.png"),
            title: "Netflix",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.divertissement,
          menuId: MenuButtonEnum.tickets,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-ticket.gif"),
            title: "Tickets",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Tickets",
                menus: {
                  MenuButtonEnum.cinema,
                  MenuButtonEnum.stade,
                  MenuButtonEnum.concert,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          menuId: MenuButtonEnum.evenements,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-events-64.png"),
            title: "Evénements",
            onPressed: () => Get.to(
              () => const MoreOptionHomePage(
                groupeTitle: "Evénements",
                //TODO à completer
                menus: {
                  MenuButtonEnum.tickets,
                  MenuButtonEnum.evenements,
                },
              ),
            ),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          menuId: MenuButtonEnum.cinema,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-film.gif"),
            title: "Cinéma",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          menuId: MenuButtonEnum.stade,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-stade-100.png"),
            title: "Stade",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.divertissement,
          menuId: MenuButtonEnum.concert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-concert.gif"),
            title: "Concert",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: GroupeRoute.voyages,
          menuId: MenuButtonEnum.ticketBus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bus_car.png"),
            title: "Tickets\nde Bus",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          menuId: MenuButtonEnum.ticketBateauBus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bateau.png"),
            title: "Tickets\nBateau Bus",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          menuId: MenuButtonEnum.billetAvion,
          button: ButtonMenu(
            icon: Image.asset(
                "assets/images/icons/icons8-avion-vue-de-face-64.png"),
            title: "Billets\nd'avion",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          menuId: MenuButtonEnum.hotels,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-hotel.png"),
            title: "Hôtels",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.centresInterets,
          menuId: MenuButtonEnum.guideUrbain,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/guide_urbain.gif"),
            title: "Guide urbain",
            onPressed: () => Get.to(() => const GuideUrbainHomePage()),
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          menuId: MenuButtonEnum.oneXBet,
          button: ButtonMenu(
            icon: Image.asset("assets/images/1xbet.png"),
            title: "1xBet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          menuId: MenuButtonEnum.pmu,
          button: ButtonMenu(
            icon: Image.asset("assets/images/pmu.png"),
            title: "PMU",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          menuId: MenuButtonEnum.betclic,
          button: ButtonMenu(
            icon: Image.asset("assets/images/betclic.png"),
            title: "Betclic",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.parisSportifs,
          menuId: MenuButtonEnum.premierBet,
          button: ButtonMenu(
            icon: Image.asset("assets/images/premier_bet.jpg"),
            title: "Premier Bet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          menuId: MenuButtonEnum.cartesVirtuelles,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte-bancaire_lbd.png"),
            title: "Cartes virtuelles",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.cartesEtComptes,
          menuId: MenuButtonEnum.commanderCarteCredit,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte-bancaire_lbd.png"),
            title: "Commandez une carte",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: GroupeRoute.voyages,
          menuId: MenuButtonEnum.ticketCar,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/car.png"),
            title: "Tickets\nde car",
            onPressed: () {},
          ),
        ),
      ];

  List<RouteItem> routesByList({List<MenuButtonEnum> menus = const []}) =>
      routes
          .where((e) => menus.contains(e.menuId))
          .where((e) => !e.isHidden)
          .toList();

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
