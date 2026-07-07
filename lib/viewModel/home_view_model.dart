import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel {
  String greeting() {
    final time = DateTime.now().hour;
    String greet;
    if (time <= 12) {
      greet = 'Good Morning';
    } else {
      greet = 'Good Day';
    }
    return greet;
  }

  //Account state
  int getState(percent) {
    final int index;
    if (percent < 70) {
      index = 0;
    } else {
      index = 1;
    }
    return index;
  }

  //
  String formatCurrency(double amount) {
    final formatted = NumberFormat('#,##0.00').format(amount);
    return '₦$formatted';
  }
  String formatCurrNoKobo(double amount) {
    final formatted = NumberFormat('#,##0').format(amount);
    return '₦$formatted';
  }

  String numberBack(String number) {
    final formated = number.replaceAll(' ', '');
    return formated;
  }

  // Currency formatter
  String currencyFormatter(String amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 00,
      customPattern: '#,##0.00',
    );
    return formatter.format(amount);
  }

  Future<void> onRefresh(Function action) async {
    Future.delayed(Duration(seconds: 2), await action());
  }

  Future<void> openUrl(String link) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $link');
    }
  }

  Future<void> launchre(String source) async {
    final Uri url = Uri.parse(source);

    if (await canLaunchUrl(url)) {
      await launchUrl(url,);
    }
  }


  Future<void> openWhatsApp() async {
    try{
      final Uri whatsapp = Uri.parse(
        'https://wa.me/2349032350594?text=Thank%20you%20for%20contacting%20DatabootNg.%20How%20can%20we%20help%20you%20today%3F',
      );

      if (!await launchUrl(whatsapp, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $whatsapp');
      }
    }catch(e){
      print(e);
    }
  }

  Future<void> openEmail() async {


    try{
      // final Uri email = Uri(
      //   scheme: 'mailto',
      //   path: 'akinyemi4taiwo@gmail.com',
      //   queryParameters: {
      //     'subject': 'Support+Request',
      //     'body': 'Hello, I need help with...',
      //   },
      // );

      final email = Uri.parse('mailto:akinyemi4taiwo@gmail.com?subject=Support%20Request&body=Hello,%20I%20need%20help%20with...');

      if (!await canLaunchUrl(email)) {
        await launchUrl(email);
      }

    }catch(e){
      print(e);
    }
  }

  Future<void> makeCall() async {
    final Uri phone = Uri(
      scheme: 'tel',
      path: '09032350594',
    );

    if (await canLaunchUrl(phone)) {
      await launchUrl(phone);
    }
  }

  String formatDate(String value){

    DateTime date =  DateTime.parse(value);

    String formatted = DateFormat('MMMM dd, yyyy').format(date);
    String formatTime = DateFormat('HH:mm').format(date);
    return '$formatted ~ $formatTime';
  }

  double parseAmount(text){
    double amount;
    if(text.isNotEmpty){
      amount = double.parse(text);
      return amount;
    }
    return 0.00;
  }

  String formatDateOnly(String value){

    DateTime date =  DateTime.parse(value);

    String formatted = DateFormat('MMMM dd, yyyy').format(date);
    return formatted;
  }


  String? textToTims(String text){
    String formated = text;
    if(text.length <= 4) return formated;
    formated = text.substring(0, 4) +'*' * (text.length - 4);
    return formated;}

  int halfList(int len){
    int half = 1;
    if(len == half) return half;
    if(len % 2 == 0){
      half = (len /2).toInt();

    }else{
      len = len -1;
      half = (len/2).toInt();
      half = half +1;
    }
    return half;
  }

  ///Calculate percentage function
  int calculatePercent(double amount, double discount){

    int percent = 0;
    final calc = (100 * (amount - discount)) / amount;
    percent = calc.toInt();
    return percent;
  }

}


