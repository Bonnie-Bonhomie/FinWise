import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/phone_number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TopFormWidget extends StatefulWidget {
  const TopFormWidget({
    super.key,
    required this.child,
    required this.selected,
    required this.numberCtrl,
  });

  final TextEditingController numberCtrl;
  final String selected;
  final Widget child;

  @override
  State<TopFormWidget> createState() => _TopFormWidgetState();
}

class _TopFormWidgetState extends State<TopFormWidget> {
  final paymentCtrl = Get.find<CategoryNavCtrl>();

  String formatted(text) {
    final formated =
        "0${text.substring(0, 3)} "
        "${text.substring(3, 7)} "
        "${text.substring(7)}";

    return formated;
  }

  String? selectedNumber;
  final GlobalKey<FormFieldState> numKey = GlobalKey<FormFieldState>();
  final List<String> images = [
    'images/onboard-1.png',
    'images/onboard-2.png',
    'logos/Vector.png',
  ];

  bool cleared = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Number Input section
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(15),
          child: ListView(
            padding: const EdgeInsets.only(top: 10),
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: dropdownServiceProvider(widget.selected),
                  ),

                  Expanded(
                    child: TextFormField(
                      controller: widget.numberCtrl,
                      key: numKey,
                      autofocus: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        PhoneNumberFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '080X XXX XXXX',
                        fillColor: AppColors.lightGreen,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              cleared = !cleared;
                            });
                          },
                          icon: cleared
                              ? Icon(Icons.arrow_drop_down_sharp)
                              : Icon(Icons.cancel_outlined),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.lightGreen),
              // SizedBox(height: 20,),
              Container(margin: EdgeInsets.only(top: 20), child: widget.child),
            ],
          ),
        ),
        //Numbers Dropdown Part
        if (cleared)
          Positioned(
            top: 90,
            child: Material(
              // shadowColor: Colors.black54,
              color: Colors.black12,
              borderRadius: BorderRadiusGeometry.directional(
                bottomStart: Radius.circular(30),
                bottomEnd: Radius.circular(30),
              ),
              surfaceTintColor: Colors.black54,
              elevation: 150,
              child: Container(
                height: 250,
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadiusGeometry.directional(
                    bottomStart: Radius.circular(30),
                    bottomEnd: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final len = paymentCtrl.allNumbers.length;
                        return ListView.builder(
                          padding: const EdgeInsets.all(15),
                          itemCount: len,
                          itemBuilder: (context, index) {
                            final item = paymentCtrl.allNumbers[index];
                            return InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  widget.numberCtrl.text = formatted(
                                    item.number.toString(),
                                  );
                                  cleared = false;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Row(
                                children: [
                                  AppText(
                                    text: formatted(item.number.toString()),
                                  ),
                                  SizedBox(width: 10),
                                  AppText(text: item.provider.name),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      paymentCtrl.deleteNumber(index);
                                    },
                                    icon: Icon(Icons.cancel_outlined),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        iconColor: AppColors.primary,
                        backgroundColor: AppColors.bgColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_forever_outlined),
                          AppText(
                            text: 'Delete All',
                            textColor: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  DropdownButton<String> dropdownServiceProvider(String value) {
    return DropdownButton(
      value: value,
      underline: SizedBox(),
      items: List.generate(ServiceProvider.values.length, (index) {
        final service = ServiceProvider.values[index];

        return DropdownMenuItem(
          value: service.label,
          child: CircleAvatar(
            child: Image(
              image: AssetImage('Assets/productLogo/${service.imgPath}'), //Edit the image part
              height: 80,
              width: 80,
            ),
          ),
        );
      }),
      onChanged: (val) {
        value = val!;
      },
    );
  }
}
