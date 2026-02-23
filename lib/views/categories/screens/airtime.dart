import 'package:fin_wise/controllers/categoryCtrl/airtime_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';
import 'package:fin_wise/views/categories/widgets/price_input_filed.dart';
import 'package:fin_wise/views/categories/widgets/product_card.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/categories/widgets/top_form_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AirtimeView extends StatefulWidget {
  const AirtimeView({super.key});

  @override
  State<AirtimeView> createState() => _AirtimeViewState();
}

class _AirtimeViewState extends State<AirtimeView> {
  final ctrl = Get.put(AirtimeCtrl());
  final navCtrl = Get.find<CategoryNavCtrl>();

  final GlobalKey<FormFieldState> numKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> amountKey = GlobalKey<FormFieldState>();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  List<int> topUp = [50, 100, 200, 500, 1000, 2000];
  bool isOpen = false;
  double amount = 0.00;
  //To convert the Price to double

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        bottomPadding: 20,
        topMargin: 20,
        topChild: CustomAppBar.header('Buy Airtime', 15, () => Get.back()),
        child: TopFormWidget(
          selected: navCtrl.selected.value,
          numberCtrl: numberCtrl,
          child: Column(
            children: [
              Container(
                // margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.bgColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightGreen,
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
                          setState(() {
                            amount = topAmount.toDouble();
                          });
                          numberCtrl.text.isNotEmpty
                              ? ConfirmBottomSheet().confirmBottomSheet(
                                  context,
                                  amount: amount,
                                  numberCtrl: numberCtrl,
                                  productName: 'Airtime',
                                )
                              : Get.snackbar(
                                  'Error',
                                  'Enter recipient number',
                                  backgroundColor: AppColors.lightGreen,
                                );
                          amount = 0.00;
                        },
                        child: AppText(text: '₦${topAmount.toString()}'),
                      );
                    }),
                  ),
                ),
              ),
              PriceInputField(amountCtrl: amountCtrl, numberCtrl: numberCtrl, productName: 'Airtime',),
            ],
          ),
        ),
      ),
    );
  }
}
