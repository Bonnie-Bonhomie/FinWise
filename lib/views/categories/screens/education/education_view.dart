import 'package:fin_wise/controllers/categoryCtrl/education_controller.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/loading_skeleton.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/empty_state.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationView extends StatelessWidget {
  EducationView({super.key});

  final TextEditingController searchCtrl = TextEditingController();
  final ctrl = Get.find<EducationController>();


  void onRefresh(){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: RefreshIndicator(
          onRefresh: () async{return onRefresh();},
          child: PageContainer(
            topMargin: 20,
            topChild: CustomAppBar.header(
              title: 'Education',
              leftRight: 15,
              onPressed: () => Get.back(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx((){

                      if(ctrl.loadingCard.value){
                        return Center(child: SkeletonLoader.shimmerLines(len: 4),);

                      }else if(ctrl.eduCards.isEmpty){
                        return EmptyState(message: 'message');
                      }
                        return ListView.separated(
                          padding: const EdgeInsets.only(top: 15),
                          itemBuilder: (context, index) {
                            final school = ctrl.eduCards[index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.buyPin, arguments: school);
                              },
                              title: Text(school.name, overflow: TextOverflow.ellipsis),
                              subtitle: Text(
                                school.variationCode.toUpperCase(),
                                style: TextStyle(color: AppColors.primary),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.subBlue,
                                child: AppText(
                                  text: school.name[0],
                                  textColor: AppColors.bgColor,
                                  textSize: 25,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) =>
                              const Divider(color: AppColors.lightGreen),
                          itemCount: ctrl.eduCards.length,
                        );
                      }
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
}
