import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/controllers/notificationCtrl/notify_controller.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/data/models/notification_model.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
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

  final ctrl = Get.find<NotifyCtrl>();
  final loadCtrl = Get.find<LoaderController>();
  final viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).cardColor;
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
                            'Are you sure want to delete all your notifications. Once you delete it can not be recover. Do you want to continue',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        AppBtn(
                          onPressed: () {
                            ctrl.deleteAll();
                            Get.back();
                          },
                          label: 'Yes, Delete',
                        ),
                        const SizedBox(height: 8.0),
                        CancelBtn(
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            child: Obx(() {
              print(ctrl.todayNote);
              if(ctrl.loading.value){
                return SkeletonLoader.shimmerLines(len: 5);
              }
              if (ctrl.notifications.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('Assets/images/green_empty.png'),
                        height: 150,
                        width: 150,
                      ),
                      AppText(text: ctrl.noteErr.value),
                    ],
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                children: [
                  if (ctrl.todayNote.isNotEmpty) ...[
                    sectionTitle('Today'),
                    notificationList(ctrl.todayNote, (index) {
                      ctrl.markAsRead(index, ctrl.todayNote);
                      // ctrl.deleteNotify(index, ctrl.todayNote);
                    }, ctrl.isRead.value),
                  ],
                  if (ctrl.yesterNote.isNotEmpty) ...[
                    sectionTitle('Yesterday'),
                    notificationList(ctrl.yesterNote, (index) {
                      // ctrl.deleteNotify(index, ctrl.yesterNote);
                      ctrl.markAsRead(index, ctrl.yesterNote);
                    }, ctrl.isRead.value),
                  ],
                  if (ctrl.otherNote.isNotEmpty) ...[
                    sectionTitle('Older Notifications'),
                    notificationList(ctrl.otherNote, (index) {
                      // ctrl.deleteNotify(index, ctrl.otherNote);
                      ctrl.markAsRead(index, ctrl.otherNote);
                    }, ctrl.isRead.value,),
                  ],
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget notificationList(
    List<NotifyModel> list,
    Function(int) onDismissed,
    bool isRead,
      // BuildContext context,
  ) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        list.sort((a, b) => a.date.compareTo(b.date));
        final nt = list[index];
        return AnimatedCard(
            index: index,
            child: notificationCard(nt, onDismissed, isRead, () {}, context));
      },
      itemCount: list.length,
    );
  }

  Widget sectionTitle(String title) {
    return AppText(text: title, textWeigh: FontWeight.bold, textSize: 17);
  }

  Widget notificationCard(
    NotifyModel notify,
    Function(int) onDismissed,
    bool isRead,
    Function confirm,
      BuildContext context
  ) {
    return Dismissible(
      key: Key(notify.title),
      onDismissed: (val) => onDismissed,
      secondaryBackground: Container(
        color: Colors.lightGreen,
        alignment: Alignment.centerRight,
        child: Icon(Icons.done_all_outlined, color: Colors.white, size: 30),
      ),
      // background: Container(color: AppColors.primary, alignment: Alignment.centerLeft, child: Icon(Icons.done_all, size: 30, color: Colors.white),),
      background: Container(),
      direction: DismissDirection.endToStart,
      // confirmDismiss: (val) {return confirm();},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isRead? AppColors.primaryLight: Theme.of(context).cardColor,
        ),
        child: ListTile(
          onTap: (){},
          leading: CircleAvatar(child: isRead? Icon(Icons.notifications_active): Icon(Icons.notifications_active_outlined),),
          title: AppText(
            text: notify.title,
            textWeigh: FontWeight.bold,
            textSize: 15,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                notify.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
              AppText(
                text: viewModel.formatDate(notify.date),
                textColor: Colors.blue,
                textAlign: TextAlign.end,
                textSize: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
