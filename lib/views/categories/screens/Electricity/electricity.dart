import 'package:fin_wise/controllers/categoryCtrl/electricity_ctrl.dart';

import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/utils_export.dart';
import 'package:fin_wise/views/view_widgets/empty_state.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailableElect extends StatelessWidget {
  AvailableElect({super.key});
  final ctrl = Get.find<ElectricityCtrl>();

  @override
  Widget build(BuildContext context) {

    print(ctrl.availableAmount);
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          title: 'Electricity',
          leftRight: 15,
          onPressed: () => Get.back(result: ctrl.electDiscos[0]),
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
              Expanded(
                child: BuildElectDiscos(ctrl: ctrl)
                    // : SkeletonLoader.shimmerLines(len: 7),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class BuildElectDiscos extends StatelessWidget {
  const BuildElectDiscos({super.key, required this.ctrl});

  final ElectricityCtrl ctrl;

  @override
  Widget build(BuildContext context) {
    return Obx((){
        return ListView.separated(
          padding: const EdgeInsets.only(top: 15),
          itemBuilder: (context, index) {
            final elect = ctrl.electDiscos[index];
            if(ctrl.electDiscos.isEmpty){
              return EmptyState(message: ctrl.discoErr.value);
            }
            return ListTile(
              onTap: () {
                Get.back(result: ctrl.electDiscos[index]);
                print(ctrl.electDiscos[index].name);
              },
              title: Text(elect.name, overflow: TextOverflow.ellipsis),
              subtitle: Text(
                elect.name.split(' ').last.toUpperCase(),
                style: TextStyle(color: AppColors.primary),
              ),
              leading: CircleAvatar(
                child: Image.network(
                  elect.imgPath,
                  errorBuilder: (context, _, __) => CircleAvatar(
                    backgroundColor: AppColors.subBlue,
                    child: AppText(
                      text: elect.name[0],
                      textColor: AppColors.bgColor,
                      textSize: 25,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, index) =>
              const Divider(color: AppColors.lightGreen),
          itemCount: ctrl.electDiscos.length,
        );
      }
    );
  }
}
