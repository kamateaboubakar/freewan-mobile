import 'package:flutter/material.dart';
import 'package:wan_mobile/models/job/job_offer.dart';
import 'package:wan_mobile/tools/utils/amount_util.dart';

import '../../../views/static/job/widgets/job_tag.dart';
import 'company_logo.dart';

class JobHeader extends StatelessWidget {
  final JobOffer jobOffer;

  const JobHeader({
    Key? key,
    required this.jobOffer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xff4F9D4D).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: CompanyLogo(
              company: jobOffer.company!,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobOffer.label!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  jobOffer.company!.name!,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  jobOffer.expectedSalary!.formatAmount,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                        child: JobTag(
                      title: jobOffer.contractType?.label ?? 'Temps plein',
                      fontSize: 9,
                    )),
                    SizedBox(width: 5),
                    Expanded(
                      child: JobTag(
                        title: jobOffer.activitySector?.label ?? "A distance",
                        fontSize: 9,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                        child: JobTag(
                      title: jobOffer.country?.label ?? "Senior",
                      fontSize: 9,
                    )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
