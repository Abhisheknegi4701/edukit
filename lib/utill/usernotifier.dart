
import 'package:flutter/cupertino.dart';

class UserNotifier extends ChangeNotifier{
  static String? lastLogin;
  static String? created;
  static String? mobileToken;
  static String? lastModified;
  static String? id;
  static String? name;
  static String? email;
  static String? password;
  static String image = '';

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

}