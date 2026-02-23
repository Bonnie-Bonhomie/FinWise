class HomeViewModel{

  String greeting(){
    final time = DateTime.now().hour;
    String greet;
    if(time <= 12){
      greet = 'Good Morning';
    }
    greet = 'Good Day';
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

}