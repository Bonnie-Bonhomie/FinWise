
import 'package:data_boot/controllers/controller_exports.dart';
import 'package:data_boot/core/Routes/routes.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/utils/utils_export.dart';
import 'package:data_boot/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:data_boot/viewModel/home_view_model.dart';
import 'package:data_boot/views/categories/service_export.dart';
import 'package:data_boot/views/view_widgets/empty_state.dart';
import 'package:data_boot/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricityView extends StatefulWidget {
  const ElectricityView({super.key});

  @override
  State<ElectricityView> createState() => _ElectricityViewState();
}

class _ElectricityViewState extends State<ElectricityView> {
  int prepaid = 0;
  int selectPaid = 0;

  // List<int> prices = [1000, 2000, 3000, 4000, 5000, 10000];
  List<String> electType = ['Prepaid', 'Postpaid'];
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController meterCtrl = TextEditingController();
  final viewModel = HomeViewModel();

  final loadCtrl = Get.find<LoaderController>();
  final electCtrl = Get.find<ElectricityCtrl>();
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();
  bool correctMeter = false;
  int meterLen = 13;
  String error = '';

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async{await acc.getBalance();});
    super.initState();
  }

  Future<void> onRefresh() async {
    Future.delayed(Duration(seconds: 1), () async {
      await electCtrl.getElectricDiscos();
      await acc.getBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: LoaderWrapper(
          child: PageContainer(
            topMargin: 20,
            bottomPadding: 20,
            topChild: CustomAppBar.header(
              title: 'Electricity',
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: Obx(() {

              if (electCtrl.discoLoad.value) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (electCtrl.selectedElect.value == null) {
                return EmptyState(message: electCtrl.discoErr.value);
              }
              final select = electCtrl.selectedElect.value;
              return ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.lightGreen,
                        child: Image.network(
                          select!.imgPath,
                          errorBuilder: (context, _, _) => CircleAvatar(
                            backgroundColor: Theme.of(context).cardColor,
                            child: Text(
                              select.name[0],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      AppText(text: select.name),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          final selectElect = await Get.toNamed(
                            Routes.availableElect,
                          );
                          electCtrl.updateElect(selectElect);

                        },
                        icon: const Icon(Icons.arrow_right),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      2,
                      (index) => electTypeBox(electType[index], () {
                        setState(() {
                          selectPaid = index;
                        });
                      }, index),
                    ),
                  ),

                  //Input Data
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        rowTile(
                          text: 'Meter / Account Number',
                          child: const AppText(text: 'Beneficiaries'),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: PriceFormField(
                                numberCtrl: meterCtrl,
                                length: meterLen,
                                hint: const AppText(text: 'Enter Meter number'),

                                onChanged: (value) {
                                  setState(() {
                                    correctMeter = value.length == meterLen;
                                  });
                                 if(!correctMeter){
                                   electCtrl.verified.value = false;
                                 }
                                },
                                onComplete: () {
                                  electCtrl.verifyMeter(
                                    meterNum: meterCtrl.text,
                                    type: electType[selectPaid],
                                    serviceId: select.electricCode,
                                  );
                                },
                              ),
                            ),
                            electCtrl.verified.value && correctMeter ? Container(
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
                            ): correctMeter
                                ? SizedBox(
                                    height: 25,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        loadCtrl.offLoading(() async {
                                          await electCtrl.verifyMeter(
                                            meterNum: meterCtrl.text,
                                            type: electType[selectPaid]
                                                .toLowerCase(),
                                            serviceId: select.electricCode,
                                          );

                                          // print(meterCtrl.text);
                                          // print(electType[selectPaid]);
                                          // print(select.electricCode);
                                        });
                                      },
                                      child: Text(
                                        'verify',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                        const Divider(
                          color: AppColors.lightGreen,
                          thickness: 2,
                        ),
                        electCtrl.verifyLoad.value
                            ? Row(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                    width: 8,
                                    child: CircularProgressIndicator(),
                                  ),
                                  const SizedBox(width: 8.0),
                                  AppText(
                                    text: 'verifying the meter number...',
                                    textColor: AppColors.primary,
                                  ),
                                ],
                              )
                            : electCtrl.verified.value
                            ? Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 8.0),
                                  AppText(
                                    text: electCtrl.verifyDet['Customer_Name'] ?? 'null',
                                    textColor: AppColors.primary,
                                  ),
                                ],
                              )
                            : Text(electCtrl.verifyErr.value,
                                style: TextStyle(color: AppColors.declined),
                                textAlign: TextAlign.start,
                              ),

                        ///Details after verification
                        electCtrl.verified.value && correctMeter
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
                                    rowTile(
                                      text: 'Min Purchase',
                                      child: AppText(text: '500'),
                                    ),
                                    rowTile(
                                      text: 'Account Type',
                                      child: AppText(
                                        text:
                                            electCtrl
                                                .verifyDet['Customer_Account_Type'] ??
                                            'null',
                                      ),
                                    ),
                                    rowTile(
                                      text: 'Address',
                                      child: AppText(
                                        text:
                                            viewModel.textToTims(
                                              electCtrl.verifyDet['Address'],
                                            ) ??
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runSpacing: 15,
                      spacing: 15,
                      runAlignment: WrapAlignment.start,
                      children: List.generate(
                        electCtrl.availableAmount.length,
                        (index) {
                          final meterPrice = electCtrl.availableAmount[index];
                          final price = double.parse(meterPrice.amount);
                          return ProductCard(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              !correctMeter? CustomSnackbar.showSnackbar(
                                message: 'Enter your meter number',
                              ): electCtrl.verified.value
                                  ? loadCtrl.offLoading(() async{
                                    await acc.getBalance();
                                      ConfirmBottomSheet().confirmBottomSheet(
                                        context,
                                        amount: price,
                                        numberCtrl: meterCtrl,
                                        productName: 'Electricity',
                                        list: [],
                                        balance: acc.accountBalance.value,
                                        imgPath: select.imgPath,
                                        action: (pin) async{
                                          await electCtrl.buyElectric(
                                            amount: meterPrice.amount,
                                            meterNum: meterCtrl.text,
                                            type: electType[selectPaid],
                                            transPin: pin,
                                            serviceId: select.electricCode,
                                          );
                                        },
                                        // plan: electType[selectPaid]
                                      );
                                    }): CustomSnackbar.showSnackbar(
                                message: 'Verify your meter number to continue',
                              );
                            },
                            height: 100,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: '₦',
                                    children: [
                                      TextSpan(
                                        text: meterPrice.amount.toString(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium,
                                      ),
                                    ],
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                AppText(
                                  text: 'Pay ${viewModel.formatCurrNoKobo(price)}',
                                  textSize: 12,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  PriceInputField(
                    onBack: (){},
                    amountCtrl: amountCtrl,
                    numberCtrl: meterCtrl,
                    lowestAmount: 500,
                    productName: 'Electricity',
                    balance: acc.accountBalance.value,
                    action: (pin)async {
                      print('This is the elect Price: ${amountCtrl.text}');
                      await electCtrl.buyElectric(amount: amountCtrl.text.trim(), meterNum: meterCtrl.text, type: electType[selectPaid], transPin: pin, serviceId: select.electricCode);
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  //For common Rows
  Row rowTile({required String text, required Widget child}) {
    return Row(
      children: [
        AppText(text: text),
        const Spacer(),
        child,
      ],
    );
  }

  //For selecting Electricity type
  Widget electTypeBox(String text, VoidCallback onTap, int index) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin: const EdgeInsets.all(5.0),
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: selectPaid == index
                  ? Border.all(color: AppColors.primary)
                  : Border.all(color: Colors.transparent),
              color: Theme.of(context).cardColor,
              // color: selectPaid == index ? AppColors.lightGreen : Colors.white,
            ),
            child: Center(
              child: AppText(text: text, textWeigh: FontWeight.bold),
            ),
          ),
          selectPaid == index
              ? Positioned(
                  left: 130,
                  bottom: 5,
                  child: Container(
                    margin: const EdgeInsets.only(right: 60),
                    alignment: Alignment.center,
                    height: 0,
                    width: 0,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(width: 25, color: Colors.green),
                        bottom: BorderSide(
                          color: Colors.transparent,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          selectPaid == index
              ? Icon(Icons.done, color: AppColors.bgColor, size: 22)
              : SizedBox(),
        ],
      ),
    );
  }
}
