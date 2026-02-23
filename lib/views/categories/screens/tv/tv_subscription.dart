import 'package:fin_wise/controllers/categoryCtrl/television_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/tv_model.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';
import 'package:fin_wise/views/categories/widgets/price_input_filed.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TvSubscription extends StatefulWidget {
  const TvSubscription({super.key});

  @override
  State<TvSubscription> createState() => _TvSubscriptionState();
}

class _TvSubscriptionState extends State<TvSubscription>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController smartCardCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();

  //Selected Tv
  TvModel tvDetails = Get.arguments;
  bool correctNumber = false;

  final tvCtrl = Get.find<TelevisionCtrl>();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(tvDetails.abbrev);
    return Scaffold(
      body: PageContainer(
        topMargin: 10,
        bottomPadding: 10,
        topChild: CustomAppBar.header(tvDetails.abbrev, 15, () => Get.back()),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            ListTile(
              title: AppText(text: tvDetails.name),
              titleTextStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
              ),
              leading: CircleAvatar(),
            ),
            const Divider(color: AppColors.lightGreen),
            const SizedBox(height: 10),
            AppText(
              text: tvDetails.description,
              textColor: AppColors.primary,
            ),

            Container(
              padding: EdgeInsets.all(15),
              margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [AppColors.lightGreen, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
              child: Column(
                children: [
                  rowTile(
                    text: 'Smartcard Number Number',
                    child: InkWell(
                      onTap: () {},
                      child: const Row(
                        children: [
                          AppText(text: 'Beneficiaries'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: smartCardCtrl,
                    decoration: InputDecoration(
                      hint: const AppText(
                        text: 'Enter Your Smartcard Number',
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        correctNumber = value.length == 11;
                      });
                    },
                  ),
                  const Divider(color: AppColors.lightGreen,)
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.primary, width: 4),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              labelStyle: TextStyle(fontSize: 20),
              tabs: [
                const Tab(text: 'Hot Offers'),
                const Tab(text: 'Premium'),
              ],
            ),
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: ListView(
                      padding: const EdgeInsets.only(top: 8.0),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildProductColumn(
                              list: tvCtrl.leftService,
                              isLeft: true,
                            ),
                            buildProductColumn(list: tvCtrl.rightService),
                          ],
                        ),
                      ],
                    ),
                  ),
                  premiumBuild(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Wrap premiumBuild() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 15,
      runSpacing: 5.0,
      children: List.generate(tvCtrl.premiumService.length, (index) {
        final serv = tvCtrl.premiumService[index];
        return serviceBox(
          title: serv.title,
          amount: '₦${serv.amount}',
          duration: '${serv.duration} Month',
          onTap: () {
            final amount = double.parse(serv.amount);
            smartCardCtrl.text.isNotEmpty
                ? ConfirmBottomSheet().confirmBottomSheet(
                    context,
                    amount: amount,
                    numberCtrl: smartCardCtrl,
                    productName: 'cable',
                  )
                : Get.snackbar(
                    '',
                    'Enter your smartcard number',
                    backgroundColor: AppColors.lightGreen,
                  );
          },
        );
      }),
    );
  }

  Column buildProductColumn({
    required List<TvServiceModel> list,
    bool isLeft = false,
  }) {
    return Column(
      children: List.generate(list.length, (index) {
        final serv = list[index];
        final amount = double.parse(serv.amount);

        if (index == 0 && isLeft) {
          return serviceBox(
            title: '${tvDetails.abbrev} Renewal',
            amount: 'Enter amount',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PriceInputField(
                          amountCtrl: amountCtrl,
                          numberCtrl: smartCardCtrl,
                          productName: '${tvDetails.abbrev} subscription',
                          lowestAmount: 2000,
                          errMessage: 'Enter your smartcard number',
                        ),
                        CancelBtn(onPressed: () => Get.back()),
                        const SizedBox(height: 15,),

                      ],
                    ),
                  );

                },
              );
              amountCtrl.text = '';
            },
          );
        }
        return serviceBox(
          title: '${tvDetails.abbrev} ${serv.title}',
          amount: '₦${serv.amount}',
          duration: '${serv.duration} Month',
          onTap: () {
            smartCardCtrl.text.isNotEmpty
                ? ConfirmBottomSheet().confirmBottomSheet(
                    context,
                    amount: amount,
                    numberCtrl: smartCardCtrl,
                    productName: 'cable',
                  )
                : Get.snackbar(
                    '',
                    'Enter your smartcard number',
                    backgroundColor: AppColors.lightGreen,
                  );
          },
        );
      }),
    );
  }

  Widget serviceBox({
    required String title,
    required String amount,
    required VoidCallback onTap,
    String duration = '',
    IconData? icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.lightGreen,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: title, textSize: 16, textWeigh: FontWeight.bold),
            duration == ''
                ? SizedBox.shrink()
                : Container(
                    padding: const EdgeInsets.all(3.4),
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.shade100.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: AppText(
                      text: duration,
                      textColor: Colors.orange,
                      textWeigh: FontWeight.bold,
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  AppText(text: amount),
                  const Spacer(),
                  Icon(icon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //For common Rows
  Row rowTile({required String text, required Widget child}) {
    return Row(
      children: [
        AppText(text: text),
        const Spacer(),
        child,
      ],
    );
  }
}
