import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:tools_flutter_project/tools_flutter_project.dart';
import 'package:wan_mobile/models/pubs/pub.dart';

class PubBanner extends StatelessWidget {
  final List<Pub> pubs;
  const PubBanner({required this.pubs, super.key});

  @override
  Widget build(BuildContext context) {
    if (pubs.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return ImageSlideshow(
        height: 220,
        autoPlayInterval: 6000,
        isLoop: true,
        children: pubs
            .map(
              (e) => (e.secondUrl.value.isNotEmpty)
                  ? Column(
                      children: [
                        Expanded(
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
                        const Gap(5),
                        Expanded(
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
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: e.url.value,
                        fit: BoxFit.cover,
                      ),
                    ),
            )
            .toList(),
      );
    }
  }
}
