import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/controllers/bottom_nav_ctrl.dart';
import 'package:fin_wise/controllers/transaction/transaction_ctrl.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/section_divider.dart';
import '../../utils/widgets/custom_linear_progress.dart';
import '../view_widgets/category_card.dart';
import '../view_widgets/transaction_card.dart';

class HomePage extends GetView<AccBalanceCtrl> {
  HomePage({super.key});

  final HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final percent = (controller.spentPercent * 100).round();
    final nav = Get.find<NavControl>();
    final trans = Get.find<TransactionCtrl>();
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: PageContainer(
            topMargin: 10,
            topChild: Obx(
              () => Column(
                children: [
                  _header(viewModel.greeting()),
                  headerCard(context, percent.toDouble(), controller),
                ],
              ),
            ),
            //The Bottom Section [Transaction lists]
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoriesCard(
                        width: 50,
                        iconSize: 25,
                        icon: Categories.airtime.icon,
                        title: Categories.airtime.label,
                        onTap: () => Get.toNamed(Routes.airtime),
                      ),
                      CategoriesCard(
                        width: 50,
                        iconSize: 30,
                        icon: Categories.data.icon,
                        title: Categories.data.label,
                        onTap: () => Get.toNamed(Routes.data),
                      ),
                      CategoriesCard(
                        width: 50,
                        iconSize: 25,
                        icon: Categories.cable.icon,
                        title: Categories.cable.label,
                        onTap: () => Get.toNamed(Routes.tv),
                      ),
                      CategoriesCard(
                        width: 50,
                        iconSize: 25,
                        icon: Icons.category_outlined,
                        title: 'More',
                        onTap: () {
                          nav.selectInd.value = 1;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      const AppText(
                        text: "Transactions",
                        textSize: 20,
                        textWeigh: FontWeight.bold,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          nav.selectInd.value = 2;
                        },
                        child: const AppText(text: 'See all'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: buildTransaction(trans)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTransaction(TransactionCtrl trans) {
    final transact = trans.transacts;
    int getLen(){
      int len;
      if(transact.length < 3){
        len = transact.length;
      }else{
        len = 3;
      }
      return len;
    }
    if(transact.isEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('Assets/images/green_empty.png'), height: 120, width: 120,),
          AppText(text: 'Oops!', textSize: 18,),
          AppText(text: 'No transaction history ', textSize: 17,textWeigh: FontWeight.w300,)
        ],
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: 5),
      itemCount: getLen(),
      itemBuilder: (context, index) {
        final tx = transact[index];
        return TransactionCard(tx: tx);
      },
    );
  }

  //All the Header card
  Container headerCard(
    BuildContext context,
    double percent,
    AccBalanceCtrl acc,
  ) {
    final List<String> accountState = ['Good', 'Bad'];
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                totalBox(
                  title: "Acc. Balance",
                  value: '₦${acc.accountBalance.value.toStringAsFixed(2)}',
                  icon: Icons.arrow_circle_up_outlined,
                  color: AppColors.bgColor,
                ),
                Spacer(),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(onTap: (){
                      Get.toNamed(Routes.fundWallet);
                    },
                        child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: AppColors.bgColor,
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: const AppText(text: 'Fund Wallet'))),
                    acc.virtualAcc.value.isEmpty? SizedBox.shrink(): AppText(text: acc.virtualAcc.value),
                  ],
                )

                // SectDivider(colors: AppColors.bgColor),
                // Spacer(),
                // totalBox(
                //   title: "Virtual Account",
                //   value: acc.virtualAcc.value.isEmpty? 'Generate': acc.virtualAcc.value.toString(),
                //   onTap:  acc.virtualAcc.value.isEmpty? (){
                //     Get.toNamed(Routes.generateVirtual);
                //   }: (){},
                //   color: Color(0xFF0000FF),
                //   icon: Icons.arrow_circle_down_outlined,
                // ),
              ],
            ),
          ),
          CustomLinearProgress(
            total: ' ${acc.spendingLimit.value.toStringAsFixed(2)}',
            percent: percent,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              balanceCard(
                title: 'Income',
                value: acc.accountBalance.value,
                icon: Icons.arrow_circle_up_outlined,
              ),
              Spacer(),
              balanceCard(
                title: 'Expense',
                icon: Icons.arrow_circle_down_rounded,
                value: acc.expense.value,
                iconColor: Color(0xFF0033FF),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline),
              AppText(
                text:
                    ' $percent% of Your Expenses, Look ${accountState[viewModel.getState(percent)]}.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // This show the Income and the expense box
  Container balanceCard({
    required String title,
    required IconData icon,
    Color? iconColor,
    required var value,
  }) {
    return Container(
      height: 90,
      width: 150,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? AppColors.primary),
          Text(title),
          AppText(
            text: '₦${value.toStringAsFixed(2)}',
            textColor: iconColor,
            textWeigh: FontWeight.bold,
            textSize: 22,
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
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(icon),
            AppText(text: title),
          ],
        ),
        InkWell(
          onTap: onTap,
          child: AppText(
            text: value,
            textWeigh: FontWeight.bold,
            textColor: color,
            textSize: 20,
            // textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  //Name and header greeting
  Widget _header(String greet) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: 'Hi, Welcome Back',
                textWeigh: FontWeight.bold,
                textSize: 15,
              ),
              AppText(text: greet),
            ],
          ),
          const Spacer(),
          Icon(Icons.person, color: AppColors.bgColor,)
        ],
      ),
    );
  }
}
