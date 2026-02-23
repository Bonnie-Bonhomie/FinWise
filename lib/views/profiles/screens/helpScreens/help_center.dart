import 'package:fin_wise/controllers/profileCtrl/help_center_ctrl.dart';
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/faqs_model.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final helpCtrl = Get.put(HelpControl());

  int selectIndex = 0;
  List<String> titles = ['FAQ', 'Contact Us'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          'Helps & FAQS',
          15,
          () => Get.find<ProfileMainControl>().back(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              HeadingText(headingText: 'How can we help you?'),
              SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lightGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(2, (index) {
                    return selectBox(
                      titles[index],
                      () {
                        setState(() {
                          selectIndex = index;
                        });
                      },
                      selectIndex == index
                          ? AppColors.primary
                          : Colors.transparent,
                    );
                  }),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                // width: 300,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lightGreen,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: List.generate(helpCtrl.faqSections.length, (index) {
                      final title = helpCtrl.faqSections[index];
                      return InkWell(
                        onTap: (){
                          helpCtrl.faqIndex.value = index;
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(text: title),
                        ),
                      );
                    }),
                  ),
                ),

              SizedBox(height: 15.0),
              SizedBox(
                height: 40,
                child: TextFormField(
                  decoration: InputDecoration(
                    hint: const AppText(text: 'Search...'),
                    filled: true,
                    fillColor: AppColors.lightGreen,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.primary, width: 1.5)
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              selectIndex == 0
                  ? Expanded(
                      child: Obx(() {
                        helpCtrl.faqGeneralQ.add(helpCtrl.faqServiceQ);
                        helpCtrl.faqGeneralQ.add(helpCtrl.faqAccountQ);
                        final index = helpCtrl.faqIndex.value;
                        return index == 0
                            ? faqsQuestionSectList(helpCtrl.faqGeneralQ[index])
                            : index == 1
                            ? faqsQuestionSectList(helpCtrl.faqAccountQ)
                            : faqsQuestionSectList(helpCtrl.faqServiceQ);
                      }),
                    )
                  : Column(
                      children: [
                        contactTile(
                          'Customer Service',
                          Icons.help_outline_rounded,
                          () {Get.find<ProfileMainControl>().toOnlineHelp();},
                        ),
                        contactTile('Website', Icons.webhook_outlined, () {}),
                        contactTile('Facebook', Icons.facebook_outlined, () {}),
                        contactTile(
                          'Whatsapp',
                          Icons.lightbulb_circle_outlined,
                          () {},
                        ),
                        contactTile(
                          'Instagram',
                          Icons.camera_alt_outlined,
                          () {},
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  ListView faqsQuestionSectList(List<FaqsModel> list) {
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final quest = list[index].question;
        final content = list[index].answer;
        return ExpansionTile(
          title: AppText(text: quest),
          trailing: Icon(Icons.arrow_right),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppText(text: content),
            ),
          ],
        );
      },
    );
  }

  InkWell selectBox(String title, VoidCallback onTap, Color color) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Center(child: Text(title)),
      ),
    );
  }

  Widget contactTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: AppText(text: title),
      leading: CircleAvatar(
        radius: 15.0,
        backgroundColor: AppColors.primary,
        child: Icon(icon, color: AppColors.lightGreen),
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: onTap,
    );
  }
}
