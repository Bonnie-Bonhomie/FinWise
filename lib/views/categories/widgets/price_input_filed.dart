
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                child: TextFormField(
                    controller: widget.amountCtrl,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    onChanged: (value){
                      setState(() {
                        hasText = (parseAmount(value) >= widget.lowestAmount) && (parseAmount(value) <= widget.highestAmount);
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hint: Text('${(widget.lowestAmount.toInt()).toString()} - 5,000,000'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

              SizedBox(
                width: 80,
                height: 30,
                child:  ElevatedButton(
                  onPressed: () {
                    // if(am)
                    FocusScope.of(context).unfocus();
                    amount = parseAmount(widget.amountCtrl.text.trim());
                    widget.numberCtrl.text.isNotEmpty
                        ? ConfirmBottomSheet().confirmBottomSheet(
                      context,
                      amount: amount,
                      numberCtrl: widget.numberCtrl,
                      productName: widget.productName,
                    )
                        : Get.snackbar(
                      'Error',
                      widget.errMessage,
                      backgroundColor: AppColors.lightGreen,
                    );
                    widget.numberCtrl.text.isNotEmpty? widget.amountCtrl.text ='': null;
                    amount = 0.00;
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
