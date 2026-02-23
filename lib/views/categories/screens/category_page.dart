import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/section_divider.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/custom_linear_progress.dart';
import 'package:fin_wise/views/view_widgets/category_card.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();

  final airtime = Categories.airtime;
  final data = Categories.data;
  final cable = Categories.cable;
  final elect = Categories.electricity;
  final education = Categories.education;
  final invite = Categories.invitation;
  final chow = Categories.chowDeck;
  final solar = Categories.solar;
  final gift = Categories.gift;

  @override
  Widget build(BuildContext context) {
    final percent = (acc.spentPercent * 100);

    return Scaffold(
      body: PageContainer(
        topMargin: 30,
        bottomPadding: 15,
        topChild: Column(
          children: [
            CustomAppBar.header('Categories', 15, () {}),
            headerCard(context, percent),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 25,
            runSpacing: 40,
            children: [
              CategoriesCard(
                icon: airtime.icon,
                title: airtime.label,
                onTap: () => Get.toNamed(Routes.airtime),
              ),
              CategoriesCard(
                icon: data.icon,
                title: data.label,
                onTap: () => Get.toNamed(Routes.data),
              ),
              CategoriesCard(
                icon: cable.icon,
                title: cable.label,
                onTap: () => Get.toNamed(Routes.tv),
              ),
              CategoriesCard(
                icon: elect.icon,
                title: elect.label,
                onTap: () => Get.toNamed(Routes.elect),
              ),
              CategoriesCard(
                icon: education.icon,
                title: education.label,
                onTap: () => Get.toNamed(Routes.education),
              ),
              CategoriesCard(
                icon: chow.icon,
                title: chow.label,
                onTap: () {showToast();},
                color: AppColors.subBlue,
              ),
              CategoriesCard(
                icon: invite.icon,
                title: invite.label,
                color: AppColors.subBlue,
                onTap: () {showToast();},
              ),
              CategoriesCard(
                icon: solar.icon,
                title: solar.label,
                color: AppColors.subBlue,
                onTap: () {showToast();}),
              CategoriesCard(
                icon: gift.icon,
                title: gift.label,
                onTap: () {
                 showToast();
                },
                color: AppColors.subBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //All the Header card
  Container headerCard(BuildContext context, double percent) {
    int getState(percent) {
      final int index;
      if (percent < 70) {
        index = 0;
      } else {
        index = 1;
      }
      return index;
    }

    final List<String> accountState = ['Good', 'Bad'];
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                totalBox(
                  title: "Acc. Balance",
                  value: '₦${acc.accountBalance.value.toStringAsFixed(2)}',
                  icon: Icons.arrow_circle_up_outlined,
                  color: AppColors.bgColor,
                ),
                Spacer(),
                SectDivider(colors: AppColors.bgColor),
                Spacer(),
                totalBox(
                  title: "Total Expenses",
                  value: '₦${acc.expense.value.toStringAsFixed(2)}',
                  color: Color(0xFF0000FF),
                  icon: Icons.arrow_circle_down_outlined,
                ),
              ],
            ),
          ),
          CustomLinearProgress(
            total: ' ${acc.spendingLimit.value.toStringAsFixed(2)}',
            percent: percent,
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline),
              AppText(
                text:
                    ' ${percent.toInt()}% of Your Expenses, Look ${accountState[getState(percent)]}.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // This show the account balance
  Column totalBox({
    required String title,
    required var value,
    required IconData icon,
    required Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            AppText(text: title),
          ],
        ),
        AppText(
          text: value,
          textWeigh: FontWeight.bold,
          textColor: color,
          textSize: 17,
        ),
      ],
    );
  }

  void showToast(){
    Fluttertoast.showToast(msg: 'Service Unavailable', backgroundColor: AppColors.primary);
  }
}
