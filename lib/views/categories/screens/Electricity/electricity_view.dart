import 'package:fin_wise/controllers/categoryCtrl/electricity_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/utils/widgets/price_form_field.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';

import 'package:fin_wise/views/categories/widgets/price_input_filed.dart';
import 'package:fin_wise/views/categories/widgets/product_card.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricityView extends StatefulWidget {
  const ElectricityView({super.key});

  @override
  State<ElectricityView> createState() => _ElectricityViewState();
}

class _ElectricityViewState extends State<ElectricityView> {
  bool prepaid = true;
  int selectPaid = 0;
  List<int> prices = [1000, 2000, 3000, 4000, 5000, 10000];
  List<String> electType = ['Prepaid', 'Postpaid'];
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController meterCtrl = TextEditingController();

  final loadCtrl = Get.find<LoaderController>();
  final electCtrl = Get.find<ElectricityCtrl>();
  bool correctMeter = false;
  String error = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: PageContainer(
          topMargin: 20,
          bottomPadding: 20,
          topChild: CustomAppBar.header(
            title: 'Electricity',
            leftRight: 15,
            onPressed: () => Get.back(),
          ),
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Row(
                children: [
                  CircleAvatar(
                    // child: Image(image: NetworkImage(''), fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 5.0),
                  Obx((){
                    final select = electCtrl.selectedElect.value;

                    return AppText(text: select?.name ?? 'Ikeja Electricty');}),
                  const Spacer(),
                  IconButton(
                    onPressed: () async{
                      final selectElect = await Get.toNamed(Routes.availableElect);
                      electCtrl.updateElect(selectElect);
                      print(selectElect.name);
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
                margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lightGreen,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                  ),
                ),
                child: Column(
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
                            hint: const AppText(text: 'Enter Meter number'),
                            onChanged: (value) {
                              setState(() {
                                correctMeter = value.length == 13;
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(5.0),
                            color: AppColors.bgColor,
                          ),
                          child: Icon(
                            Icons.person_add_alt_1_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.lightGreen, thickness: 2,),
                    correctMeter
                        ? Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8.0),
                              AppText(
                                text: 'OMOLEME E E MRS',
                                textColor: AppColors.primary,
                              ),
                            ],
                          )
                        : SizedBox(),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.all(15),
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.bgColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rowTile(
                            text: 'Min Purchase',
                            child: AppText(text: '4.93'),
                          ),
                          rowTile(
                            text: 'Tariff Name',
                            child: AppText(text: 'C-Non MD'),
                          ),
                          rowTile(
                            text: 'Service Address',
                            child: AppText(text: '1 VI******'),
                          ),
                        ],
                      ),
                    ),
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
                  children: List.generate(prices.length, (index) {
                    final meterPrice = prices[index];

                    return ProductCard(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        // correctMeter
                        //     ? loadCtrl.offLoading(() {
                        //         ConfirmBottomSheet().confirmBottomSheet(
                        //           context,
                        //           amount: prices[index].toDouble(),
                        //           numberCtrl: meterCtrl,
                        //           productName: 'Electricity',
                        //         );
                        //       })
                        //     : CustomSnackbar.showSnackbar(
                        //         message: 'Enter your meter number',
                        //       );
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
                                  text: meterPrice.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          AppText(text: 'Pay ₦${meterPrice.toString()}'),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              PriceInputField(
                amountCtrl: amountCtrl,
                numberCtrl: meterCtrl,
                lowestAmount: 1000,
                productName: 'Electricity',
              ),
            ],
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
              color: selectPaid == index ? AppColors.lightGreen : Colors.white,
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
