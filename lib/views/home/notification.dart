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
                ctrl.notifications.isNotEmpty?
               showDeleteAllDialog(context, (){
                 Get.back();
                 loadCtrl.offLoading(() async{
                   await ctrl.deleteAll();
                 });
               }):  null;
              },
            ),
            child: Obx(() {
              print(ctrl.todayNote);
              if (ctrl.loading.value) {
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
                    BuildNotifyList(
                      list: ctrl.todayNote,
                      isRead: ctrl.isRead.value,
                      onDismissed: (index) {
                        ctrl.deleteNotify(index, ctrl.todayNote);
                      },
                      markAsRead: (index) {
                        ctrl.markAsRead(index);
                      },
                    ),
                  ],
                  if (ctrl.yesterNote.isNotEmpty) ...[
                    sectionTitle('Yesterday'),
                    BuildNotifyList(
                      list: ctrl.yesterNote,
                      isRead: ctrl.isRead.value,
                      onDismissed: (index) {
                        ctrl.deleteNotify(index, ctrl.yesterNote);
                      },
                      markAsRead: (index) {
                        ctrl.markAsRead(index);
                      },
                    ),
                  ],
                  if (ctrl.otherNote.isNotEmpty) ...[
                    sectionTitle('Older Notifications'),
                    BuildNotifyList(
                      list: ctrl.otherNote,
                      isRead: ctrl.isRead.value,
                      onDismissed: (index) {
                        ctrl.deleteNotify(index, ctrl.otherNote);
                      },
                     markAsRead: (index) {
                        ctrl.markAsRead(index);
                      },
                    ),
                  ],
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return AppText(text: title, textWeigh: FontWeight.bold, textSize: 17);
  }

  void showDeleteAllDialog(BuildContext context, VoidCallback onPressed){
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
              onPressed: onPressed,
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
  }
}

class BuildNotifyList extends StatelessWidget {
  const BuildNotifyList({
    super.key,
    required this.list,
    required this.isRead,
    required this.onDismissed,
    required this.markAsRead,
  });

  final List<NotifyModel> list;
  final Function(int) onDismissed;
  final Function(int) markAsRead;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
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
          child: NotificationCard(
            notify: nt,
            onDismissed: onDismissed,
            isRead: isRead,
            index: index,
            markAsRead: markAsRead,
          ),
        );
      },
      itemCount: list.length,
    );
  }
}

class ShowBottomInfo {
  final viewModel = HomeViewModel();

  void showMoreInfo(BuildContext context, NotifyModel note) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.green.withOpacity(0.4),
      showDragHandle: true,
      enableDrag: true,
      builder: (context) {

        return DraggableScrollableSheet(
          maxChildSize: 1.0,
          initialChildSize: 0.98,
          builder: (_,__) {
            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListView(
                children: [
                  Row(
                    children: [
                      CircleAvatar(child: Icon(Icons.notifications_none)),
                      const SizedBox(width: 10),

                      Expanded(child: Text(note.title,overflow: TextOverflow.ellipsis, maxLines: 3, textAlign: TextAlign.justify, style: TextStyle(fontWeight: FontWeight.bold),)),
                      const SizedBox(width: 20,),
                      Icon(Icons.circle, color: AppColors.primary, size: 10),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 5.0),
                      Icon(Icons.access_alarm, size: 12,),
                      const SizedBox(width: 10),
                      AppText(
                        text: viewModel.formatDate(note.date),
                        textColor: AppColors.superBlue,
                        textSize: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(note.description),
                ],
              ),
            );
          }
        );
      },
    );
  }


}
