import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';
import '../../core/app_colors.dart';
import '../../utils/widgets/custom_linear_progress.dart';
import '../view_widgets/category_card.dart';
import '../view_widgets/transaction_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late AnimationController _headerAnim;
  final HomeViewModel viewModel = HomeViewModel();
  final store = SharedPreferService();

  final acc = Get.find<AccBalanceCtrl>();
  String name = '';

  void getName() async {
    final getNam =
        (await store.retrieve<String>(PrefStoreKeys.username)) ??
        'Welcome back';
    setState(() => name = getNam);
    print(name);
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      getName();
      // (viewModel.greeting());
      acc.getBalance();
    });

    _headerAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _headerAnim.forward();
    super.initState();
  }


  @override
  void dispose() {
    _headerAnim.dispose();
    super.dispose();
  }

  Future<void> onRefresh()async{
    Future.delayed(Duration(seconds: 2), () async{ await acc.getBalance();});
  }

  @override
  Widget build(BuildContext context) {
    final percent = (acc.spentPercent * 100).round();
    final nav = Get.find<NavControl>();
    // final acc = Get.find<AccBalanceCtrl>();
    final trans = Get.find<TransactionCtrl>();

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Obx(() {
            return RefreshIndicator(
              onRefresh: onRefresh,
              color: AppColors.primary,
              backgroundColor: Colors.white,
              child: PageContainer(
                topMargin: 10,
                topChild: Column(
                  children: [
                    _header(viewModel.greeting()),
                    headerCard(context, percent.toDouble(), acc),
                  ],
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
                            index: 1,
                            width: 50,
                            iconSize: 25,
                            icon: Categories.airtime.icon,
                            title: Categories.airtime.label,
                            onTap: () => Get.toNamed(Routes.airtime),
                          ),
                          CategoriesCard(
                            index: 2,
                            width: 50,
                            iconSize: 30,
                            icon: Categories.data.icon,
                            title: Categories.data.label,
                            onTap: () => Get.toNamed(Routes.data),
                          ),
                          CategoriesCard(
                            index: 3,
                            width: 50,
                            iconSize: 25,
                            icon: Categories.cable.icon,
                            title: Categories.cable.label,
                            onTap: () => Get.toNamed(Routes.tv),
                          ),
                          CategoriesCard(
                            index: 4,
                            width: 50,
                            iconSize: 25,
                            icon: Icons.interests,
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
                      Expanded(child: BuildTransaction(trans: trans)),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.gradientGreen],
              ),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10.0, offset: Offset(3, 10)),
              ],
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Obx(() {
                  return Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.compass_calibration_sharp,
                            // color: AppColors.primary,
                          ),
                          Text('Acc. Balance'),
                        ],
                      ),
                      acc.loading.value
                          ? SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 3.0),
                              child: acc.balanceErr.value.isEmpty
                                  ? AppText(
                                      text: viewModel.formatCurrency(acc.accountBalance.value),
                                      textColor: AppColors.lightGreen,
                                      textWeigh: FontWeight.bold,
                                      textSize: 20,
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(
                                        3.0,
                                      ), // height: 30,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        acc.balanceErr.value,
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                    ),
                            ),
                    ],
                  );
                }),
                Spacer(),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.fundWallet);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.white)
                        ),
                        child: const AppText(text: 'Fund Wallet'),
                      ),
                    ),
                    acc.virtualAcc.value.isEmpty
                        ? SizedBox.shrink()
                        : AppText(text: acc.virtualAcc.value),
                  ],
                ),

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
              BalanceCard(
                title: 'Income',
                value: acc.accountBalance.value,
                icon: Icons.arrow_circle_up_outlined,
              ),
              Spacer(),
              BalanceCard(
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
                    '$percent% of Your Expenses, Look ${accountState[viewModel.getState(percent)]}.',
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
    VoidCallback? onTap,
    Widget? error,
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
          SlideTransition(
            position: Tween<Offset>(
                begin: const Offset(-0.3, 0), end: Offset.zero)
                .animate(CurvedAnimation(
                parent: _headerAnim, curve: Curves.easeOut)),
            child: FadeTransition(
              opacity: _headerAnim,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  AppText(
                    text: 'Hi ${name.split(' ').first}',
                    textWeigh: FontWeight.bold,
                    textSize: 20,
                  ),
                  AppText(text: greet, textSize: 13),
                ],
              ),
            ),
          ),

          const Spacer(),
          Icon(Icons.person),
        ],
      ),
    );
  }
}
