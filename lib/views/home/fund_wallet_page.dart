import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils_export.dart';
import '../../viewModel/home_view_model.dart';

class FundWalletPage extends StatefulWidget {
  const FundWalletPage({super.key});

  @override
  State<FundWalletPage> createState() => _FundWalletPageState();
}

class _FundWalletPageState extends State<FundWalletPage> {
  final TextEditingController amountCtrl = TextEditingController();
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();
  final viewModel = HomeViewModel();
  bool focused = false;
  // bool hasText = false;

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async {
      await acc.getPayemntChannels();
    });
    super.initState();
  }

  Future<void> onRefresh() async {
    await acc.getPayemntChannels();
  }

  // bool moved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: PageContainer(
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
                  color: Theme.of(context).cardColor,
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
                      // onTap: acc.virtualAcc.value.isEmpty
                      //     ? () => Get.toNamed(Routes.generateVirtual)
                      //     : () {
                      //         // setState(() {
                      //         //   isOpen = true;
                      //         // });
                      //       },
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
                  color: Theme.of(context).cardColor,
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
                    Obx(() {
                      if (acc.loading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (acc.paymentGateWay.isEmpty) {
                        return Column(
                          children: [
                            Icon(Icons.emergency_outlined),
                            AppText(
                              text: acc.channelErr.value,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(acc.paymentGateWay.length, (
                          index,
                        ) {
                          final item = acc.paymentGateWay[index];
                          int select = int.parse(item.id);
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ListTile(
                              onTap: () {
                                acc.selectPay.value = select;
                                showPaymentSheet(context, index);
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                // backgroundColor: AppColors.lightGreen,
                                child: Image.network(
                                  item.imgUrl,
                                  width: 100,
                                  height: 100,
                                  // fit: BoxFit.scaleDown,
                                  errorBuilder: (context, __, ___) {
                                    return Icon(Icons.paypal);
                                  },
                                ),
                              ),
                              title: AppText(text: item.name),
                              trailing: acc.selectPay.value == select
                                  ? Icon(
                                      Icons.check_circle_rounded,
                                      color: AppColors.primary,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                      color: AppColors.primary,
                                    ),
                            ),
                          );
                        }),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void showPaymentSheet(BuildContext context, int index){
    bool hasText = false;
     showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.green.withOpacity(0.4),
      isDismissible: false,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
         margin: const EdgeInsets.all(20),
         decoration: BoxDecoration(
           color: Theme.of(context,).scaffoldBackgroundColor,
           borderRadius: BorderRadius.circular(20),
         ),
          child: Obx((){
            final selected = acc.paymentGateWay[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  Row(
                    children: [
                      AppText(
                        text: '${selected.name} Gateway',
                        textSize: 17,
                        textColor: AppColors.primary,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                        ),
                      ),
                    ],
                  ),
                  const AppText(
                    text: 'Enter amount to fund',
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        AppText(
                          text: '₦',
                          textSize: 20,
                        ),
                        Expanded(
                          child: PriceFormField(
                            numberCtrl: amountCtrl,
                            hint: AppText(text: 'Enter amount to fund',),
                            color: Colors.transparent,
                            onChanged: (val){
                              double value = viewModel.parseAmount(val);
                              acc.fillAmount(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // AppText(text: 'Please enter amount you want to fund', textColor: Colors.red,),
                  Divider(
                    color: AppColors.lightGreen,
                    thickness: 3,
                  ),
                  acc.isFilled.value? AppBtn(
                    onPressed: () {
                      // amountCtrl.text = '';
                      // acc.selectPay.value = '';
                      print(acc.selectPay.value);
                    },
                    label: 'Proceed',
                  ): DisableButton(label: 'Proceed'),
                ],
              );
            }
          ),
        );
      },
    );
  }
}
