import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controller_exports.dart';
import '../../../../data/models/model_export.dart';
import '../../../view_export.dart';

class BuyPinView extends StatefulWidget {
  const BuyPinView({super.key});

  @override
  State<BuyPinView> createState() => _BuyPinViewState();
}

class _BuyPinViewState extends State<BuyPinView> {
  final eduCtrl = Get.find<EducationController>();
  final acc = Get.find<AccBalanceCtrl>();
  final loader = Get.find<LoaderController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final serviceKey = GlobalKey<FormFieldState>();
  final numberKey = GlobalKey<FormFieldState>();
  final profileKey = GlobalKey<FormFieldState>();
  final TextEditingController serviceCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController profileCtrl = TextEditingController();
  final ExamCardModel selectedSchool = Get.arguments ?? 'No Title';
  final HomeViewModel viewModel = HomeViewModel();
  int length = 10;
  bool correctNumber = false;
  String jamb = 'jamb';

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async {
      await acc.getBalance();
    });
    super.initState();
  }

  Future<void> onRefresh() async {
    await acc.getBalance();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedSchool.id);
    serviceCtrl.text = selectedSchool.name;
    amountCtrl.text = selectedSchool.price.toString();
    return Scaffold(
      body: LoaderWrapper(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: PageContainer(
            bottomPadding: 20,
            topMargin: 20,
            topChild: CustomAppBar.header(
              title: selectedSchool.variationCode.toUpperCase(),
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                labelText('Service type'),
                FormWidget(
                  fieldKey: serviceKey,
                  validator: (val) {
                    return null;
                  },
                  readOnly: true,
                  valController: serviceCtrl,
                ),

                selectedSchool.serviceName == jamb
                    ? Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              labelText('Profile code'),
                              Row(
                                children: [
                                  Expanded(
                                    child: PriceFormField(
                                      numberCtrl: profileCtrl,
                                      hint: AppText(
                                        text: 'Enter your profile code',
                                      ),
                                      length: length,
                                      key: profileKey,
                                      onChanged: (value) {
                                        setState(() {
                                          correctNumber = value.length == length;
                                        });
                                      },
                                    ),
                                  ),
                                  eduCtrl.verified.value
                                      ? Icon(
                                          Icons.done_outline_outlined,
                                          color: AppColors.primary,
                                        )
                                      : correctNumber
                                      ? SizedBox(
                                          height: 25,
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              loader.offLoading(() async {
                                                await eduCtrl.verifyCode(
                                                  profileCode: profileCtrl.text,
                                                  type: selectedSchool
                                                      .variationCode,
                                                  examId:
                                                      selectedSchool.serviceName,
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
                              const SizedBox(height: 5.0),
                              eduCtrl.verified.value
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_sharp,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(width: 5.0),
                                        AppText(
                                          text:
                                              eduCtrl
                                                  .verifyDet['Customer_Name'] ??
                                              'Error',
                                          textColor: AppColors.primary,
                                          textSize: 18,
                                        ),
                                      ],
                                    )
                                  : eduCtrl.verifyLoad.value
                                  ? Row(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                          width: 8,
                                          child: CircularProgressIndicator(),
                                        ),
                                        const SizedBox(width: 8.0),
                                        AppText(
                                          text:
                                              'verifying the profile code...',
                                          textColor: AppColors.primary,
                                        ),
                                      ],
                                    )
                                  : AppText(
                                      text: eduCtrl.verifyError.value,
                                      textColor: AppColors.declined,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                    ),
                            ],
                          ),
                        );
                      })
                    : SizedBox.shrink(),

                const SizedBox(height: 30),
                labelText('Amount'),
                Container(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    children: [
                      AppText(text: '₦'),
                      Expanded(
                        child: PriceFormField(
                          numberCtrl: amountCtrl,
                          hint: AppText(text: ''),
                          color: AppColors.lightGreen,
                          readOnly: true,
                        ),
                      ),
                    ],
                  ),
                ),
                labelText('Phone number'),
                PhoneNumberFormField(
                  numberCtrl: numberCtrl,
                  numberKey: numberKey,
                  validator: (val) => Validator.validateNumber(val!),
                ),
                SizedBox(height: 30),
                // labelText('Network Operator'),
                // dropdownServiceProvider(eduCtrl.selectedProvider.value),
                SizedBox(height: 30),
                AppBtn(
                  onPressed: () {
                    final amount = double.tryParse(amountCtrl.text);
                    selectedSchool.serviceName == jamb &&
                            !eduCtrl.verified.value
                        ? CustomSnackbar.warningSnack('Verify your profile code to continue',)
                        : numberCtrl.text.isNotEmpty
                        ? loader.offLoading(() async {
                            await acc.getBalance();
                            ConfirmBottomSheet().confirmBottomSheet(
                              balance: acc.accountBalance.value,
                              context,
                              amount: amount!,
                              numberCtrl: numberCtrl,
                              productName: selectedSchool.variationCode,
                              list: [],
                              action: (pin) async {
                                await eduCtrl.buyEduCard(
                                  transPin: pin,
                                  phoneNumber: numberCtrl.text,
                                  examId: selectedSchool.id,
                                );
                              },
                            );
                          })
                        : CustomSnackbar.warningSnack(
                            'Enter your registered number',
                          );
                  },
                  label: 'Proceed to Payment',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget labelText(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: AppText(
      text: text,
      textWeigh: FontWeight.bold,
      textColor: AppColors.darkGreen,
    ),
  );
}

//
// DropdownButtonFormField<String> dropdownServiceProvider(String value) {
//   return DropdownButtonFormField(
//     value: value,
//     items: List.generate(ServiceProvider.values.length, (index) {
//       final service = ServiceProvider.values[index];
//       return DropdownMenuItem(
//         value: service.label,
//         child: AppText(text: service.label.toUpperCase()),
//       );
//     }),
//     onChanged: (val) {
//       value = val!;
//     },
//   );
// }
