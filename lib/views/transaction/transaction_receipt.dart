import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/utils/Helpers/generate_image_service.dart';
import 'package:fin_wise/utils/Helpers/pdf_generator.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionReceipt extends StatelessWidget {
  TransactionReceipt({super.key});

  final GlobalKey receiptKey = GlobalKey();
  final viewModel = HomeViewModel();

  TransactionModel receiptDet = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {
                  Get.back();
                  FocusScope.of(context).unfocus();
                },
                child: AppText(text: 'Done', textColor: AppColors.primary),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: RepaintBoundary(
                key: receiptKey,
                child: Container(
                  alignment: Alignment.center,
                  height: 600,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: AppColors.bgColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.subBlue,
                        offset: Offset(3, 4),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Image(
                        image: AssetImage('Assets/logos/Vector.png'),
                        height: 80,
                        width: 80,
                      ),

                      const HeadingText(
                        headingText: 'FinWise',
                        color: AppColors.darkGreen,
                      ),
                      const HeadingText(
                        headingText: 'Transaction Receipt',
                        color: AppColors.darkGreen,
                      ),
                     HeadingText(
                        headingText: receiptDet.apiStatus.label,
                        color: AppColors.darkGreen,
                      ),
                      const HeadingText(
                        headingText: 'Amount',
                        color: AppColors.darkGreen,
                      ),
                      AppText(
                        text: viewModel.formatCurrency(receiptDet.amount),
                        textWeigh: FontWeight.bold,
                        textColor: Colors.black,
                      ),

                      rowTile('Reference', receiptDet.referenceId),
                      dividerBuild(),
                      rowTile('Payment Type', receiptDet.modelableType),
                      dividerBuild(),
                      rowTile('Provider', receiptDet.modelableId),
                      // dividerBuild(),
                      receiptDet.category == Categories.airtime ||
                              receiptDet.category == Categories.data
                          ? rowTile('Beneficiary', receiptDet.phoneNo)
                          : SizedBox(),
                      receiptDet.category == Categories.education
                          ? rowTile('Token', receiptDet.token ?? 'null')
                          : SizedBox(),
                      receiptDet.category == Categories.education
                          ? rowTile('Pin', receiptDet.pin ?? 'null')
                          : SizedBox(),
                      receiptDet.category == Categories.cable
                          ? rowTile(
                              'Smart card Number',
                              receiptDet.meterNo ?? 'null',
                            )
                          : SizedBox(),
                      receiptDet.category == Categories.electricity
                          ? rowTile(
                              'Meter Number',
                              receiptDet.meterNo ?? 'null',
                            )
                          : SizedBox(),
                      dividerBuild(),
                      rowTile(
                        'Date',
                        viewModel.formatDate(receiptDet.purchaseAt),
                      ),
                      dividerBuild(),
                      const SizedBox(height: 10),
                      const AppText(text: 'Thank you for using our service!'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            receiptDet.apiStatus == TransactionStatus.failed
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      receiptContainer(
                        'Share as image',
                        () {
                          ImageGenerationService(
                            receiptKey,
                            receiptDet.productRef,
                          ).shareImage();
                        },
                        Icons.image,
                        context,
                      ),
                      receiptContainer(
                        'share as pdf',
                        () {
                          PdfGeneratorService().generatePdfAndShare(receiptDet);
                        },
                        Icons.picture_as_pdf_outlined,
                        context,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget receiptContainer(
    String title,
    VoidCallback onTap,
    IconData icon,
    BuildContext context,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            AppText(text: title),
          ],
        ),
      ),
    );
  }

  Divider dividerBuild() =>
      const Divider(color: AppColors.lightGreen, thickness: 2);

  Widget rowTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          AppText(
            text: title,
            textWeigh: FontWeight.bold,
            textColor: AppColors.darkGreen,
          ),
          const Spacer(),
          AppText(text: value, textColor: AppColors.darkGreen),
        ],
      ),
    );
  }
}
