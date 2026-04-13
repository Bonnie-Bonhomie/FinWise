
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_colors.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage ({super.key});

  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage>{

  @override
  void initState() {
    super.initState();


    Future.delayed(Duration(seconds: 2), (){
      Get.offAllNamed(Routes.mainS);
    });
    // This make the init wait till the page is stacked before pop
    //
    //This is use when popping nestedPage using nitState
    //
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   Future.delayed(Duration(seconds: 3), (){
    //     Get.find<ProfileMainControl>().back();
    //   });
    // });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final args = Get.arguments;
    print(args);
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        width: double.infinity,
        // color: ColorTools.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.bgColor, width: 8.0),
                  shape: BoxShape.circle,
                  color: AppColors.primary
              ),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: const Icon(Icons.scatter_plot_rounded, color: AppColors.bgColor,)),
            ),
            SizedBox(
                width: 200,
                child: AppText(text: args ?? 'Successfully', textColor: AppColors.bgColor, textAlign: TextAlign.center, textSize: 20, textWeigh: FontWeight.bold,))
          ],
        ),
      ),
    );
  }
}
