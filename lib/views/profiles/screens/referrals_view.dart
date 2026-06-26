import 'dart:math';

import 'package:fin_wise/controllers/controller_exports.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
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
        topChild: Column(
          children: [
            Image(image: AssetImage('assets/images/refer.jpg')),
            Text(
              'Earn Money By Refer',
              style: TextStyle(
                color: AppColors.bgColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(editCtrl.userProfile?.username ?? ''),
                      TextButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: editCtrl.userProfile?.username ?? '...',
                            ),
                          );
                          setState(() => copied = true);
                        },
                        child: Text(copied? 'copied': 'copy'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () => Get.find<ProfileMainControl>().back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.all(10),
                  ),
                  child: Text('Back'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Referees'),
                const Icon(Icons.people_alt, color: AppColors.primary,)
              ],
            ),

            const SizedBox(height: 20,),
            Obx(() {
              if (editCtrl.loadRef.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (editCtrl.referralList.isEmpty) {
                return Center(child: Text(editCtrl.referralErr.value));
              }
              return Column(
                children: List.generate(editCtrl.referralList.length, (index) {
                  final refer = editCtrl.referralList[index];
                  return ListTile(
                    leading: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            colors[ranDomIndex() + 1],
                            colors[ranDomIndex()],
                          ],begin: Alignment.topRight, end: Alignment.bottomLeft
                        ),
                      ),child: Text(refer.refereeName[0].toUpperCase(), style: TextStyle(fontSize: 25, color: AppColors.bgColor),),
                    ),
                    title: Text(refer.refereeName),
                    subtitle: Text('Bonus: ${refer.bonus}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink.shade400,
                      ),
                      child: Text(
                        'invited',
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }

}
