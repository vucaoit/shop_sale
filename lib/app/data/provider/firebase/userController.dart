import 'package:get/get.dart';
import '../../model/user.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel(id: '',email: '',name: '').obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => this._userModel.value = value;

  void clear() {
    _userModel.value = UserModel(id: '',name: '',email: '');
  }
}