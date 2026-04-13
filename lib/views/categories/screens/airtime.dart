import 'package:fin_wise/controllers/categoryCtrl/airtime_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/data/models/numbers_model.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
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
  final ctrl = Get.find<AirtimeCtrl>();
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
    final loadCtrl = Get.find<LoaderController>();
    return Scaffold(
      body: LoaderWrapper(
        child: PageContainer(
          bottomPadding: 20,
          topMargin: 20,
          topChild: CustomAppBar.header(title: 'Buy Airtime', leftRight: 15,onPressed: () => Get.back()),
          child: TopFormWidget(
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
                              amountCtrl.text = '${topAmount.toString()}.00';

                              FocusScope.of(context).unfocus();
                              numberCtrl.text.isNotEmpty
                                  ?
                              loadCtrl.offLoading(()
                                  {
                                    setState(() {
                                      amount = topAmount.toDouble();

                                    });
                                    final imgPath = navCtrl.selectProvider.value.imgPath;
                                    ConfirmBottomSheet().confirmBottomSheet(
                                      list: ctrl.airtimeBenes,
                                    element: NumbersModel(provider: navCtrl.selectProvider.value, number: numberCtrl.text, amount: amount),
                                    context,
                                    amount: amount,
                                    numberCtrl: numberCtrl,
                                    productName: 'Airtime',
                                      imgPath: imgPath,
                                  );})
                                  : CustomSnackbar.showSnackbar( message: 'Enter recipient number');
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
        ),
    );
  }
}
