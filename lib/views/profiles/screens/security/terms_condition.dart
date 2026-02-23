import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool agree = true;

  bool setAgree() {
    setState(() {
      agree = !agree;
    });
    return agree;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          'Terms And Condition',
          15,
          () => Get.back(),
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
          scrollDirection: Axis.vertical,
          children: [
            HeadingText(
              headingText: 'Our Terms and Conditions',
              textAlign: TextAlign.start,
            ),
            AppText(text: content, textAlign: TextAlign.justify),
            Row(
              children: [
                IconButton(
                  onPressed: () => setAgree(),
                  icon: Icon(
                    agree
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank_sharp,
                  ),
                ),
                AppText(text: 'I accept all the terms and conditions.'),
              ],
            ),
            AppBtn(
              onPressed: () {
                Get.back();
              },
              label: 'Accept',
            ),
          ],
        ),
      ),
    );
  }

  String content =
      """However, this process is often manual, time-consuming, and prone to errors. To address these challenges, our project aims to develop a comprehensive software solution for automated timetable generation. In the context of higher education institutions, a timetable refers to a temporary structure that outlines lecture series and assigns lecture halls or classrooms while ensuring that all relevant constraints are satisfied. This software will streamline the timetable creation process, save time and effort for educational institutions, reduce scheduling conflicts, and enhance the overall efficiency of academic operations. In the fast-paced world of education and business, managing time efficiently is crucial. 
The task of time table scheduling has been a longstanding necessity in various domains, including schools, colleges, and workplaces, such as crash courses. Historically, this process was a manual endeavour, requiring considerable human effort and time. Even seemingly minor constraints could consume significant resources, and the resulting timetables often lacked adaptability and efficiency. When dealing with an ever-changing workforce or evolving academic demands, the need for timely rescheduling became apparent. This placed a substantial burden on educational institutions, where teaching personnel invested significant time and energy into timetable generation. This project endeavours to alleviate the challenges associated with manual timetable creation by developing a versatile tool. """;
}
