import 'package:flutter/material.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/views/static/job/job_views.dart';

class JobItem extends StatelessWidget {
  final bool canDelete;
  final JobOffer? jobEntity;

  const JobItem({
    Key? key,
    this.jobEntity,
    this.canDelete = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffE5E5E5),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff34A853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: jobEntity == null
                    ? Image.asset(
                        'assets/images/grommet-icons_google.png',
                        width: 35,
                        height: 35,
                      )
                    : Image.memory(
                        Uri.parse(
                                "data:image/png;base64,${jobEntity!.company!.logo!}")
                            .data!
                            .contentAsBytes(),
                        width: 35,
                        height: 35,
                      ),
              ),
              if (canDelete) ...[
                const Spacer(),
                Image.asset(
                  'assets/images/solar_trash-bin-2-line-duotone.png',
                  width: 25,
                  height: 25,
                ),
              ],
            ],
          ),
          const SizedBox(height: 5),
          Text(
            jobEntity?.label ?? 'UI Designer',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            jobEntity?.company?.name ?? 'Google - A distance, CA',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xff828282),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'FCFA ${jobEntity?.expectedSalary ?? '500 000'} / Mo',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xff828282),
            ),
          ),
        ],
      ),
    );
  }
}
