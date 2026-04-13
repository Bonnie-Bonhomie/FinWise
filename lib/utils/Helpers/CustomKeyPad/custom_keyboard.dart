import 'package:fin_wise/utils/Helpers/CustomKeyPad/keypad_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget{
  const CustomKeyboard({super.key, required this.controller});

  final KeyPadController controller;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: GridView.builder(
        itemCount: 12,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 15,
              childAspectRatio: 2,
          ), itemBuilder: (context, index){
        if(index == 9){
          return keypadKeys(text: 'C', onTap: ()=> controller.clearAll(), color: Colors.grey.withOpacity(0.2));}
        else if(index == 10){
         return  keypadKeys(text: '0', onTap: () {
           print(controller.input.value);
           controller.addValue('0', 4);
         });
        }
        else if(index == 11){
         return keypadKeys(text: '⌫', onTap: ()=> controller.deleteValue(), color: Colors.grey.withOpacity(0.2), textSize: 30);
        }
        return keypadKeys(text: index.toString(), onTap: () => controller.addValue(index.toString(), 4));
      }, ),
    );
  }

  Widget keypadKeys({ required String text, required VoidCallback onTap, Color? color, double? textSize}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? AppColors.bgColor,
            boxShadow: [
              BoxShadow(color: AppColors.lightGreen)
            ]
        ),
        child: Center(child: AppText(text: text, textSize: textSize ?? 20, textWeigh: FontWeight.bold,)),
      ),
    );
  }
}
