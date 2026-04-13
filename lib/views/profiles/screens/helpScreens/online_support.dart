import 'package:fin_wise/controllers/profileCtrl/help_center_ctrl.dart';
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/chat_model.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OnlineSupportView extends StatelessWidget {
  OnlineSupportView({super.key});

  final ctrl = Get.find<HelpControl>();
  final questionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          title: 'Online Support',
          leftRight: 15,
          onPressed: () => Get.find<ProfileMainControl>().back(),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                controller: ctrl.scroll,
                  itemCount: ctrl.chats.length,
                  itemBuilder: (context, index) {
                    final chat = ctrl.chats[index];
                    final formatTime = DateFormat('HH:mm').format(chat.createAt);
                    return Padding(
                      padding: chat.isAsk
                          ? const EdgeInsets.fromLTRB(50, 10, 15, 10)
                          : const EdgeInsets.fromLTRB(15, 10, 50, 10),
                      child: Column(
                        crossAxisAlignment: chat.isAsk? CrossAxisAlignment.end: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: chat.isAsk
                                  ? AppColors.primary
                                  : AppColors.lightGreen,
                            ),
                            child: AppText(text: chat.text),
                          ),
                          AppText(text: formatTime),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.primary,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  sideButton(Icons.camera_alt_outlined, () {}),
                  Expanded(
                    child: TextFormField(
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline, //for The input field to be expended and scrollable inside
                      controller: questionCtrl,
                      decoration: InputDecoration(
                        hint: Text('Write Here...'),
                        filled: true,
                        fillColor: AppColors.bgColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  sideButton(Icons.mic_none, () {}),
                  sideButton(Icons.send_outlined, () {
                    questionCtrl.text.isEmpty
                        ? Get.snackbar('', 'Type your question in the box')
                        : ctrl.sendQuestion(
                            ChatModel(
                              text: questionCtrl.text,
                              isAsk: true,
                              createAt: DateTime.now(),
                            ),
                          );
                    questionCtrl.text = '';
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sideButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      icon: Icon(icon),
    );
  }
}
