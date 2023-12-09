import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/tools/widgets/button_menu.dart';
import 'package:lebedoo_assets/views/controllers/abstracts/view_controller.dart';
import 'package:wan_mobile/views/static/home/more_option_home_page.dart';
import 'package:wan_mobile/views/tools/menu_button_enum.dart';
import 'package:wan_mobile/views/tools/route_item.dart';

class Routes extends ViewController {
  List<RouteItem> get routes => [
        RouteItem(
          groupe: "Transactions",
          menuId: MenuButtonEnum.retraitArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/gain.png"),
            title: "Retraits d'argent",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Transactions",
          isHidden: true,
          menuId: MenuButtonEnum.annulerTransfert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/annuler_transfert.png"),
            title: "Annuler transfert",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Transactions",
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
          groupe: "Transactions",
          menuId: MenuButtonEnum.depotArgent,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/depot_argent.png"),
            title: "Dépôt d'argent",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Transactions",
          menuId: MenuButtonEnum.bankToWaller,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank_to_wallet.png"),
            title: "Bank To Wallet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Transactions",
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
          groupe: "Transactions",
          menuId: MenuButtonEnum.wallerToBank,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/wallet_to_bank.png"),
            title: "Wallet To Bank",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Transactions",
          menuId: MenuButtonEnum.historiqueTransactions,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/historique_transaction.png"),
            title: "Historique transactions",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: "Cartes & comptes",
          menuId: MenuButtonEnum.cartesBancaires,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte-bancaire_lbd.png"),
            title: "Cartes bancaires",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Cartes & comptes",
          menuId: MenuButtonEnum.comptesBancaires,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bank.png"),
            title: "Comptes bancaires",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.gabAProximite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/carte_gab.png"),
            title: "GAB à proximité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.restaurant,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/restaurant.png"),
            title: "Restaurant",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.gaz,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/gaz.png"),
            title: "GAZ",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.pressing,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-repassage-64.png"),
            title: "Pressing",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.materiauxConstruction,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-brique-96.png"),
            title: "Matériaux construction",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.fraisScolarite,
          button: ButtonMenu(
            icon:
                Image.asset("assets/images/icons/icons8-etudiant-homme-64.png"),
            title: "Frais scolarité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.loyer,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/paiement_loyer.png"),
            title: "Loyer",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.jobs,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-mallette.gif"),
            title: "Jobs",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.pharmacie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/pharmacie.png"),
            title: "Pharmacie",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.brasserie,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-liquor-shelf-64.png"),
            title: "Brasserie",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.caves,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/caves.png"),
            title: "Caves",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.parisSportifs,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/paris.png"),
            title: "Paris sportifs",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.achatUnite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/achat_unite.png"),
            title: "Achat unités",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.achatPass,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/acaht_data.png"),
            title: "Achat pass internet",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Centres d’intérêts",
          menuId: MenuButtonEnum.locationVehicules,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/location-de-voiture.png"),
            title: "Location de voitures",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: "Services innovants",
          menuId: MenuButtonEnum.tontine,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/tontine.png"),
            title: "Tontines",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Services innovants",
          menuId: MenuButtonEnum.dons,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/don.png"),
            title: "Dons",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Services innovants",
          menuId: MenuButtonEnum.cadeaux,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-cadeau.gif"),
            title: "Cadeaux",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Services innovants",
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
          groupe: "Services innovants",
          menuId: MenuButtonEnum.nounous,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/nounou.png"),
            title: "Nounous",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: "E-Gov",
          menuId: MenuButtonEnum.paiementTimbres,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/timbre.png"),
            title: "Paiement de timbres",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "E-Gov",
          menuId: MenuButtonEnum.paimenentTaxes,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/taxe.png"),
            title: "Paiement de taxes",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "E-Gov",
          menuId: MenuButtonEnum.paiementContravention,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/sifflet.png"),
            title: "Paiement\ncontravention",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: "Factures et abonnements",
          menuId: MenuButtonEnum.factureElectricite,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/cie.png"),
            title: "Factures d'électricité",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Factures et abonnements",
          menuId: MenuButtonEnum.factureEau,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/SODECI.png"),
            title: "Factures d'eau",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Factures et abonnements",
          menuId: MenuButtonEnum.canalPlus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/Canal.png"),
            title: "Canal+",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Factures et abonnements",
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
          groupe: "Factures et abonnements",
          menuId: MenuButtonEnum.abonnementFibre,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_fibre.png"),
            title: "Abonnement\nfibre",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Factures et abonnements",
          menuId: MenuButtonEnum.abonnementPeage,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/abonnement_payage.png"),
            title: "Abonnement\npéage",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Factures et abonnements",
          menuId: MenuButtonEnum.netflix,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/netflix.png"),
            title: "Netflix",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: "Divertissement",
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
          groupe: "Divertissement",
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
          groupe: "Divertissement",
          menuId: MenuButtonEnum.cinema,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-film.gif"),
            title: "Cinéma",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Divertissement",
          menuId: MenuButtonEnum.stade,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-stade-100.png"),
            title: "Stade",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Divertissement",
          menuId: MenuButtonEnum.concert,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-concert.gif"),
            title: "Concert",
            onPressed: () {},
          ),
        ),
        //-----------------------------
        RouteItem(
          groupe: "Voyage",
          menuId: MenuButtonEnum.ticketBus,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/bus_car.png"),
            title: "Ticket de Bus",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Voyage",
          menuId: MenuButtonEnum.ticketTrain,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-train-64.png"),
            title: "Ticket de train",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Voyage",
          menuId: MenuButtonEnum.billetAvion,
          button: ButtonMenu(
            icon: Image.asset(
                "assets/images/icons/icons8-avion-vue-de-face-64.png"),
            title: "Billet d'avion",
            onPressed: () {},
          ),
        ),
        RouteItem(
          groupe: "Voyage",
          menuId: MenuButtonEnum.hotels,
          button: ButtonMenu(
            icon: Image.asset("assets/images/icons/icons8-hotel.png"),
            title: "Hôtels",
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
