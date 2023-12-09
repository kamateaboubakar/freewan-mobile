import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wan_mobile/models/pubs/pub.dart';

class PubSliderBanner extends StatelessWidget {
  final List<Pub> pubs;
  final double height;
  final int? autoPlayInterval;
  const PubSliderBanner(
      {required this.pubs,
      this.height = 160,
      this.autoPlayInterval = 6000,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (pubs.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return ImageSlideshow(
        height: height,
        autoPlayInterval: autoPlayInterval,
        isLoop: true,
        children: pubs
            .map(
              (e) => (e.secondUrl.value.isNotEmpty)
                  ? Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => launchUrl(Uri.parse(e.url.value)),
                            child: SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: e.url.value,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                launchUrl(Uri.parse(e.secondUrl.value)),
                            child: SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: e.secondUrl.value,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : GestureDetector(
                      onTap: () => launchUrl(Uri.parse(e.url.value)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: e.url.value,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            )
            .toList(),
      );
    }
  }
}
