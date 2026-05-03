import 'package:fin_wise/controllers/bottom_nav_ctrl.dart';
import 'package:fin_wise/controllers/profileCtrl/edit_ctrl.dart';
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/AuthModel/user_model.dart';
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

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController numCtrl = TextEditingController();
  final TextEditingController malCtrl = TextEditingController();
  bool pushNotify = true;
  bool mailNotify = false;

  final user = UserModel(
    name: 'John Smith',
    email: 'johnsmith@gmail.com',
    pNumber: '08034623771',
    id: '1235728949',
    token: '',
  );

  final nav = Get.find<EditProfileCtrl>();

  String imgPath = '';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LoaderWrapper(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.end,
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
                    color: AppColors.bgColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        AppText(
                          text: user.name,
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
                            inputField(ctrl: nameCtrl, label: user.name),
                            labelText('Phone Number'),
                            inputField(
                              ctrl: numCtrl,
                              label: user.pNumber,
                              type: TextInputType.number,
                            ),
                            labelText('Email Address'),
                            inputField(ctrl: malCtrl, label: user.email),
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
                Positioned(
                  top: 45,
                  right: 130,
                  child: InkWell(
                    onTap: () {
                      nav.selectImage();
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 15,
                      child: Icon(Icons.photo_camera_back, size: 20, color: AppColors.darkGreen,),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
          fillColor: AppColors.lightGreen,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
