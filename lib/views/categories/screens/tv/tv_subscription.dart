import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/television_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_export.dart';
import 'package:fin_wise/utils/widgets/widget.dart';
import 'package:fin_wise/data/models/cable_model.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/empty_state.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
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
  int maxLength = 10;

  final tvCtrl = Get.find<TelevisionCtrl>();
  final loaderCtrl = Get.find<LoaderController>();
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();
  final viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() async {
      await tvCtrl.getCableBundle(id: tvDetails.id);
      await acc.getBalance();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    Future.delayed(Duration(seconds: 1), () async {
      await acc.getBalance();
      await tvCtrl.getCableBundle(id: tvDetails.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    tvDetails = Get.arguments ?? tvCtrl.availableCable[0];
    print(tvDetails);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: LoaderWrapper(
          child: Obx(() {
            return PageContainer(
              topMargin: 30,
              bottomPadding: 30,
              topChild: CustomAppBar.header(
                title: tvDetails.serviceId.toUpperCase(),
                leftRight: 15,
                onPressed: () => Get.back(),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                children: [
                  ListTile(
                    title: AppText(text: tvDetails.name, textSize: 22,),
                    titleTextStyle: TextStyle(overflow: TextOverflow.ellipsis),
                    leading: CircleAvatar(
                      child: Text(
                        tvDetails.name[0],
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
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
                        colors: [
                          Colors.grey.shade300,
                          // Theme.of(context).scaffoldBackgroundColor,
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor,
                          Theme.of(context).cardColor,
                        ],
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
                                length: maxLength,
                                hint: const AppText(
                                  text: 'Enter Your Smartcard Number',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    correctNumber = value.length == maxLength;
                                  });
                                },
                              ),
                            ),
                            tvCtrl.verified.value
                                ? Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.greenAccent,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: Icon(
                                      Icons.person_add_alt_1_rounded,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : correctNumber
                                ? SizedBox(
                                    height: 25,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        loaderCtrl.offLoading(() async {
                                          await tvCtrl.verifySmartCard(
                                            smartcard: smartCardCtrl.text,
                                            id: tvDetails.serviceId,
                                          );
                                        });
                                      },
                                      child: Text(
                                        'Verify',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        const Divider(color: AppColors.lightGreen, height: 2),
                        tvCtrl.verifyLoad.value
                            ? Row(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                    width: 8,
                                    child: CircularProgressIndicator(),
                                  ),
                                  const SizedBox(width: 8.0),
                                  AppText(
                                    text: 'verifying the smartcard number...',
                                    textColor: AppColors.primary,
                                  ),
                                ],
                              )
                            : tvCtrl.verified.value
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 8.0),
                                  AppText(
                                    text: tvCtrl.verifyDet['Customer_Name'] ?? 'null',
                                    textColor: AppColors.primary,
                                  ),
                                ],
                              )
                            : AppText(
                                text: tvCtrl.verifyErr.value,
                                textColor: AppColors.declined,
                                textAlign: TextAlign.start,
                              ),

                        ///Details after verification
                        tvCtrl.verified.value
                            ? Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.all(15),
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(
                                    context,
                                  ).scaffoldBackgroundColor,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    tvDetails.id == 3? rowTile(
                                      text: 'Type',
                                      child: AppText(
                                        text: tvCtrl.verifyDet['commission_details']['computation_type'] ?? 'null',
                                        textSize: 13,
                                      ),
                                    ):rowTile(
                                      text: 'Due Date',
                                      child: AppText(
                                        text: tvCtrl.verifyDet['Due_Date'] ?? 'null',
                                        textSize: 13,
                                      ),
                                    ),
                                    tvDetails.id == 3? rowTile(
                                      text: 'Balance',
                                      child: AppText(
                                        textSize: 13,
                                        text:
                                        tvCtrl.verifyDet['Balance'] ??
                                            'null',
                                      ),
                                    ):rowTile(
                                      text: 'Customer Type',
                                      child: AppText(
                                        textSize: 13,
                                        text:
                                            tvCtrl.verifyDet['Customer_Type'] ??
                                            'null',
                                      ),
                                    ),
                                   tvDetails.id == 3? SizedBox.shrink(): rowTile(
                                      text: 'Status',
                                      child: AppText(
                                        textSize: 13,
                                        text:
                                            tvCtrl.verifyDet['Status'] ??
                                            'null',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
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
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: buildColumn(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          // child: premiumBuild(),
                          child: Center(
                            child: EmptyState(
                              message: 'Premium service is unavailable',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }


  Widget buildColumn() {
    int len = tvCtrl.cablePrices.length + 1;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      runSpacing: 10,
      spacing: 10,
      children: List.generate(len, (index) {


        if (index == 0) {
          return amountBox();
        }

        final service = tvCtrl.cablePrices[index - 1];
        final amount = double.parse(service.price);
        return SharedWidget.serviceBox(
          context: context,
          title: service.name,
          amount: '₦${service.price}',
          // duration: '${serv.duration} Month',
          onTap: () {
            FocusScope.of(context).unfocus();
            !correctNumber?  CustomSnackbar.showSnackbar(
              message: 'Enter your smart card number',
            ): tvCtrl.verified.value
                ? loaderCtrl.offLoading(() async{
                  await acc.getBalance();
                    ConfirmBottomSheet().confirmBottomSheet(
                      context,
                      amount: amount,
                      numberCtrl: smartCardCtrl,
                      productName: 'cable',
                      balance: acc.accountBalance.value,
                      list: [],
                      plan: tvDetails.serviceId,
                      action: (pin) async {
                        await tvCtrl.buyTvService(
                          phone: tvCtrl.verifyDet['Customer_Number'],
                          smartcard: smartCardCtrl.text,
                          subType: 'change',
                          transPin: pin,
                          productId: service.id,
                        );
                        FocusScope.of(context).unfocus();
                      },

                    );
                  }): CustomSnackbar.warningSnack('Verify your smart card number to continue');
          },
        );
      }),
    );
  }

  Widget buildLeftColumn() {
    return Column(
      children: List.generate(tvCtrl.cablePrices.length, (index) {
        final service = tvCtrl.cablePrices[index];
        final amount = double.parse(service.price);
        return SharedWidget.serviceBox(
          context: context,
          title: service.cableCode,
          amount: '₦${service.price}',
          // duration: '${serv.duration} Month',
          onTap: () {
            smartCardCtrl.text.isNotEmpty
                ? loaderCtrl.offLoading(() {
                    ConfirmBottomSheet().confirmBottomSheet(
                      context,
                      amount: amount,
                      numberCtrl: smartCardCtrl,
                      productName: 'cable',
                      balance: acc.accountBalance.value,
                      list: [],
                      imgPath: '',
                      plan: tvDetails.serviceId,
                      action: (pin) {
                        // tvCtrl.buyTvService(phone: tvCtrl.phone.value, smartcard: smartCardCtrl.text, id: tvDetails.serviceId, subType: subType, transPin: transPin, productId: productId)
                      },
                    );
                  })
                : CustomSnackbar.showSnackbar(
                    message: 'Enter your smart card number',
                  );
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
          color: Theme.of(context).cardColor,
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
                      color: Colors.orangeAccent.shade100.withValues(
                        alpha: 0.5,
                      ),
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

  Widget amountBox() {
    return serviceBox(
      title: '${tvDetails.serviceId} Renewal',
      amount: 'Enter amount',
      onTap: () {
        !tvCtrl.verified.value? CustomSnackbar.warningSnack('Verify your Smartcard to continue'):
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: Colors.white,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PriceInputField(
                      amountCtrl: amountCtrl,
                      numberCtrl: smartCardCtrl,
                      productName: '${tvDetails.serviceId} subscription',
                      onBack: ()=> Get.back(),
                      lowestAmount: 500,
                      errMessage: 'Enter your smartcard number',
                      balance: acc.accountBalance.value,
                      action: (pin) async {
                        await tvCtrl.buyTvService(
                          phone: tvCtrl.verifyDet['Customer_Number'],
                          smartcard: smartCardCtrl.text,
                          subType: 'change',
                          transPin: pin,
                          productId: '1',
                        );
                      },
                    ),
                    CancelBtn(onPressed: () => Get.back()),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        );
        amountCtrl.text = '';
      },
    );
  }
}

