class TopViewModel{

  static String formatted(text) {
    final formated =
        "${text.substring(0, 3)} "
        "${text.substring(3, 7)} "
        "${text.substring(7)}";

    return formated;
  }

  static bool checkProvider(text){
    if(text.substring(9,13) == '5656')return true;
    return false;
  }

  static int convertInt(source){
    int number = int.tryParse(source) ?? 0;
    return number;
  }
}