import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/controller_exports.dart';
import '../../../../core/app_colors.dart';
import '../../../../utils/widgets/widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final storage = SharedPreferService();
  final AuthCtrl auth = Get.find<AuthCtrl>();
  final nav = Get.find<ProfileMainControl>();
  final loader = Get.find<LoaderController>();
  String name = '';
  String id = 'Unknown';

  void getUser() async{
    name = (await storage.retrieve<String>(PrefStoreKeys.username)) ?? 'Unknown';
    id = await storage.retrieve(PrefStoreKeys.userId);
  }


  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: LoaderWrapper(
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        AppText(
                          text: name,
                          textWeigh: FontWeight.bold,
                          textSize: 25,
                        ),
                        AppText(text: 'ID: $id'),
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
                            logoutDialog(context, (){
                              loader.offLoading(() async{
                                await auth.logOut();
                              });
                            });
                          },
                        ),
                      ],
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
                        child: Icon(Icons.person_outline_outlined, size: 80, color: AppColors.blue,),
                      );}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        title: AppText(text: title, ),
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
