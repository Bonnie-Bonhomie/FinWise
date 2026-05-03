
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/views/view_widgets/cancel_button.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_colors.dart';
import '../../../../data/models/AuthModel/user_model.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final user = UserModel(
    name: 'John Smith',
    email: 'johnsmith@gmail.com',
    pNumber: '08034623771',
    id: '1235728949',
    token: '',
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LoaderWrapper(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 40),
              CustomAppBar.header(title: 'Profile', leftRight: 10, onPressed: () {}),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(top: 50),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                        color: AppColors.bgColor,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 50),
                          AppText(
                            text: user.name,
                            textWeigh: FontWeight.bold,
                            textSize: 25,
                          ),
                          AppText(text: 'ID: ${user.id}'),
                          SizedBox(height: 20),

                          //Profile Lists
                          profileTile(
                            'Edit Profile',
                            Icons.person_outline_outlined,
                            AppColors.blue,
                            () {
                              Get.find<ProfileMainControl>().toEdit();
                            },
                          ),
                          profileTile(
                            'Security',
                            Icons.safety_check,
                            AppColors.subBlue,
                            () {
                              Get.find<ProfileMainControl>().toSecurity();
                            },
                          ),
                          profileTile(
                            'Setting',
                            Icons.settings_outlined,
                            AppColors.superBlue,
                            () {
                              Get.find<ProfileMainControl>().toSettings();
                            },
                          ),
                          profileTile(
                            'Help',
                            Icons.help_outline_rounded,
                            AppColors.subBlue,
                            () {
                              Get.find<ProfileMainControl>().toHelp();
                            },
                          ),
                          profileTile(
                            'Logout',
                            Icons.logout_outlined,
                            AppColors.blue,
                            () {
                              logoutDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    // Obx((){
                    //   final image = nav.picked.value;
                    //   return
                    //     image != null ?  SizedBox(
                    //       height: 90,
                    //       width: 90,
                    //       child: ClipOval(
                    //         child: Image.file(image, fit: BoxFit.cover,),
                    //       ),
                    //     ):
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.lightGreen,
                          // backgroundImage: Image(image: Image.file(file)),
                          child: Icon(Icons.person_outline_outlined, size: 80, color: AppColors.blue,),
                        )
              // ;}
              //             ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logoutDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: AppColors.bgColor,
        title: const HeadingText(headingText: 'End Session',),
        content: const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: AppText(text: 'Are you sure you want to log out?', textAlign: TextAlign.center,),
        ),
        
        actions: [
          AppBtn(onPressed: (){
            Get.back();
            // LoaderController.to.show();
            // Future.delayed(Duration(seconds: 1));
            Get.offAllNamed(Routes.login);
          }, label: 'Yes, End Session', textSize: 15),
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CancelBtn(onPressed: (){Get.back();})
          ),
        ],
      );
    });
  }

  Widget profileTile(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      child: ListTile(
        title: AppText(text: title),
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Icon(icon, color: AppColors.bgColor),
        ),
        onTap: onTap,
      ),
    );
  }
}
