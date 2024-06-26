import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhubv2_0/models/response/applied/applied.dart';
import 'package:jobhubv2_0/views/common/custom_outline_btn.dart';
import 'package:jobhubv2_0/views/common/exports.dart';
import 'package:jobhubv2_0/views/common/width_spacer.dart';
import 'package:jobhubv2_0/views/ui/jobs/job_page.dart';

class AppliedTile extends StatelessWidget {
  const AppliedTile({super.key, required this.job, required this.text});
  final Job job;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: GestureDetector(
          onTap: () {
            Get.to(() => JobPage(title: job.company, id: job.id, agentName: job.agentName,));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            height: hieght * 0.1,
            width: width,
            decoration: const BoxDecoration(
                color: Color(0x09000000),
                borderRadius: BorderRadius.all(Radius.circular(9))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(job.imageUrl),
                        ),
                        const WidthSpacer(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: job.company,
                                style: appStyle(
                                    12, Color(kDark.value), FontWeight.w500)),
                            SizedBox(
                              width: width * 0.5,
                              child: ReusableText(
                                  text: job.title,
                                  style: appStyle(12, Color(kDarkGrey.value),
                                      FontWeight.normal)),
                            ),
                            ReusableText(
                                text: "${job.salary} per ${job.period}",
                                style: appStyle(
                                    12, Color(kDarkGrey.value), FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                    
                        CustomOutlineBtn(
                            width: 90,
                            hieght: 36,
                            text: 'View',
                            color: Color(kLightBlue.value))
                       
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
