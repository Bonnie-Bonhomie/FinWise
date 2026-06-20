
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final editCtrl = Get.find<EditProfileCtrl>();
  final nav = Get.find<ProfileMainControl>();
  final home = Get.find<NavControl>();
  final loader = Get.find<LoaderController>();

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async {
      await auth.getEmail();
      await editCtrl.getProfile();
      await editCtrl.getReferrals();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              title: Text('My Profile', style: TextStyle(color: AppColors.bgColor),),
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.gradientGreen],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Decorative
                      Positioned(
                        right: -60,
                        top: -60,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.07),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -40,
                        bottom: -40,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                      ),
                      Center(
                        child: Obx(() {
                          final image = nav.picked.value;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              Container(
                                width: 88,
                                height: 88,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.2),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                child: image != null
                                    ? SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: ClipOval(
                                          child: Image.file(
                                            image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 45,
                                        backgroundColor: AppColors.lightGreen,
                                        // backgroundImage: Image(image: Image.file(file)),
                                        child: Icon(
                                          Icons.person_outline_outlined,
                                          size: 80,
                                          color: AppColors.blue,
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                auth.name.value,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                    color: Colors.white
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                auth.email.value,
                                style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7)),
                              ),
                              const SizedBox(height: 14),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      const Text('Referral code'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(editCtrl.userProfile?.username ?? ''),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: editCtrl.userProfile?.username ?? '...'));
                                showToast();
                              },
                              icon: Icon(Icons.copy_rounded),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text('Your Referral List'),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(20)),
                        child: editCtrl.loadRef.value? Text('loading...'): editCtrl.referralList.isEmpty?  Text(editCtrl.referralErr.value):
                        Column(
                          children: List.generate(editCtrl.referralList.length, (index){
                            return Text('My Referral');
                          }),
                        ),
                      ),

                      const SizedBox(height: 30,),
                      ///Profile Lists
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
                        AppColors.declined.withOpacity(0.3),
                        () {
                          logoutDialog(context, () {
                            loader.offLoading(() async {
                              await auth.logOut();
                              home.selectInd.value = 0;
                            });
                          });
                        },
                      ),
                    ],
                  );
                }),
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
      padding: const EdgeInsets.fromLTRB(0, 10, 15, 5),
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
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }

  void showToast(){
    Fluttertoast.showToast(msg: 'Copied', backgroundColor: AppColors.lightGreen);
  }
}
