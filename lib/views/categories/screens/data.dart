import 'package:fin_wise/controllers/categoryCtrl/category_nav_ctrl.dart';
import 'package:fin_wise/controllers/categoryCtrl/data_controller.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/data_model.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';
import 'package:fin_wise/views/categories/widgets/top_form_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView>
    with SingleTickerProviderStateMixin {

  final paymentCtrl = Get.find<CategoryNavCtrl>();
  final dataCtrl = Get.find<DataController>();
  final loading = Get.find<LoaderController>();
  late TabController _tabCtrl;

  final TextEditingController numberCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabCtrl = TabController(length: dataCtrl.sections.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LoaderWrapper(
        child: PageContainer(
          topMargin: 20,
          bottomPadding: 10,
          topChild: CustomAppBar.header(title: 'Buy Data', leftRight: 15, onPressed: () => Get.back()),
          child: TopFormWidget(
            numberCtrl: numberCtrl,
            child: Column(
              children: [
                Row(
                  children: [
                    AppText(text: 'Data Plans', textWeigh: FontWeight.bold),
                    Spacer(),
                    Icon(Icons.grid_view_rounded, color: AppColors.primary),
                    // Icon(Icons.grid_4x4),
                  ],
                ),

                TabBar(
                  labelStyle: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  // isScrollable: true,
                  // physics: ScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  indicatorColor: AppColors.primary,
                  dividerColor: AppColors.lightGreen,
                  controller: _tabCtrl,
                  tabs: List.generate(dataCtrl.sections.length, ((index) {
                    final tab = dataCtrl.sections[index];
                    return Tab(text: tab);
                  })),
                ),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: _tabCtrl,
                    children: [
                      sectionDataList(dataCtrl.hotUp, 'Weekly'),
                      sectionDataList(dataCtrl.daily, 'Daily'),
                      sectionDataList(dataCtrl.weekly, 'Weekly'),
                      sectionDataList(dataCtrl.weekly, 'Monthly'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionDataList(List<DataPlan> dataPlan, String section) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Wrap(
        runSpacing: 15,
        alignment: WrapAlignment.start,
        spacing: 15,
        children: List.generate(dataPlan.length, (index) {
          final data = dataPlan[index];
          return InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              final imgPath= paymentCtrl.selectProvider.value.imgPath;
              // numberCtrl.text.isNotEmpty
              //     ? loading.offLoading((){
              //   ConfirmBottomSheet().confirmBottomSheet(
              //       context,
              //       amount: data.price,
              //       numberCtrl: numberCtrl,
              //       productName: 'Mobile Data',
              //       data: true,
              //       plan: '${data.name} ${data.type} $section Plan',
              //       imgPath: imgPath,
              //   );
              // })
              //     : CustomSnackbar.showSnackbar(message: 'Enter recipient number');
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 120,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.lightGreen,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      text: data.name,
                      children: [
                        TextSpan(
                          text: data.type,
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  AppText(text: data.days),
                  const SizedBox(height: 5.0),
                  AppText(text: '₦${data.price.toString()}'),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
