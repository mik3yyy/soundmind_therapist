import 'package:hive_flutter/hive_flutter.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/user.dart';

abstract class AuthenticationHiveDataSource {
  Future<void> saveUser({required UserModel userModel});
  Future<void> deleteUser();
  Future<UserModel> getUser();
}

class AuthenticationHiveDataSourceImpl extends AuthenticationHiveDataSource {
  String key = 'userKey';
  final Box _box;

  AuthenticationHiveDataSourceImpl({required Box box}) : _box = box;

  @override
  Future<void> deleteUser() async {
    await _box.delete(key);
  }

  @override
  Future<void> saveUser({required UserModel userModel}) async {
    await _box.put(key, userModel.toJson());
  }

  @override
  Future<UserModel> getUser() async {
    // TODO: implement getUser
    var res = _box.get(key);
    print(res);
    return UserModel.fromJson(res);
  }
}
