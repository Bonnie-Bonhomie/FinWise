import 'dart:math';

import 'package:data_boot/controllers/controller_exports.dart';
import 'package:data_boot/views/view_widgets/empty_state.dart';
import 'package:data_boot/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';

class ReferralsView extends StatefulWidget {
  const ReferralsView({super.key});

  @override
  State<ReferralsView> createState() => _ReferralsViewState();
}

class _ReferralsViewState extends State<ReferralsView> {
  final editCtrl = Get.find<EditProfileCtrl>();

  bool copied = false;

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() async {
      await editCtrl.getProfile();
      await editCtrl.getReferrals();
    });
    super.initState();
  }

  List<Color> colors = [
    AppColors.superBlue,
    AppColors.pink,
    AppColors.subBlue,
    AppColors.purple,
    AppColors.blue,
    AppColors.subPu,
  ];

  int ranDomIndex() {
    final rand = Random();
    int number = rand.nextInt(5);
    return number;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topPadding: 10,
        bottomPadding: 10,
        topMargin: 3.0,
        topChild: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('assets/images/refer.png'),
                height: 200,
                width: 200,
                errorBuilder: (_, __, ___) =>
                   const Icon(Icons.image_outlined, size: 50),
              ),
              const Text(
                'Earn Money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.bgColor,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'By Refer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.bgColor,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                              Text(editCtrl.userProfile?.username ?? ''),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: editCtrl.userProfile?.username ?? '...',
                                ),
                              );
                              setState(() => copied = true);
                            },
                            child: Text(copied ? 'copied' : 'copy'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () => Get.find<ProfileMainControl>().back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade300,
                        padding: const EdgeInsets.all(5),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('My Referees'),
                    const Icon(Icons.people_alt, color: AppColors.primary),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Obx(() {
                if (editCtrl.loadRef.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (editCtrl.referralList.isEmpty) {
                  return Center(child: EmptyState(message: editCtrl.referralErr.value));
                }
                return Column(
                  children: List.generate(editCtrl.referralList.length, (
                    index,
                  ) {
                    final refer = editCtrl.referralList[index];
                    return ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              colors[ranDomIndex() + 1],
                              colors[ranDomIndex()],
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            refer.refereeName[0].toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              color: AppColors.bgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(refer.refereeName),
                      subtitle: Text('Bonus: ${refer.status == '1' ? '₦${refer.bonus}': ' ...'}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pinkAccent,
                        ),
                        child:  Text(
                          refer.status == '0'? 'pending' : 'redeem',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
