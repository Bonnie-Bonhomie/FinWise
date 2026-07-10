import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/utils/Helpers/generate_image_service.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositsReceipt extends StatelessWidget {
  DepositsReceipt({super.key});

  final GlobalKey depositKey = GlobalKey();
  final viewModel = HomeViewModel();
  final trans = Get.find<TransactionCtrl>();
  final acc = Get.find<AccBalanceCtrl>();
  final nav = Get.find<NavControl>();

  DepoModel receiptDet = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () async{
                  Get.until((route) {
                    return route.isFirst;
                  });
                  nav.selectInd.value = 0;
                  FocusScope.of(context).unfocus();
                  await trans.getTransactions(1);
                  await acc.getBalance();
                },
                child: AppText(text: 'Done', textColor: AppColors.primary),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: RepaintBoundary(
                key: depositKey,
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
                        image: AssetImage(PrefStoreKeys.appImage),
                        height: 70,
                        width: 70,
                      ),

                      // const HeadingText(
                      //   headingText: PrefStoreKeys.appName,
                      //   color: AppColors.darkGreen,
                      // ),
                      const HeadingText(
                        headingText: 'Deposit Receipt',
                        color: AppColors.darkGreen,
                      ),

                      // const HeadingText(
                      //   headingText: 'Amount',
                      //   color: AppColors.darkGreen,
                      // ),
                      AppText(
                        text: viewModel.formatCurrency(receiptDet.amount),
                        textWeigh: FontWeight.bold,
                        textColor: Colors.black,
                      ),

                      rowTile('Reference', receiptDet.tranReference),
                      // dividerBuild(),
                      rowTile('Payment Type', 'Fund Wallet'),
                      rowTile('Deposit Hash', receiptDet.hash),
                      rowTile('Deposit Hash', receiptDet.fee ?? '0'),
                      rowTile('Narration', receiptDet.narration),

                      rowTile(
                        'Date',
                        viewModel.formatDate(receiptDet.fundAt),
                      ),
                      const SizedBox(height: 6),
                      const AppText(text: 'Thank you for using our service!', textColor: AppColors.darkGreen),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // receiptDet.apiStatus != TransactionStatus.completed
            //     ? SizedBox()
            //     :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                receiptContainer(
                  'Share as image',
                      () {
                    ImageGenerationService(
                      depositKey,
                      receiptDet.tranReference,
                    ).shareImage();
                  },
                  Icons.image,
                  context,
                ),
                // receiptContainer(
                //   'share as pdf',
                //       () {
                //     PdfGeneratorService().generatePdfAndShare(receiptDet);
                //   },
                //   Icons.picture_as_pdf_outlined,
                //   context,
                // ),
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
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
             Icon(icon, color: AppColors.primary),
            const SizedBox(width: 3,),
            AppText(text: title, textSize: 14,),
          ],
        ),
      ),
    );
  }

  Divider dividerBuild() =>
      const Divider(color: AppColors.lightGreen, thickness: 2);

  Widget rowTile(String title, String value, ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: AppText(
                  text: title,
                  textWeigh: FontWeight.bold,
                  textColor: AppColors.darkGreen,
                ),
              ),
              // const SizedBox(width: 30,),
              SizedBox(
                  width: 190,
                  child: Text(value,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.darkGreen,

                      ), maxLines: 3))
            ],
          ),
        ),
        dividerBuild(),
      ],
    );
  }
}
