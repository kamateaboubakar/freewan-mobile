import 'package:flutter/material.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/tools/utils/amount_util.dart';

import '../../../../tools/widgets/job/company_logo.dart';

class JobItem extends StatelessWidget {
  final bool canDelete;
  final JobOffer? jobEntity;
  final Function()? onTap;
  final Function()? deleteCall;

  const JobItem({
    Key? key,
    this.jobEntity,
    this.canDelete = true,
    this.onTap,
    this.deleteCall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                  child: _buildCompanyLogo(),
                ),
                if (canDelete) ...[
                  const Spacer(),
                  InkWell(
                    onTap: deleteCall,
                    child: Image.asset(
                      'assets/images/solar_trash-bin-2-line-duotone.png',
                      width: 25,
                      height: 25,
                    ),
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
              '${jobEntity?.expectedSalary?.formatAmount ?? 'FCFA 500 000'} / Mo',
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xff828282),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyLogo() {
    if (jobEntity == null) {
      return Image.asset(
        'assets/images/grommet-icons_google.png',
        width: 35,
        height: 35,
      );
    }
    return CompanyLogo(company: jobEntity!.company!);
  }
}