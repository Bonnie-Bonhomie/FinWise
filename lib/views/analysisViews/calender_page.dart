import 'package:fin_wise/controllers/analysis/analysis_ctrl.dart';
import 'package:fin_wise/controllers/analysis/calender_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/transaction_card.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatelessWidget {
  CalenderPage({super.key});

  final CalenderCtrl ctrl = Get.find<CalenderCtrl>();
  final AnalysisCtrl analysisCtrl = Get.find<AnalysisCtrl>();

  @override
  Widget build(BuildContext context) {
    final focusedDay = DateTime.now();
    final firstDay = DateTime(2005);
    final lastDay = DateTime(2100);
    return Scaffold(
      body: PageContainer(
        topChild: CustomAppBar.header('Calender', 15, () {
          Get.back();
        }),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Obx(
                  () => Row(
                    children: [
                      PopupMenuButton(
                        itemBuilder: (index) {
                          return List.generate(ctrl.months.length, (index) {
                            return PopupMenuItem(
                              onTap: () {
                                ctrl.month.value = index;
                                ctrl.selectMth();
                              },
                              value: index,
                              child: Text(ctrl.months[index]),
                            );
                          });
                        },
                        onSelected: (val) {
                          ctrl.month.value = val;
                          // print(val);
                        },
                        color: AppColors.lightGreen,
                        child: Row(
                          children: [
                            AppText(
                              text: ctrl.currentMonth(),
                              textColor: AppColors.primary,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Obx(() => PopupMenuButton(
                          itemBuilder: (index) {
                            return List.generate(ctrl.allYear.length, (index) {
                              return PopupMenuItem(
                                onTap: () {
                                  ctrl.yIndex.value = index;
                                  ctrl.selectYear();
                                },
                                value: index,
                                child: Text(ctrl.allYear[index].toString()),
                              );
                            });
                          },
                          onSelected: (val) {
                            ctrl.yIndex.value = val;
                            // print(val);
                          },
                          color: AppColors.lightGreen,
                          child: Row(
                            children: [
                              ctrl.loading.value? CircularProgressIndicator(color: AppColors.lightGreen,):
                              AppText(
                                text: ctrl.currentY(),
                                textColor: AppColors.primary,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Obx(()=> TableCalendar(
                focusedDay: ctrl.focusedDate.value,
                firstDay: firstDay,
                lastDay: lastDay,
                onDaySelected: ctrl.onDaySelected,
                selectedDayPredicate: (day){ return
                    isSameDay(ctrl.selectedDay.value, day);
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: AppColors.blue),
                  weekendStyle: TextStyle(color: AppColors.blue),
                ),
                onPageChanged: (focusDay){
                    ctrl.focusedDate.value = focusDay;
                },
                eventLoader: (day) {
                  final normlized = DateTime(day.year, day.month, day.day);
                  return ctrl.events[normlized] ?? [];
                },
                headerVisible: false,
                calendarStyle: CalendarStyle(
                  canMarkersOverflow: true,
                  selectedDecoration: BoxDecoration(color: AppColors.subBlue, shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              ),

              Row(),
              Obx(() {
                final day = DateTime(ctrl.selectedDay.value.year, ctrl.selectedDay.value.month, ctrl.selectedDay.value.day);

                final transactions = ctrl.events[day] ?? [];
                if(transactions.isEmpty){
                  return const Center(child: AppText(text: 'No transaction'),);
                }
                return ListView.builder(itemBuilder: (_, index){
                    final tx = transactions[index];
                    return TransactionCard(tx: tx);
                });
              }

              )
            ],
          ),
        ),
      ),
    );
  }
}
