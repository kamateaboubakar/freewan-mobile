import 'package:flutter/material.dart';
import 'package:lebedoo_assets/lebedoo_assets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletCard extends StatelessWidget {
  final bool hideAmount;
  final String amount;
  final String currency;
  final String qrData;
  final void Function()? onHideAmount;
  final void Function()? onLoadAmount;

  const WalletCard({
    this.hideAmount = false,
    this.amount = "0",
    this.currency = "Fcfa",
    this.qrData = "data",
    this.onHideAmount,
    this.onLoadAmount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: Stack(
        children: [
          Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset(
                  "assets/images/fond_carte.jpg",
                ).image,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: 225,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.79),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
                bottom: Radius.circular(30),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                leading: MaterialButton(
                  height: 25,
                  color: Colors.white,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      Gap(5),
                      Text("Recharger"),
                    ],
                  ),
                ),
                trailing: IconButton(
                  splashRadius: 20,
                  onPressed: onHideAmount,
                  icon: Icon(
                    (hideAmount) ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                textColor: Colors.white,
                onTap: onLoadAmount,
                title: Text(
                  (hideAmount) ? "•••••••••••" : amount,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
                subtitle: Text(
                  currency,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: QrImageView(
                  data: qrData,
                  padding: const EdgeInsets.all(8),
                  size: 125,
                  backgroundColor: Colors.white,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
