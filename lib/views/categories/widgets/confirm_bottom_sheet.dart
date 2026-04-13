import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/numbers_model.dart';
import 'package:fin_wise/utils/widgets/custom_alert_dialog.dart';
import 'package:fin_wise/views/categories/widgets/payment+bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBottomSheet {
  final accCtrl = Get.find<AccBalanceCtrl>();
  final navCtrl = Get.find<CategoryNavCtrl>();

  void confirmBottomSheet(
    BuildContext context, {
    required double amount,
    required TextEditingController numberCtrl,
    required String productName,
    required List list,
    required NumbersModel element,
        String imgPath = '',
    bool data = false,
    String plan = '',
  }) {
    FocusScope.of(context).unfocus();
    final bool notEnoughAmount = accCtrl.accountBalance.value < amount;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: AppColors.bgColor,
      builder: (context) {
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
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.directional(
                topStart: Radius.circular(60),
                topEnd: Radius.circular(60),
              ),
            ),
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
                    ),const Spacer(),
                    const AppText(text: 'Add to Beneficiary  ', textColor: Colors.grey,),
                    Transform.scale(
                      scale: 0.8,
                      child: Obx(() =>
                        Switch(
                          value: navCtrl.addBeneficiary.value,
                          activeColor: AppColors.primary,
                          inactiveTrackColor: AppColors.lightGreen,
                          inactiveThumbColor: AppColors.primary,
                          trackOutlineColor: WidgetStateColor.transparent,
                          onChanged: (val){
                            navCtrl.addBeneficiary.value = val;
                            navCtrl.addBeneficiaries(list, element);
                            // if(val){
                            //   navCtrl.addBene(NumbersModel(provider: navCtrl.selectProvider.value, number: numberCtrl.text, amount: 0));
                            // }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: AppText(
                    text: '₦${amount.toStringAsFixed(2)}',
                    textWeigh: FontWeight.bold,
                    textSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                rowTile(
                  'Product Name',
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.lightGreen,
                        child: imgPath != ''?
                        CircleAvatar(backgroundImage: AssetImage('Assets/productLogo/$imgPath')) : AppText(text: productName[0], textSize: 25,),
                      ),const SizedBox(width: 4,),
                      AppText(text: productName),
                    ],
                  ),
                ),
                rowTile('Recipient Mobile', AppText(text: numberCtrl.text)),
                rowTile(
                  'Amount',
                  AppText(text: '₦${amount.toStringAsFixed(2)}'),
                ),
                data
                    ? rowTile('Data Bundle', AppText(text: plan))
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
                    color: AppColors.lightGreen,
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
                                '(₦${accCtrl.accountBalance.value.toStringAsFixed(2)})',
                            textColor: notEnoughAmount
                                ? Colors.red
                                : Colors.black,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.done_outlined,
                            color: AppColors.primary,
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
                                  style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                                  onPressed: (){
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
                Center(
                  child: notEnoughAmount? AppBtn(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Get.back();
                     PaymentBottomSheet().paymentBottomSheet(context);
                        navCtrl.addBeneficiary.value = false;
                      FocusScope.of(context).unfocus();
                    },
                    label:'Pay',
                  ): DisableButton(label: 'Pay')
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );

  }

  Widget rowTile(String title, Widget child) {
    return Row(
      children: [
        AppText(
          text: title,
          textWeigh: FontWeight.bold,
          textColor: Colors.grey,
        ),
        const Spacer(),
        child,
      ],
    );
  }

}
