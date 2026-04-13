import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/price_form_field.dart';
import 'package:fin_wise/views/home/test.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundWalletPage extends StatefulWidget {
  const FundWalletPage({super.key});

  @override
  State<FundWalletPage> createState() => _FundWalletPageState();
}

class _FundWalletPageState extends State<FundWalletPage> {
  final TextEditingController amountCtrl = TextEditingController();

  final amountKey = GlobalKey<FormFieldState>();

  final formKey = GlobalKey<FormState>();
  bool focused = false;
  bool isOpen = false;

  // bool moved = false;
  @override
  Widget build(BuildContext context) {
    final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();
    return Scaffold(
        body: AnimatedBottomSheet(
          page: PageContainer(
            topMargin: 20,
            topChild: CustomAppBar.header(
              // notificationPage: false,
              title: 'Fund Wallet',
              leftRight: 15,
              onPressed: () => Get.back(),
              // notification: false,
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                //Amount Container
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(2, 3),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const HeadingText(
                        headingText: 'Fund your wallet',
                        textAlign: TextAlign.left,
                      ),

                      InkWell(
                        onTap: acc.virtualAcc.value.isEmpty
                            ? () => Get.toNamed(Routes.generateVirtual)
                            : () {
                                setState(() {
                                  isOpen = true;
                                });
                              },
                        child: Center(
                          child: Obx(
                            () => Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 50,
                              margin: const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                              child: acc.virtualAcc.value.isEmpty
                                  ? AppText(text: 'Get a virtual Account')
                                  : AppText(text: 'Enter amount', textSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(2, 3),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeadingText(
                        headingText: 'Pay via other option',
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8.0),
                      Obx(
                        () => SizedBox(
                          height: (80.00 * acc.paymentGateWay.length),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(acc.paymentGateWay.length, (
                              index,
                            ) {
                              final item = acc.paymentGateWay[index];
                              String select = index.toString();
                              return ListTile(
                                onTap: () {
                                  acc.selectPay.value = select;
                                  setState(() {
                                    isOpen = true;
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> AnimatePosition(amountCtrl: amountCtrl, amountKey: amountKey,)));
                                },
                                leading: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.lightGreen,
                                  child: Icon(
                                    Icons.paypal_outlined,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                                title: AppText(text: item.name),
                                // subtitle: Column(
                                //   children: [
                                //     // AppText(text: item.availbaleServ[0]),
                                //     // AppText(text: item.availbaleServ[1]),
                                //   ],
                                // ),
                                trailing: acc.selectPay.value == select
                                    ? Icon(
                                        Icons.check_circle_rounded,
                                        color: AppColors.primary,
                                      )
                                    : Icon(
                                        Icons.circle_outlined,
                                        color: AppColors.primary,
                                      ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          focused: focused,
          isOpen: isOpen,
          child: bottomContent(() {}, acc),
        ),

    );
  }

  Container bottomContent(VoidCallback onPressed, AccBalanceCtrl acc) {
    return Container(
      height: 250,
      width: 320,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const AppText(text: 'Enter amount to fund', textSize: 20),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isOpen = false;
                    });
                    print(isOpen);
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  AppText(text: '₦', textSize: 20),
                  Expanded(
                    child: PriceFormField(
                      numberCtrl: amountCtrl,
                      hint: AppText(text: 'Enter amount to fund'),
                      color: Colors.transparent,
                      key: amountKey,
                      onTap: () {
                        setState(() {
                          focused = true;
                        });
                      },
                      validator: (val) => Validator.validatePrice(val!),
                      onChanged: (val) => amountKey.currentState!.validate(),
                    ),
                  ),
                ],
              ),
            ),
            // AppText(text: 'Please enter amount you want to fund', textColor: Colors.red,),
            Divider(color: AppColors.lightGreen, thickness: 3),
            AppBtn(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    focused = false;
                    isOpen = false;
                  });
                  onPressed();

                } else {}
                amountCtrl.text = '';
                acc.selectPay.value = '';
              },
              label: 'Proceed to payment',
            ),
          ],
        ),
      ),
    );
  }
}
