import 'package:dio/dio.dart';
import 'package:fin_wise/core/resources/data_state.dart';
import 'package:fin_wise/data/dataSource/storage_file.dart';
import 'package:fin_wise/data/models/chat_model.dart';
import 'package:fin_wise/data/models/faqs_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/repositories/repo_exports.dart';
import '../../utils/utils_export.dart';

class HelpControl extends GetxController {

  final HelpCenterRepo repo;
  final StorageFile store;

  HelpControl(this.repo, this.store);

  final ScrollController scroll = ScrollController();
  var faqSections = ['General', 'Account', 'Service'];

  var faqQuestion = <FaqsModel>[].obs;
  var faqServiceQ = [].obs;
  var faqAccountQ = [].obs;
  var faqError = ''.obs;
  var faqIndex = 0.obs;
  var loading = false.obs;

  Future<void> getFaqs(int index) async {
    try {
      loading.value = true;
      final token = await store.getToken();

      if (token == null) {
        faqError.value = 'Unauthenticated';
        return;
      }
      String type = faqSections[index].toLowerCase();
      final response = await repo.getFaqs(token, type);

      print(response.data);
      if (response is DataSuccess) {
        List questions = response.data;
        final quest = questions.map((e) => FaqsModel.fromJson(e));
        faqQuestion.assignAll(quest);
      }
      else if (response is DataFailed) {
        final err = response.exception;

        if (err is DioException) {
          //  Network issues
          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.receiveTimeout ||
              err.type == DioExceptionType.connectionTimeout) {
            CustomSnackbar.showSnackbar(title: 'No internet connection',
                message: 'Check your internet connection');
            return;
          }

          //  Server error
          final errData = err.response?.data;

          if (errData != null && errData['message'] != null) {
            CustomSnackbar.showSnackbar(message: errData['message']);
          } else {
            CustomSnackbar.showSnackbar(
              message: 'Server error, try again later',
            );
          }
        } else {
          CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
        }
      }
    } catch (e) {
      print(e);
      CustomSnackbar.showSnackbar(message: 'Unknown error occurred');
    }
    finally {
      loading.value = false;
    }
  }


  var chats = [
    ChatModel(
      text: 'Welcome I am your virtual assistant',
      isAsk: false,
      createAt: DateTime(2026, 2, 11, 10, 30),
    ),
    ChatModel(
      text: 'HOW CAN i HELP YOU?',
      isAsk: false,
      createAt: DateTime(2026, 2, 11, 10, 30),
    ),
  ].obs;

  void scrollDown() {
    Future.delayed(Duration(milliseconds: 300), () {
      scroll.animateTo(
        scroll.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      );
    });
  }

  void sendQuestion(ChatModel question) {
    chats.add(question);
    update();
    scrollDown();
  }
}