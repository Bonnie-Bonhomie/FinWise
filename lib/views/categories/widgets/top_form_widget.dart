import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/models/numbers_model.dart';
import 'package:fin_wise/utils/widgets/loading_skeleton.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/phone_number_formatter.dart';
import 'package:fin_wise/viewModel/top_form_view_model.dart';
import 'package:fin_wise/views/view_widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class TopFormWidget extends StatefulWidget {
  const TopFormWidget({
    super.key,
    required this.child,
    required this.numberCtrl,
    required this.networks,
    required this.beneficiaries,
    // required this.numSelect,
    required this.onTap,
  });

  final TextEditingController numberCtrl;
  final Widget child;
  final List<NetworksModel> networks;
  final List<NumbersModel> beneficiaries;

  // NumbersModel numSelect;
  final Function onTap;

  @override
  State<TopFormWidget> createState() => _TopFormWidgetState();
}

class _TopFormWidgetState extends State<TopFormWidget> {
  final paymentCtrl = Get.find<CategoryNavCtrl>();

  // final dataCTrl = Get.find()

  String? selectedNumber;
  final GlobalKey<FormFieldState> numKey = GlobalKey<FormFieldState>();

  bool correctNum = false;

  bool cleared = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Number Input section
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(40),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            // padding: const EdgeInsets.only(top: 10),
            children: [
              Row(
                children: [
                  Obx(
                        () =>
                        SizedBox(
                          height: 50,
                          width: 70,
                          child: widget.networks.isEmpty
                              ? SkeletonLoader.shimmerLines(
                            len: 1,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          )
                              : dropdownServiceProvider(onTap: widget.onTap),
                        ),
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
                      onChanged: (val) {
                        correctNum = val.length == 13;
                        bool chev = false;
                        if (correctNum == true) {
                          chev = TopViewModel.checkProvider(val);
                        }
                        // if(chev == true){
                        //   select = ServiceProvider.mtn;
                        // }
                        // print(correctNum);
                      },
                    ),
                  ),
                ],
                // )
              ),
              const Divider(color: AppColors.lightGreen),
              // SizedBox(height: 20,),
              Container(margin: EdgeInsets.only(top: 20), child: widget.child),
            ],
          ),
        ),
        // Numbers Dropdown Part
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .cardColor,
                  borderRadius: BorderRadiusGeometry.directional(
                    bottomStart: Radius.circular(30),
                    bottomEnd: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: (widget.beneficiaries.isEmpty) ? Center(
                          child: EmptyState(message: 'No Beneficiary for you')
                      ) : ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: widget.beneficiaries.length,
                        itemBuilder: (context, index) {
                          final item = widget.beneficiaries[index];
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              // setState(() {
                              //   widget.numberCtrl.text =
                              //       TopViewModel.formatted(
                              //         item.number.toString(),
                              //       );
                              //   widget.numSelect.provider = item.provider;
                              //   print(widget.numSelect.provider);
                              //   cleared = false;
                              // });
                              // FocusScope.of(context).unfocus();
                            },
                            child: Row(
                              children: [
                                AppText(
                                  text: TopViewModel.formatted(
                                    item.number.toString(),
                                  ),
                                ),
                                SizedBox(width: 10),
                                AppText(text: item.provider.name),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    paymentCtrl.deleteBene(index);
                                  },
                                  icon: Icon(Icons.cancel_outlined),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        paymentCtrl.deleteAllBene();
                        Get.back();
                      },
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

  DropdownButton dropdownServiceProvider({required Function onTap}) {
    return DropdownButton(
      value: paymentCtrl.select.value,
      underline: SizedBox(),
      borderRadius: BorderRadius.circular(20),
      alignment: Alignment.center,
      dropdownColor: Theme.of(context).cardColor,
      items: List.generate(widget.networks.length, (index) {
        final service = widget.networks[index];
        String img = service.imgPath;
        return DropdownMenuItem(
          value: index,
          onTap: () {
            setState(() {
              img = service.imgPath;
              // print(img);
            });
          },
          // child: AppText(text: service.label[0]),
          child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(shape: BoxShape.circle,
                  color: Colors.grey.shade400,
                  image: DecorationImage(image: NetworkImage(img), onError: (_, _)=> Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ), )),
              // child: Image.network(img.toString(),
              //     fit: BoxFit.cover,
              //     headers: const {'Access-Control-Allow-Origin': '*'},
              //
              // )
          ),
        );
      }),
      onChanged: (val) {
        paymentCtrl.select.value = val;
        onTap();
      },
    );
  }
}
