import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/utils/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
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
          topChild: CustomAppBar.header(
            title: 'Buy Data',
            leftRight: 15,
            onPressed: () => Get.back(),
          ),
          child: Obx(() => TopFormWidget(
              networks: dataCtrl.dataNet,
              onTap: () {
                paymentCtrl.select.value = paymentCtrl.select.value;
                dataCtrl.getDataPlans(paymentCtrl.select.value);
                print('Data page number: ${paymentCtrl.select.value}');
              },
              // select: NetworksModel(name: '', id: 1, imgPath: '', status: '', networkCode: 'networkCode', serviceId: 'serviceId'),
              beneficiaries: [],
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
                        // Text('data'),
                        sectionDataList(dataCtrl.hotUp, 'HotUp'),
                        sectionDataList(dataCtrl.dailyPlan, 'Daily'),
                        sectionDataList(dataCtrl.weeklyPlan, 'Weekly'),
                        sectionDataList(dataCtrl.monthlyPlan, 'Monthly'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Data plan section list Widget
  Widget sectionDataList(List<DataPlan> dataPlan, String section) {
    // return Obx(() {
      return
        Padding(
        padding: const EdgeInsets.only(top: 15),
        child: dataCtrl.dataLoading.value
            ? SkeletonLoader.shimmerLines(
                len: 3,
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.all(3),
                      color: Colors.grey.shade300,
                      height: 120,
                      width: 80,
                    ),
                  ),
                ),
              )
            : dataPlan.isEmpty
            ? ServiceEmpty(
                emptyData: dataCtrl.planErr.value.isEmpty
                    ? '$section data plan is not available.'
                    : dataCtrl.planErr.value,
              )
            : Wrap(
                runSpacing: 15,
                alignment: WrapAlignment.start,
                spacing: 15,
                children: List.generate(dataPlan.length, (index) {
                  final data = dataPlan[index];
                  return InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      final imgPath = dataCtrl
                          .dataNet[paymentCtrl.select.value - 1]
                          .imgPath;
                      print(imgPath);
                      double amount = double.parse(data.price);
                      print('${data.name} ${data.frequency.name} Plan');
                      numberCtrl.text.isNotEmpty
                          ? loading.offLoading(() {
                              ConfirmBottomSheet().confirmBottomSheet(
                                context,
                                amount: amount,
                                numberCtrl: numberCtrl,
                                productName: 'Mobile Data',
                                data: true,
                                plan:
                                    '${data.name} ${data.frequency.name} Plan',
                                imgPath: imgPath,
                                action: (){}
                              );
                            })
                          : CustomSnackbar.showSnackbar(
                              message: 'Enter recipient number',
                            );
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
                          Text(
                            data.name,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          AppText(text: data.frequency.name, textSize: 12.0),
                          const SizedBox(height: 5.0),
                          AppText(text: '₦${data.price.toString()}'),
                        ],
                      ),
                    ),
                  );
                }),
              ),
      );
    // });
  }
}

class ServiceEmpty extends StatelessWidget {
  final String emptyData;

  const ServiceEmpty({super.key, required this.emptyData});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Icons.insights_outlined), Text(emptyData)],
      ),
    );
  }
}
