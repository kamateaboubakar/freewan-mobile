import 'package:flutter/material.dart';

class CGUPage extends StatelessWidget {
  const CGUPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CGU')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
              """Conditions Générales d'Utilisation de l'Application "LEBEDOO"
      
      Date d'entrée en vigueur : [Date]
      
      1. Acceptation des Conditions
      
      En utilisant l'application mobile "LEBEDOO" (ci-après "l'Application"), vous acceptez sans réserve les présentes Conditions Générales d'Utilisation ("CGU"). Si vous n'acceptez pas ces CGU, veuillez ne pas utiliser l'Application.
      
      2. Description de l'Application
      
      L'Application "LEBEDOO" est une plateforme mobile qui agrège et propose une variété de services [décrire les services]. Vous pouvez utiliser l'Application pour [décrire les principales fonctionnalités].
      
      3. Utilisation de l'Application
      
      3.1. Vous déclarez avoir l'âge légal pour utiliser cette application conformément à la législation de votre pays de résidence.
      
      3.2. Vous acceptez d'utiliser l'Application conformément à toutes les lois et réglementations locales, nationales et internationales applicables.
      
      3.3. Vous êtes seul responsable de toutes les activités réalisées à travers votre compte sur l'Application.
      
      4. Inscription et Compte Utilisateur
      
      4.1. Pour utiliser certaines fonctionnalités de l'Application, vous devrez créer un compte utilisateur. Vous acceptez de fournir des informations exactes et à jour lors de l'inscription.
      
      4.2. Vous êtes responsable de la confidentialité de votre mot de passe et de votre compte utilisateur. Vous êtes tenu de ne pas divulguer ces informations à des tiers.
      
      4.3. En cas d'utilisation non autorisée de votre compte, vous devez immédiatement en informer l'équipe de support de "LEBEDOO".
      
      5. Protection des Données Personnelles
      
      5.1. L'utilisation de l'Application est soumise à notre Politique de Confidentialité, qui régit la collecte, l'utilisation et la divulgation de vos données personnelles.
      
      5.2. En utilisant l'Application, vous consentez à la collecte et à l'utilisation de vos données personnelles conformément à notre Politique de Confidentialité.
      
      6. Propriété Intellectuelle
      
      6.1. Tous les contenus de l'Application, y compris les textes, les images, les marques, les logos et les éléments graphiques, sont protégés par des droits de propriété intellectuelle. Vous acceptez de ne pas copier, reproduire, distribuer ou créer des œuvres dérivées à partir de ces contenus sans autorisation écrite.
      
      7. Limitation de Responsabilité
      
      7.1. L'Application est fournie "telle quelle" et "telle que disponible". Nous ne garantissons pas son fonctionnement ininterrompu, exempt d'erreurs ou sûr.
      
      7.2. Nous déclinons toute responsabilité en cas de dommages directs, indirects, spéciaux, consécutifs ou punitifs résultant de l'utilisation de l'Application.
      
      8. Modifications des CGU
      
      8.1. Nous nous réservons le droit de modifier ces CGU à tout moment. Les modifications seront effectives dès leur publication sur l'Application. Il vous incombe de consulter régulièrement les CGU pour vous tenir informé des éventuelles modifications.
      
      9. Contact
      
      Pour toute question ou préoccupation concernant ces CGU, veuillez nous contacter à [adresse e-mail de contact]."""),
        ),
      ),
    );
  }
}
