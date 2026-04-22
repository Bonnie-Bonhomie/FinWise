import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferService {
//Singleton to access the SharedPreference across the app
  static final SharedPreferService _service = SharedPreferService._internal();

  late SharedPreferences _pref;

  factory SharedPreferService (){
    return _service;
  }

  SharedPreferService._internal();

  //Initialized the sharedPreference

  Future<SharedPreferService> init() async {
    try {
      _pref = await SharedPreferences.getInstance();
      if (kDebugMode) {
        print('Shared Preference initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialized shared Preference $e');
      }
    }
    return this;
  }

  Future<void> ensuredInitialized() async{
    await init();
  }


  Future<void> saveData<T>(String key, T value) async{
    await ensuredInitialized();

    if(value is String){
      await _pref.setString(key, value);
    }else if(value is double){
      await _pref.setDouble(key, value);
    } else if(value is int){
      await _pref.setInt(key, value);
    }else if(value is bool){
      await _pref.setBool(key, value as bool);
    }
    if(kDebugMode){
      print('Saved $key, $value');
    }
  }



  Future<T?> retrieve<T>(String key) async {
    await ensuredInitialized();
   final value =  _pref.get(key);
   if(kDebugMode){
     print('Retrieved successfully $value');
   }
   return value as T?;
  }




  //Remove a value
  Future<void> deleteValue(String key) async{
    await ensuredInitialized();
    await _pref.remove(key);
  }

  Future<void> clearAll() async {
    await ensuredInitialized();
    await _pref.clear();
  }

  
}