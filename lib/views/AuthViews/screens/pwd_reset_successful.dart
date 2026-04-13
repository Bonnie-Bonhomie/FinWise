
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';
import '../../../core/app_colors.dart';

class ResetSuccessful extends StatefulWidget {
  const ResetSuccessful ({super.key});

  @override
  State<ResetSuccessful> createState() => _ResetSuccessfulState();
}

class _ResetSuccessfulState extends State<ResetSuccessful>{

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), (){
      Get.offNamed(Routes.mainS);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SizedBox(
        width: double.infinity,
        // color: ColorTools.primary,
        child: Column(
          children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.bgColor, width: 10.0),
                      shape: BoxShape.circle,
                      color: AppColors.primary
                    ),
                  child: const Icon(Icons.done, color: AppColors.bgColor,),
                ),
            const SizedBox(
                width: 80,
                child: Text("Password Has Been Changed Successfully",))
          ],
        ),
      ),
    );
  }
}
