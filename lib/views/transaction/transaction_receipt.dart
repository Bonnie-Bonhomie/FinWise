import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/Helpers/generate_image_service.dart';
import 'package:fin_wise/utils/Helpers/pdf_generator.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionReceipt extends StatelessWidget {
  TransactionReceipt({super.key});

  final GlobalKey receiptKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(onPressed: (){
                Get.back();
                FocusScope.of(context).unfocus();
              }, child: AppText(text: 'Done', textColor: AppColors.primary,)),
            ),
            Center(
              child: RepaintBoundary(
                key: receiptKey,
                child: Container(
                  alignment: Alignment.center,
                  height: 600,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: AppColors.subBlue, offset: Offset(3, 4), blurRadius: 2)
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15,),
                      Image(image: AssetImage('Assets/logos/Vector.png'), height: 80, width: 80,),

                      const HeadingText(headingText: 'FinWise'),
                      const HeadingText(headingText: 'Transaction Receipt'),
                      const HeadingText(headingText: 'Amount'),
                      AppText(text: '200.00', textWeigh: FontWeight.bold,),

                      rowTile('Reference', 'ghNNJHIOLkjOIP100203090i98'),
                      dividerBuild(),
                      rowTile('Payment Type', 'Airtime Recharge'),
                      dividerBuild(),
                      rowTile('Provider', 'Airtel'),
                      dividerBuild(),
                      rowTile('Narration', 'Airtime purchase for 09076892973'),
                      dividerBuild(),
                      rowTile('Date', '7th Feb, 2026'),
                      dividerBuild(),
                      const SizedBox(height: 10,),
                      const AppText(text: 'Thank you for using our service!')
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                receiptContainer('Share as image', (){
                  ImageGenerationService(receiptKey).shareImage();
                }, Icons.image), receiptContainer('share as pdf', (){
                  PdfGeneratorService().generatePdfAndShare();
                }, Icons.picture_as_pdf_outlined)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget receiptContainer(String title, VoidCallback onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
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
      const Divider(color: AppColors.lightGreen, thickness: 2,);

  Widget rowTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 5,),
      child: Row(
        children: [
          AppText(text: title, textWeigh: FontWeight.bold),
          const Spacer(),
          AppText(text: value),
        ],
      ),
    );
  }
}
