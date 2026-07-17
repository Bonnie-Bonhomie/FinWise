import 'package:data_boot/controllers/controller_exports.dart';
import 'package:data_boot/core/Routes/Api_endpoints/api_endpoints.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/utils/widgets/custom_app_bar.dart';
import 'package:data_boot/utils/widgets/text_widget.dart';
import 'package:data_boot/data/models/faqs_model.dart';
import 'package:data_boot/viewModel/home_view_model.dart';
import 'package:data_boot/views/view_widgets/shared_widget.dart';
import 'package:data_boot/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  final helpCtrl = Get.find<HelpControl>();
  final viewModel = HomeViewModel();

  int selectIndex = 0;
  List<String> titles = ['FAQ', 'Contact Us'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async{await helpCtrl.getFaqs(0);});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
          topMargin: 20,
          topChild: CustomAppBar.header(
            title: 'Helps & FAQS',
            leftRight: 15,
            onPressed: () => Get.find<ProfileMainControl>().back(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                HeadingText(headingText: 'How can we help you?'),
                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).cardColor,
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
                    color: Theme.of(context).cardColor,
                  ),
                  child: Obx((){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: List.generate(helpCtrl.faqSections.length, (index) {
                          final title = helpCtrl.faqSections[index];
                          return InkWell(
                            onTap: () async{
                              helpCtrl.faqIndex.value = index;
                             await helpCtrl.getFaqs(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: AppText(
                                text: title,
                                textWeigh: helpCtrl.faqIndex.value == index ? FontWeight.bold : FontWeight.w300,
                                textColor: helpCtrl.faqIndex.value == index
                                    ? AppColors.primary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          );
                        }),
                      );
                    }
                  ),
                ),

                SizedBox(height: 15.0),
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hint: const AppText(text: 'Search...'),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
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
                SizedBox(height: 20),
                selectIndex == 0
                    ? Expanded(
                        child: Obx(() {
                          if(helpCtrl.loading.value){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return faqsQuestionSectList(helpCtrl.faqQuestion);
                        }),
                      )
                    : Column(
                        children: [
                          contactTile(
                            'Call Support',
                            Icons.dialer_sip_outlined,
                            () {
                              viewModel.makeCall();
                            },
                          ),
                          contactTile(
                            'Chat Admin',
                            Icons.mark_unread_chat_alt_outlined,
                                () {
                              viewModel.openWhatsApp();
                            },
                          ),
                          contactTile(
                            'Send Mail',
                            Icons.mail_lock,
                                () {
                              viewModel.openEmail();
                            },
                          ),
                          contactTile('Website', Icons.webhook_outlined, () {viewModel.openUrl(ApiEndpoints.baseUrl);}),
                          // contactTile('Facebook', Icons.facebook_outlined, () {}),

                          // contactTile(
                          //   'Instagram',
                          //   Icons.camera_alt_outlined,
                          //   () {},
                          // ),
                        ],
                      ),
              ],
            ),
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
        final quest = list[index].title;
        final content = list[index].description;
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
