import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseState with ChangeNotifier {
  late Database _db;

  Database get db => _db;
  set db(Database tDb) {
    _db = tDb;
    notifyListeners();
  }
}
