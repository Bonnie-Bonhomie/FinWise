import 'package:fin_wise/controllers/loader_contrl.dart';

Future<T> runWithLoader<T>(Future<T> Function() action) async{

  LoaderController.to.show();

  Future.delayed(Duration(seconds: 1),);
  try{
    return await action();
  }finally{
    LoaderController.to.hide();
  }
}