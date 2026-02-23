import 'package:fin_wise/controllers/categoryCtrl/television_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';

import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TelevisionBillView extends StatelessWidget {
  TelevisionBillView({super.key});

  final ctrl = Get.put(TelevisionCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header('Cables & Tv', 15, () => Get.back()),
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
                    fillColor: AppColors.lightGreen,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    final tv = ctrl.availableTv[index];
                    return ListTile(
                      onTap: () {
                        Get.toNamed(Routes.tvSubscription, arguments: tv);
                      },
                      title: Text(tv.name, overflow: TextOverflow.ellipsis),
                      subtitle: Text(
                        tv.abbrev.toUpperCase(),
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
                  itemCount: ctrl.availableTv.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
