import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageFile{

  final _storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async{
    await _storage.write(key: PrefStoreKeys.authKey, value: token);
  }
  Future<String?> getToken() async{
    return await _storage.read(key: PrefStoreKeys.authKey);
  }

  Future<void> deleteToken() async{
    await _storage.deleteAll();
  }

}