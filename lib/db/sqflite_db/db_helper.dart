// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  /// Singleton
  DBHelper._();

  /// Creat a single instance to prevent from multiple instance as well as
  /// we use state because we want to use it outsite of that class without it
  /// we can instantiate within the class but cannot be used it but we want
  /// and final is used for once allocation and prevent to re-allocation
  static final DBHelper getInstance = DBHelper._();
  static final String TABLE_NAME = "note";
  static final String COL_NOTE_SNO = "s_no";
  static final String COL_NOTE_TITLE = "title";
  static final String COL_NOTE_DESC = "desc";

  Database? myDB;

  /// DB Open (path -> if exist then open else create DB) path is for cache
  /// management because data be store at specific path and same must be access
  /// by it so if incase use remove cache (in setting of App) in this case we
  /// again create other wise it work for better user experience at offline
  Future<Database> getDB() async {
    myDB ??= await openDB(); //  myDB = myDB ?? await openDB(); we use Compound assign
    return myDB!;
    // Below is better but we want optimization
    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await openDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    /// Here getApplicationDocumentsDirectory says that if you are not waiting
    /// for path you use future else you use await but my problem is that if it
    /// will get a path than I can do my work futher so I must be waiting for it
    /// and if it will not get a path of directory than i cannot make a main path
    /// and if cannot make a main path I cannot open and creation of database
    /// go to use await keyword and you cannot do on main thread so always avoid
    /// You can use .then if data/path has come than do other operations but
    /// then only use when next work is not dependent on previous things
    Directory appDir = await getApplicationDocumentsDirectory();

    /// Her we creat a path for where we want to store or access database from
    /// that file like mymobile/appDir.path/noteDb.db
    String dbpath = join(appDir.path, "noteDb.db");

    /// Here we open or access our database path but we don't know it exists or
    /// not so if not than we go to creat our data base appDir.path/noteDb.db
    return await openDatabase(
      dbpath,
      onCreate: (db, version) {
        db.execute(
          "create table $TABLE_NAME ( $COL_NOTE_SNO integer primary key autoincrement, $COL_NOTE_TITLE text, $COL_NOTE_DESC text)",
        );
      },
      version: 1,
    );
  }

  /// All Queries
  /// Insertion
  Future<bool> addNote({
    required String myTitle,
    required String myDesc,
  }) async {
    var db = await getDB();
    int rowEffected = await db.insert(TABLE_NAME, {
      COL_NOTE_TITLE: myTitle,
      COL_NOTE_DESC: myDesc,
    });
    return rowEffected > 0;
  }

  /// Updation
  /// Deletion
}
