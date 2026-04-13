
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/utils/widgets/price_form_field.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceInputField extends StatefulWidget {
  const PriceInputField({
    super.key,
    required this.amountCtrl,
    required this.numberCtrl,
    required this.productName,
    this.lowestAmount = 50,
    this.highestAmount = 50000000,
    this.errMessage = 'Enter recipient number',
  });

  final TextEditingController amountCtrl;
  final TextEditingController numberCtrl;
  final String productName;
  final double lowestAmount;
  final double highestAmount;
  final String errMessage;

  @override
  State<PriceInputField> createState() => _PriceInputFieldState();
}

class _PriceInputFieldState extends State<PriceInputField> {
  final loadCtrl = Get.find<LoaderController>();
  bool hasText = false;

  double amount = 0.00;

  double parseAmount(text){
    double amount;
    if(text.isNotEmpty){
      amount = double.parse(text);
      return amount;
    }
    return 0.00;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppText(text: '₦', textWeigh: FontWeight.bold),
              Expanded(
                child: PriceFormField(
                    numberCtrl: widget.amountCtrl,
                    onChanged: (value){
                      print(value);
                      setState(() {
                        hasText = (parseAmount(value) >= widget.lowestAmount) && (parseAmount(value) <= widget.highestAmount);
                      });
                    },
                    hint: Text('${(widget.lowestAmount.toInt()).toString()} - 5,000,000')
                  ),
                ),

              SizedBox(
                width: 80,
                height: 30,
                child:  ElevatedButton(
                  onPressed: () {
                    // if(am)

                    FocusScope.of(context).unfocus();
                    widget.amountCtrl.text = '${widget.amountCtrl.text}.00';
                    widget.numberCtrl.text.isNotEmpty
                        ?
                      loadCtrl.offLoading((){
                        print(widget.amountCtrl.text);
                        // ConfirmBottomSheet().confirmBottomSheet(
                        //   context,
                        //   amount: parseAmount(widget.amountCtrl.text.trim()),
                        //   numberCtrl: widget.numberCtrl,
                        //   productName: widget.productName,
                        // );
                        widget.numberCtrl.text.isNotEmpty? widget.amountCtrl.text ='': null;
                        amount = 0.00;
                    })
                        : CustomSnackbar.showSnackbar(title: 'Error', message: widget.errMessage);

                    setState(() {
                      hasText = false;
                    });
                    FocusScope.of(context).unfocus();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    hasText
                        ? AppColors.primary
                        : Colors.greenAccent.withOpacity(0.5),
                  ),
                  child: AppText(
                    text: 'Pay',
                    textColor: AppColors.bgColor,
                  ),
                ),
                ),
            ],
          ),
          const Divider(color: AppColors.lightGreen, endIndent: 80,)
        ],
      ),
    );
  }
}

