import 'package:fin_wise/controllers/categoryCtrl/market_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/data/models/product_model.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/categories/screens/MarketPlace/market_skeleton.dart';
import 'package:fin_wise/views/categories/screens/MarketPlace/product_details.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ctrl = Get.find<MarketCtrl>();

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
              title: 'Market Place',
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // Stack(
                  //   children: [
                  //     SizedBox(
                  //       height: 30,
                  //       child: ListView.builder(
                  //         padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 1.5),
                  //         scrollDirection: Axis.horizontal,
                  //         itemCount: ctrl.categories.length,
                  //         itemBuilder: (context, index) {
                  //           final cat = ctrl.categories[index];
                  //           return categoryBox(context, cat, (){});
                  //         },
                  //       ),
                  //     ),
                  //     Container(
                  //       height: 30,
                  //       // width: 300,
                  //       alignment: Alignment.center,
                  //       padding: const EdgeInsets.symmetric(
                  //         vertical: 3.0,
                  //         horizontal: 20,
                  //       ),
                  //       margin: const EdgeInsets.only(left: 10, right: 10),
                  //       decoration: BoxDecoration(
                  //         gradient: RadialGradient(
                  //           colors: [
                  //             Colors.transparent,
                  //             Colors.yellow,
                  //           ],
                  //           radius: 70,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Expanded(
                    child: Obx(() {
                      if (ctrl.loadingProd.value) {
                        return MarketSkeleton();
                      }
                      if (ctrl.fishProduct.isEmpty) {
                        return Column(
                          children: [
                            Icon(Icons.not_interested_sharp, size: 40,),
                            Text(ctrl.productErr.value),
                          ],
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: ctrl.fishProduct.length,
                        itemBuilder: (context, index) {
                          final item = ctrl.fishProduct[index];
                          return AnimatedCard(
                              index: index,
                              child: MarketProdCard(item: item));
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
