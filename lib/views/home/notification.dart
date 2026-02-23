import 'package:fin_wise/controllers/notificationCtrl/notify_controller.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/notification_model.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: PageContainer(
          topMargin: 15,
          topChild: CustomAppBar.header('Notification', 15, () => Get.back()),
          child: GetBuilder<NotifyCtrl>(
              init: NotifyCtrl(),
              builder: (c){
            if(c.notifications.isEmpty){
              return Center(child: const Column(
                children: [
                  Icon(Icons.hourglass_empty),
                  AppText(text: 'No Notification for you'),
                ],
              ));
            }
            return ListView(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              children: [
                if(c.todayNote.isNotEmpty) ...[
                  sectionTitle('Today'),
                  notificationList(c.todayNote)
                ],
                if(c.yesterNote.isNotEmpty) ...[
                  sectionTitle('Yesterday'),
                  notificationList(c.yesterNote)
                ],
                if(c.otherNote.isNotEmpty)...[
                  sectionTitle('Older Notifications'),
                  notificationList(c.otherNote)
                ]
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget notificationList(List<NotifyModel> list) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        list.sort((a,b) => a.date.compareTo(b.date));
        final nt = list[index];
        return notificationCard(nt);
      },
      itemCount: list.length,
    );
  }

  Widget sectionTitle(String title){
    return AppText(
      text: title,
      textWeigh: FontWeight.bold,
      textSize: 17,
    );
  }
  Container notificationCard(NotifyModel notify) {
    String formating(NotifyModel e) {
      final formatT = DateFormat('HH:mm').format(e.date);
      return formatT;
    }

    String formatD(NotifyModel e) {
      final formatT = DateFormat('MMM d').format(e.date);
      return formatT;
    }

    return Container(
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
                  color: AppColors.primary,
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
          const Divider(color: AppColors.primary)
        ],
      ),
    );
  }
}
