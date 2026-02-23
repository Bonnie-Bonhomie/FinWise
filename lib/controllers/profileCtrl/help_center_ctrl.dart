import 'package:fin_wise/data/models/chat_model.dart';
import 'package:fin_wise/data/models/faqs_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HelpControl extends GetxController {
  final ScrollController scroll = ScrollController();
  var faqSections = ['General', 'Account', 'Service'];

  var faqGeneralQ = [].obs;
  var faqIndex = 0.obs;

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

  var faqServiceQ = [
    FaqsModel(
      question: 'How can I create my account?',
      answer:
          'Go to sign up page , enter your full name, date of birth, phone number and create password for yourself',
    ),
    FaqsModel(
      question: 'How can I change my password?',
      answer:
          'Go to the Edit page select Settings then select Change password and follow the instructions ',
    ),
  ];

  var faqAccountQ = [
    FaqsModel(
      question: 'How to sell Data?',
      answer:
          'Login to your account select the data category and follow the given instructions in the category.',
    ),
    FaqsModel(
      question: 'How to check my expense',
      answer:
          'To check all your expenses Go to the transaction page you will see the list of your transaction and your daily, monthly and yearly expenses',
    ),
  ].obs;
}
