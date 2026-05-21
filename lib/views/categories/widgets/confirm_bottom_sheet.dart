
import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/custom_alert_dialog.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/categories/categories.dart';
import 'package:fin_wise/views/categories/widgets/payment+bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBottomSheet {
  final navCtrl = Get.find<CategoryNavCtrl>();
  final acc = Get.find<AccBalanceCtrl>();
  final viewModel = HomeViewModel();

  void confirmBottomSheet(BuildContext context, {
    required double amount,
    required TextEditingController numberCtrl,
    required String productName,
    List? list,
    required Function(String pin) action,
    required double balance,
    String imgPath = '',
    bool data = false,
    String plan = '',
  }) async{
    // await acc.getBalance();
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {

          bool notEnoughAmount = balance < amount;
          // print(notEnoughAmount);
          // print(accCtrl.accountBalance.value);
            return WillPopScope(
              onWillPop: () async {
                bool? shouldPop = await showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(),
                );
                return shouldPop ?? false;
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.directional(
                    topStart: Radius.circular(60),
                    topEnd: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(),
                              );
                            },
                            icon: const Icon(Icons.dangerous_outlined),
                          ), const Spacer(),
                          const AppText(
                            text: 'Add to Beneficiary  ', textColor: Colors.grey,),
                          Transform.scale(
                            scale: 0.8,
                            child:
                            // Obx(() =>
                                Switch(
                                  value: navCtrl.addBeneficiary.value,
                                  activeColor: AppColors.primary,
                                  inactiveTrackColor: AppColors.lightGreen,
                                  inactiveThumbColor: AppColors.primary,
                                  trackOutlineColor: WidgetStateColor.transparent,
                                  onChanged: (val) {
                                    navCtrl.addBeneficiary.value = val;
                                    // navCtrl.addBeneficiaries(list, element);
                                    // if(val){
                                    //   navCtrl.addBene(NumbersModel(provider: navCtrl.selectProvider.value, number: numberCtrl.text, amount: 0));
                                    // }
                                  },
                                ),
                            ),
                          // ),
                        ],
                      ),
                      Center(
                        child: AppText(
                          text: viewModel.formatCurrency(amount),
                          textWeigh: FontWeight.bold,
                          textSize: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      rowTile(
                        'Product Name',
                        Row(
                          children: [
                           imgPath.isEmpty? CircleAvatar(backgroundColor: Theme.of(context).cardColor, child: Text(productName[0], style: TextStyle(fontWeight: FontWeight.bold),)): Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(shape: BoxShape.circle,
                                color: Theme.of(context).cardColor,
                                  image: DecorationImage(image: NetworkImage(imgPath), onError: (_, _)=> Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      shape: BoxShape.circle,
                                    ), )
                                  ), )), const SizedBox(width: 4,),
                            AppText(text: productName),
                          ],
                        ),
                      ),
                      rowTile('Recipient Mobile', AppText(text: numberCtrl.text)),
                      rowTile(
                        'Amount',
                        AppText(text: viewModel.formatCurrency(amount)),
                      ),
                      data ? rowTile('Data Bundle', AppText(text: plan))
                          : const SizedBox(),
                      const Divider(),
                      const AppText(
                        text: 'Payment Method',
                        textWeigh: FontWeight.bold,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const AppText(
                                  text: 'Available Balance',
                                  textWeigh: FontWeight.bold,
                                ),
                                const SizedBox(width: 10),
                                AppText(
                                  text:
                                  viewModel.formatCurrency(balance),
                                  textColor: notEnoughAmount
                                      ? Colors.red
                                      : AppColors.primary,
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.done_outlined,
                                  color: notEnoughAmount? AppColors.declined: AppColors.primary,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            notEnoughAmount
                                ? Row(
                              children: [
                                const AppText(
                                  text: 'Insufficient balance',
                                  textColor: Colors.red,
                                ),
                                Spacer(),
                                TextButton.icon(
                                    style: TextButton.styleFrom(
                                      elevation: 2,
                                        side: BorderSide(color: Colors.white),
                                        foregroundColor: AppColors.primary),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      Get.back();
                                      Get.offNamed(Routes.fundWallet);
                                    }, label: AppText(text: 'Fund Wallet'))
                              ],
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      notEnoughAmount ?
                      DisableButton(label: 'Pay'):
                      AppBtn(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Get.back();
                          PaymentBottomSheet().paymentBottomSheet(context: context, action: action);
                          navCtrl.addBeneficiary.value = false;
                          FocusScope.of(context).unfocus();
                        },
                        label: 'Pay',
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          }
    );
  }

  Widget rowTile(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          AppText(
            text: title,
            textWeigh: FontWeight.bold,
            textSize: 13,
            textColor: Colors.grey,
          ),
          const Spacer(),
          child,
        ],
      ),
    );
  }

}
