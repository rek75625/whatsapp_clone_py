import 'package:sqflite/sqflite.dart';

class DBHelper {
  /// Singleton
  DBHelper._();

  /// Creat a single instance to prevent from multiple instance as well as
  /// we use state because we want to use it outsite of that class without it
  /// we can instantiate within the class but cannot be used it but we want
  /// and final is used for once allocation and prevent to re-allocation
  static final DBHelper getInstance = DBHelper._();

  Database? myDB;

  /// DB Open (path -> if exist then open else create DB) path is for cache
  /// management because data be store at specific path and same must be access
  /// by it so if incase use remove cache (in setting of App) in this case we
  /// again create other wise it work for better user experience at offline
  Database getDB() {
    if (myDB != null) {
      return myDB!;
    } else {
      openDB();
      return myDB!;
    }
  }

  openDB() {}
}
