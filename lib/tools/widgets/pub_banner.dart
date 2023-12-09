import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wan_mobile/models/pubs/pub.dart';

class PubBanner extends StatelessWidget {
  final Pub pub;
  const PubBanner({required this.pub, super.key});

  @override
  Widget build(BuildContext context) {
    return (pub.secondUrl.value.isNotEmpty)
        ? Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => launchUrl(Uri.parse(pub.url.value)),
                  child: SizedBox(
                    width: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: pub.url.value,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(5),
              Expanded(
                child: GestureDetector(
                  onTap: () => launchUrl(Uri.parse(pub.secondUrl.value)),
                  child: SizedBox(
                    width: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: pub.secondUrl.value,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: () => launchUrl(Uri.parse(pub.url.value)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: pub.url.value,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
