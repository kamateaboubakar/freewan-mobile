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
          color: Color(0xffE5E5E5),
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: jobEntity?.iconBackgroundColor ??
                      Color(0xff34A853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Image.asset(
                  jobEntity?.icon ?? 'assets/images/grommet-icons_google.png',
                  width: 50,
                  height: 50,
                ),
              ),
              if (canDelete) ...[
                Spacer(),
                Image.asset(
                  'assets/images/solar_trash-bin-2-line-duotone.png',
                  width: 25,
                  height: 25,
                ),
              ],
            ],
          ),
          SizedBox(height: 10),
          Text(
            jobEntity?.jobTitle ?? 'UI Designer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            jobEntity?.companyName ?? 'Google - A distance, CA',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff828282),
            ),
          ),
          SizedBox(height: 5),
          Text(
            jobEntity?.salary ?? 'FCFA 500 000  / Mo',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff828282),
            ),
          ),
        ],
      ),
    );
  }
}
