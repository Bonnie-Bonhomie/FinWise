import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/categories/service_export.dart';
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
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();
  final loading = Get.find<LoaderController>();
  late TabController _tabCtrl;

  final TextEditingController numberCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    acc.getBalance();
    super.initState();
    _tabCtrl = TabController(length: dataCtrl.sections.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabCtrl.dispose();
  }

  Future<void> onRefresh() async {
    await acc.getBalance();
    await dataCtrl.getNetworks();
    await dataCtrl.getDataPlans(paymentCtrl.select.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: RefreshIndicator(
          onRefresh: () async {
            await onRefresh();
          },
          child: PageContainer(
            topMargin: 20,
            bottomPadding: 10,
            topChild: CustomAppBar.header(
              title: 'Buy Data',
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: Obx(
              () => TopFormWidget(
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
      ),
    );
  }

  ///Data plan section list Widget
  Widget sectionDataList(List<DataPlan> dataPlan, String section) {
    // return Obx(() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: dataCtrl.dataLoading.value
          ? DataLoadingState()
          : dataPlan.isEmpty
          ? ServiceEmpty(
              emptyData: dataCtrl.planErr.value.isEmpty
                  ? '$section data plan is not available.'
                  : dataCtrl.planErr.value,
            )
          : DataCard(
              dataPlan: dataPlan,
              dataCtrl: dataCtrl,
              acc: acc,
              numberCtrl: numberCtrl,
              paymentCtrl: paymentCtrl,
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

class DataCard extends StatelessWidget {
  final List<DataPlan> dataPlan;
  final DataController dataCtrl;
  final CategoryNavCtrl paymentCtrl;
  final AccBalanceCtrl acc;
  final TextEditingController numberCtrl;

  DataCard({
    super.key,
    required this.dataPlan,
    required this.dataCtrl,
    required this.acc,
    required this.numberCtrl,
    required this.paymentCtrl,
  });

  final loader = Get.find<LoaderController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 15,
      alignment: WrapAlignment.start,
      spacing: 15,
      children: List.generate(dataPlan.length, (index) {
        final data = dataPlan[index];
        return InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            final imgPath = dataCtrl.dataNet[paymentCtrl.select.value].imgPath;
            // print(imgPath);
            double amount = double.parse(data.price);
            // print('${data.name} ${data.frequency.name} Plan');
            final networkId =
                dataCtrl.dataNet[paymentCtrl.select.value].serviceId;
            dataCtrl.dataNet.isEmpty
                ? CustomSnackbar.showSnackbar(
                    message: 'Unable to load available networks',
                  )
                : numberCtrl.text.isNotEmpty
                ? loader.offLoading(() {
                    ConfirmBottomSheet().confirmBottomSheet(
                      context,
                      amount: amount,
                      numberCtrl: numberCtrl,
                      productName: '${networkId.toUpperCase()} Data',
                      data: true,
                      balance: acc.accountBalance.value,
                      plan: '${data.name} ${data.frequency.name} Plan',
                      imgPath: imgPath,
                      action: (pin) async {
                        await dataCtrl.buyData(
                          dataId: data.id,
                          tranPin: pin,
                          phone: numberCtrl.text,
                        );
                      },
                    );
                  })
                : CustomSnackbar.showSnackbar(
                    message: 'Enter recipient number',
                  );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                AppText(text: data.frequency.name, textSize: 12.0),
                const SizedBox(height: 5.0),
                AppText(text: '₦${data.price.toString()}'),
                Container(
                  width: 60,
                  padding: const EdgeInsets.only(bottom: 4.0),
                  decoration: BoxDecoration(
                    color: AppColors.pending.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(child: Text(data.planType, style: TextStyle(fontSize: 11.0, color: AppColors.pending))),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class DataLoadingState extends StatelessWidget {
  const DataLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoader.shimmerLines(
      len: 3,
      child: Row(
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.all(5),
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
