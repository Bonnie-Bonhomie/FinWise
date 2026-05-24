import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/views/categories/service_export.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirtimeView extends StatefulWidget {
  const AirtimeView({super.key});

  @override
  State<AirtimeView> createState() => _AirtimeViewState();
}

class _AirtimeViewState extends State<AirtimeView> {
  final ctrl = Get.find<AirtimeCtrl>();
  final navCtrl = Get.find<CategoryNavCtrl>();
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();
  final GlobalKey<FormFieldState> numKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> amountKey = GlobalKey<FormFieldState>();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();

  List<int> topUp = [50, 100, 200, 500, 1000, 2000];
  bool isOpen = false;
  double amount = 0.00;

  //To convert the Price to double

  @override
  void initState() {
    // TODO: implement initState
    acc.getBalance();
    super.initState();
  }

  Future<void> onRefresh() async {
    Future.delayed(Duration(seconds: 3), ()  async{ await ctrl.getNetworks();
    await acc.getBalance();});
  }

  @override
  Widget build(BuildContext context) {
    final loadCtrl = Get.find<LoaderController>();
    return Scaffold(
      body: LoaderWrapper(
        child: RefreshIndicator(
          onRefresh: () async => onRefresh,

          child: PageContainer(
            bottomPadding: 20,
            topMargin: 20,
            topChild: CustomAppBar.header(
              title: 'Buy Airtime',
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: TopFormWidget(
              numberCtrl: numberCtrl,
              networks: ctrl.airtimeNet,
              // numSelect: ctrl.airtimeBenes[0],
              beneficiaries: ctrl.airtimeBenes,
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).cardColor,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 20,
                        spacing: 20,
                        children: List.generate(topUp.length, (index) {
                          final topAmount = topUp[index];
                          return ProductCard(
                            onTap: () {
                              amountCtrl.text = '${topAmount.toString()}.00';

                              FocusScope.of(context).unfocus();
                              ctrl.airtimeNet.isEmpty?
                              CustomSnackbar.showSnackbar(message: 'Unable to load available networks'):
                              numberCtrl.text.isNotEmpty
                                  ? loadCtrl.offLoading(() {
                                      setState(() {
                                        amount = topAmount.toDouble();
                                      });

                                      final imgPath = ctrl
                                          .airtimeNet[navCtrl.select.value].imgPath;

                                      final networkId = ctrl.airtimeNet[navCtrl.select.value].serviceId;
                                      ConfirmBottomSheet().confirmBottomSheet(
                                        list: ctrl.airtimeBenes,
                                        balance: acc.accountBalance.value,
                                        context,
                                        amount: amount,
                                        numberCtrl: numberCtrl,
                                        productName: '${networkId.toUpperCase()}Airtime',
                                        imgPath: imgPath,
                                        action: (pin) async {

                                          await ctrl.buyAirtime(
                                            amount: amount,
                                            number: numberCtrl.text,
                                            netId: networkId,
                                            pin: pin,
                                          );
                                        },
                                      );
                                    })
                                  : CustomSnackbar.showSnackbar(
                                      message: 'Enter recipient number',
                                    );
                              amount = 0.00;
                            },
                            child: AppText(text: '₦${topAmount.toString()}'),
                          );
                        }),
                      ),
                    ),
                  ),
                  PriceInputField(
                    amountCtrl: amountCtrl,
                    numberCtrl: numberCtrl,
                    productName: 'Airtime',
                    balance: acc.accountBalance.value,
                    action: (pin) {
                      ctrl.buyAirtime(
                        amount: amount,
                        number: numberCtrl.text,
                        netId: ctrl.airtimeNet[navCtrl.select.value - 1].serviceId,
                        pin: pin,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
