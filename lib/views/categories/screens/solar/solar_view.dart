import 'package:data_boot/controllers/categoryCtrl/solar_ctrl.dart';
import 'package:data_boot/utils/utils_export.dart';
import 'package:data_boot/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:data_boot/views/categories/screens/MarketPlace/market_skeleton.dart';
import 'package:data_boot/views/view_widgets/shared_widget.dart';
import 'package:data_boot/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SolarView extends StatefulWidget {
  const SolarView({super.key});

  @override
  State<SolarView> createState() => _SolarViewState();
}

class _SolarViewState extends State<SolarView> {
  final ctrl = Get.find<SolarCtrl>();

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async {
      await ctrl.loadFresh();
    });
    super.initState();
  }

  Future<void> onRefresh() async {
    await ctrl.loadFresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: PageContainer(
            bottomPadding: 20,
            topMargin: 20,
            topChild: CustomAppBar.header(
              title: 'Solar Panels',
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      if (ctrl.loadingProd.value) {
                        return MarketSkeleton();
                      }
                      if (ctrl.solarProduct.isEmpty) {
                        return Column(
                          children: [
                            Icon(Icons.not_interested_sharp, size: 30,),
                            Text(ctrl.productErr.value),
                          ],
                        );
                      }
                      return ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: ctrl.solarProduct.length,
                          itemBuilder: (context, index) {
                            final item = ctrl.solarProduct[index];
                            return MarketProdCard(item: item);
                          });
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryBox(BuildContext context, cat, VoidCallback onSelect) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        height: 20,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        ),
        child: Text(cat),
      ),
    );
  }
}
