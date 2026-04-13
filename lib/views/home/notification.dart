import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/controllers/notificationCtrl/notify_controller.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/notification_model.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Notification extends StatelessWidget {
  Notification({super.key});

  final List<IconData> icons = [
    Icons.notifications,
    Icons.star_border,
    Icons.arrow_circle_down_outlined,
    Icons.paid_outlined,
    Icons.warning_amber,
    Icons.notifications,
  ];

  final controller = Get.put(NotifyCtrl());
  final loadCtrl = Get.find<LoaderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: LoaderWrapper(
          child: PageContainer(
            topMargin: 15,
            // bottomPadding: 20,
            topChild: CustomAppBar.header(
              title: 'Notification',
              leftRight: 15,
              onPressed: () => Get.back(),
              notification: false,
              notificationPage: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Icon(
                        Icons.info_outline,
                        color: AppColors.declined,
                        size: 80,
                      ),
                      content: AppText(
                        text:
                            'Are you sure want to delete all your notifications. Once you delete it can not be recover. Do you want to continue', textAlign: TextAlign.center,
                      ),
                      actions: [
                        AppBtn(
                          onPressed: () {
                            controller.deleteAll();
                            Get.back();
                          },
                          label: 'Yes, Delete',
                        ),
                        const SizedBox(height: 8.0),
                        CancelBtn(onPressed: () {Get.back();}),
                      ],
                    );
                  },
                );
              },
            ),
            child: GetBuilder<NotifyCtrl>(
              init: NotifyCtrl(),
              builder: (c) {
                if (c.notifications.isEmpty) {
                  return Center(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('Assets/images/green_empty.png'), height: 150, width: 150,
                        ),
                        AppText(text: 'No Notification for you'),
                      ],
                    ),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  children: [
                    if (c.todayNote.isNotEmpty) ...[
                      sectionTitle('Today'),
                      notificationList(c.todayNote, (index){c.deleteNotify(index, c.todayNote);}, c.isRead.value),
                    ],
                    if (c.yesterNote.isNotEmpty) ...[
                      sectionTitle('Yesterday'),
                      notificationList(c.yesterNote, (index){c.deleteNotify(index, c.yesterNote);}, c.isRead.value),
                    ],
                    if (c.otherNote.isNotEmpty) ...[
                      sectionTitle('Older Notifications'),
                      notificationList(c.otherNote, (index){c.deleteNotify(index, c.otherNote);}, c.isRead.value),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationList(List<NotifyModel> list, Function(int) onDismissed, bool isRead) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        list.sort((a, b) => a.date.compareTo(b.date));
        final nt = list[index];
        return notificationCard(nt, onDismissed, isRead, (){});
      },
      itemCount: list.length,
    );
  }

  Widget sectionTitle(String title) {
    return AppText(text: title, textWeigh: FontWeight.bold, textSize: 17);
  }

  Widget notificationCard(NotifyModel notify, Function(int) onDismissed, bool isRead, Function confirm) {
    String formating(NotifyModel e) {
      final formatT = DateFormat('HH:mm').format(e.date);
      return formatT;
    }

    String formatD(NotifyModel e) {
      final formatT = DateFormat('MMM d').format(e.date);
      return formatT;
    }

    return Dismissible(
      key: Key(notify.title),
      onDismissed: (val) => onDismissed,
      secondaryBackground: Container(color: Colors.red,alignment: Alignment.centerRight, child: Icon(Icons.delete_rounded, color: Colors.white, size: 30,),),
      // background: Container(color: AppColors.primary, alignment: Alignment.centerLeft, child: Icon(Icons.done_all, size: 30, color: Colors.white),),
      background: Container(),
      direction: DismissDirection.endToStart,
      // confirmDismiss: (val) {return confirm();},
      child: Container(
        width: 350,
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(bottom: 13),
                  decoration: BoxDecoration(
                    color: isRead? AppColors.primary: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.notifications, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: notify.title,
                      textWeigh: FontWeight.bold,
                      textSize: 15,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        notify.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const Spacer(),
                AppText(
                  text: '${formating(notify)} - ${formatD(notify)}',
                  textColor: Colors.blue,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            const Divider(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
