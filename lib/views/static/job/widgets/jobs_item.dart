import 'package:flutter/material.dart';
import 'package:wan_mobile/views/static/job/job_views.dart';

class JobItem extends StatelessWidget {
  final bool canDelete;
  final JobEntity? jobEntity;

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
                  color: jobEntity?.iconBackgroundColor ??
                      const Color(0xff34A853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Image.asset(
                  jobEntity?.icon ?? 'assets/images/grommet-icons_google.png',
                  width: 50,
                  height: 50,
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
          const SizedBox(height: 10),
          Text(
            jobEntity?.jobTitle ?? 'UI Designer',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            jobEntity?.companyName ?? 'Google - A distance, CA',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff828282),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            jobEntity?.salary ?? 'FCFA 500 000  / Mo',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff828282),
            ),
          ),
        ],
      ),
    );
  }
}
