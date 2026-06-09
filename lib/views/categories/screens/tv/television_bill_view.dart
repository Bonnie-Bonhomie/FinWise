import 'package:fin_wise/controllers/categoryCtrl/television_ctrl.dart';
import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/core/Routes/routes.dart';

import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/views/view_widgets/empty_state.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TelevisionBillView extends StatelessWidget {
  TelevisionBillView({super.key});

  final ctrl = Get.find<TelevisionCtrl>();

  Future<void> onRefresh() async {
    Future.delayed(
      Duration(seconds: 1),
      () async => await ctrl.getCableDiscos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: PageContainer(
          topMargin: 20,
          topChild: CustomAppBar.header(
            title: 'Cables & Tv',
            leftRight: 15,
            onPressed: () => Get.back()
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.grey.shade300,
                      ),
                      // fillColor: AppColors.lightGreen,
                      // filled: true,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(20.0),
                      //   borderSide: BorderSide.none,
                      // ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Obx(() {
                    if (ctrl.loadDisco.value) {
                      return Center(child: SkeletonLoader.shimmerLines(len: 4));
                    } else if (ctrl.availableCable.isEmpty) {
                      return EmptyState(message: ctrl.discoErr.value);
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 15),
                      itemBuilder: (context, index) {
                        final tv = ctrl.availableCable[index];
                        return ListTile(
                          onTap: () {
                            ctrl.verified.value = false;
                            Get.toNamed(Routes.tvSubscription, arguments: tv);
                          },
                          title: Text(tv.name, overflow: TextOverflow.ellipsis),
                          subtitle: Text(
                            tv.serviceId.toUpperCase(),
                            style: TextStyle(color: AppColors.primary),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.subBlue,
                            child: AppText(
                              text: tv.name[0],
                              textColor: AppColors.bgColor,
                              textSize: 25,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) =>
                          const Divider(color: AppColors.lightGreen),
                      itemCount: ctrl.availableCable.length,
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
