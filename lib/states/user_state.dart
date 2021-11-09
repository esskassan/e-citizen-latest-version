import '/models/user_model.dart';
import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  late Users _actualUser;

  Users get actualUser => _actualUser;
  set actualUser(Users tUser) {
    _actualUser = tUser;
    notifyListeners();
  }
}
