import 'package:fin_wise/controllers/profileCtrl/edit_ctrl.dart';
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> mailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> numberKey = GlobalKey<FormFieldState>();


  final nav = Get.find<EditProfileCtrl>();
  final SharedPreferService storage = SharedPreferService();

  String imgPath = '';
  void onRefresh(){
    Future.delayed(Duration(seconds: 1), () => nav.getProfile());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LoaderWrapper(
        child: RefreshIndicator(
          onRefresh: () async{ return onRefresh();},
          child: Obx((){
            if(nav.loading.value){
              return CircularProgressIndicator(color: AppColors.primary,);
            }
             final user = nav.userProfile;
              return ListView(
                children: [

                  CustomAppBar.header(title: 'Profile', leftRight: 15, onPressed: () {
                    Get.find<ProfileMainControl>().back();
                  }),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        // height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.only(top: 50),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              SizedBox(height: 40),
                              AppText(
                                text: user!.name ,
                                textWeigh: FontWeight.bold,
                                textSize: 20,
                              ),
                              AppText(text: ' ID: ${user.id}'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(height: 20,),
                                  const AppText(
                                    text: 'Account Settings',
                                    textWeigh: FontWeight.bold,
                                    textSize: 20,
                                  ),
                                  const SizedBox(height: 20),
                                  labelText('UserName'),
                                  inputField(ctrl: nav.nameCtrl, label: user.name),
                                  labelText('Phone Number'),
                                  inputField(
                                    ctrl: nav.numberCtrl,
                                    label: user.phone,
                                    type: TextInputType.number,
                                  ),
                                  labelText('Email Address'),
                                  inputField(ctrl: nav.mailCtrl, label: user.email),
                                  const SizedBox(height: 30.0,),
                                  AppBtn(onPressed: () {
                                      Get.find<ProfileMainControl>().back();
                                  }, label: 'Update Profile'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Obx((){
                              final image = nav.picked.value;
                              return
                              image != null ?  SizedBox(
                                height: 90,
                                width: 90,
                                child: ClipOval(
                                  child: Image.file(image, fit: BoxFit.cover,),
                                ),
                              ):
                                CircleAvatar(
                              radius: 45,
                                backgroundColor: AppColors.lightGreen,
                                // backgroundImage: Image(image: Image.file(file)),
                                child:Icon(Icons.person_outline_outlined, size: 80, color: AppColors.blue,),
                              );}
                            ),
                            InkWell(
                              onTap: () {
                                nav.selectImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.primary,
                                radius: 15,
                                child: Icon(Icons.photo_camera_back, size: 20, color: AppColors.lightGreen,),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ],
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }


  Widget labelText(String title) =>
      AppText(text: title, textWeigh: FontWeight.w500);

  Widget inputField({
    required TextEditingController ctrl,
    required String label,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: label,

        ),
      ),
    );
  }
}
