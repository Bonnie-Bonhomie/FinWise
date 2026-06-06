import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/television_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/views/view_export.dart';
import 'package:fin_wise/utils/widgets/widget.dart';
import 'package:fin_wise/data/models/cable_model.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/empty_state.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvSubscription extends StatefulWidget {
  const TvSubscription({super.key});

  @override
  State<TvSubscription> createState() => _TvSubscriptionState();
}

class _TvSubscriptionState extends State<TvSubscription>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController smartCardCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();

  //Selected Tv
  CableModel tvDetails = Get.arguments;
  bool correctNumber = false;

  final tvCtrl = Get.find<TelevisionCtrl>();
  final loaderCtrl = Get.find<LoaderController>();
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    tvCtrl.getCableBundle(id: tvDetails.id);
    acc.getBalance();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    Future.delayed(Duration(seconds: 1), () async{
      await acc.getBalance();
      await  tvCtrl.getCableBundle(id: tvDetails.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    tvDetails = Get.arguments ?? tvCtrl.availableCable[0];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: LoaderWrapper(
          child: PageContainer(
            topMargin: 10,
            bottomPadding: 10,
            topChild: CustomAppBar.header(
              title: tvDetails.serviceId.toUpperCase(),
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                ListTile(
                  title: AppText(text: tvDetails.name),
                  titleTextStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: CircleAvatar(child: Text(tvDetails.name[0], style: TextStyle(fontWeight: FontWeight.bold),),),
                ),
                const Divider(color: AppColors.lightGreen),
                const SizedBox(height: 10),
                AppText(text: tvDetails.name, textColor: AppColors.primary),

                Container(
                  padding: EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [AppColors.lightGreen, Theme.of(context).cardColor],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    ),
                  ),
                  child: Column(
                    children: [
                      rowTile(
                        text: 'Smartcard Number',
                        child: InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              AppText(text: 'Beneficiaries'),
                              Icon(Icons.arrow_right),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: PriceFormField(
                              numberCtrl: smartCardCtrl,
                              hint: const AppText(
                                text: 'Enter Your Smartcard Number',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  correctNumber = value.length == 11;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.lightGreen, height: 2),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    border: const Border(
                      bottom: BorderSide(color: AppColors.primary, width: 4),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelStyle: const TextStyle(fontSize: 20),
                  tabs: [
                    const Tab(text: 'Hot Offers'),
                    const Tab(text: 'Premium'),
                  ],
                ),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: ListView(
                          padding: const EdgeInsets.only(top: 8.0),
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                serviceBox(
                                  title: '${tvDetails.serviceId} Renewal',
                                  amount: 'Enter amount',
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              PriceInputField(
                                                amountCtrl: amountCtrl,
                                                numberCtrl: smartCardCtrl,
                                                productName: '${tvDetails.serviceId} subscription',
                                                lowestAmount: 2000,
                                                errMessage: 'Enter your smartcard number',
                                                balance: acc.accountBalance.value,
                                                action: (pin){},
                                              ),
                                              CancelBtn(
                                                onPressed: () => Get.back(),
                                              ),
                                              const SizedBox(height: 15),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                    amountCtrl.text = '';
                                  },
                                ),
                                buildProductColumn(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        // child: premiumBuild(),
                        child: Center(child: EmptyState(message: 'Premium service is unavailable')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Wrap premiumBuild() {
  //   return Wrap(
  //     crossAxisAlignment: WrapCrossAlignment.center,
  //     spacing: 15,
  //     runSpacing: 5.0,
  //     children: List.generate(tvCtrl.premiumService.length, (index) {
  //       final serv = tvCtrl.premiumService[index];
  //       return serviceBox(
  //         title: serv.title,
  //         amount: '₦${serv.amount}',
  //         duration: '${serv.duration} Month',
  //         onTap: () {
  //           final amount = double.parse(serv.amount);
  //           // smartCardCtrl.text.isNotEmpty
  //           //     ? loaderCtrl.offLoading((){
  //           //   ConfirmBottomSheet().confirmBottomSheet(
  //           //     context,
  //           //     amount: amount,
  //           //     numberCtrl: smartCardCtrl,
  //           //     productName: 'cable',
  //           //   );
  //           // })
  //           //     : CustomSnackbar.showSnackbar(message: 'Enter your smartcard number');
  //         },
  //       );
  //     }),
  //   );
  // }

  Widget buildProductColumn() {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      runAlignment: WrapAlignment.center,
      children: List.generate(tvCtrl.cablePrices.length, (index) {
        final serv = tvCtrl.cablePrices[index];
        final amount = double.parse(serv.price);
          print(amount);
        // if (index == 0 && isLeft) {}
        return serviceBox(
          title: '${tvDetails.serviceId} ${serv.cableCode}',
          amount: '₦${serv.price}',
          // duration: '${serv.duration} Month',
          onTap: () {
            smartCardCtrl.text.isNotEmpty
                ? loaderCtrl.offLoading((){
              ConfirmBottomSheet().confirmBottomSheet(
                context,
                amount: amount,
                numberCtrl: smartCardCtrl,
                productName: 'cable',
                balance: acc.accountBalance.value,
                list: [],
                imgPath: '',
                plan: tvDetails.serviceId,
                action: (pin){
                  // tvCtrl.buyTvService(phone: tvCtrl.phone.value, smartcard: smartCardCtrl.text, id: tvDetails.serviceId, subType: subType, transPin: transPin, productId: productId)
                }
              );
            })
                :CustomSnackbar.showSnackbar(message: 'Enter your smart card number');
          },
        );
      }),
    );
  }

  Widget serviceBox({
    required String title,
    required String amount,
    required VoidCallback onTap,
    String duration = '',
    IconData? icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: title, textSize: 16, textWeigh: FontWeight.bold),
            duration == ''
                ? SizedBox.shrink()
                : Container(
                    padding: const EdgeInsets.all(3.4),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.shade100.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: AppText(
                      text: duration,
                      textColor: Colors.orange,
                      textWeigh: FontWeight.bold,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  AppText(text: amount),
                  const Spacer(),
                  Icon(icon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //For common Rows
  Row rowTile({required String text, required Widget child}) {
    return Row(
      children: [
        AppText(text: text, textSize: 14),
        const Spacer(),
        child,
      ],
    );
  }
}
