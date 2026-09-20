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
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> myData = await db.query(TABLE_NAME);
    return myData;
  }

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
  Future<bool> updateNote({
    required String myTitle,
    required String myDesc,
    required int sno,
  }) async {
    var db = await getDB();
    int rowEffected = await db.update(TABLE_NAME, {
      COL_NOTE_TITLE: myTitle,
      COL_NOTE_DESC: myDesc,
    }, where: "$COL_NOTE_SNO=$sno");
    return rowEffected > 0;
  }

  /// Deletion
  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();
    int rowEffected = await db.delete(
      TABLE_NAME,
      where: "$COL_NOTE_SNO=?",
      whereArgs: ["$sno"],
    );
    return rowEffected > 0;
  }
}

class DBHelperUni {
  /// Singleton
  DBHelperUni._();

  /// Create a single instance
  static final DBHelper getInstance = DBHelper._();

  /// Table Name
  static final String TABLE_NAME = "students";

  /// Column Names
  static final String COL_STUDENT_SNO = "s_no";
  static final String COL_STUDENT_NAME = "name";
  static final String COL_STUDENT_EMAIL = "email";
  static final String COL_STUDENT_PHONE = "phone";
  static final String COL_STUDENT_DEPARTMENT = "department";
  static final String COL_STUDENT_SEMESTER = "semester";
  static final String COL_STUDENT_CGPA = "cgpa";

  Database? myDB;

  // ============================================================
  // DATABASE
  // ============================================================

  /// Get Database
  ///
  /// If database is already open, return the existing database.
  /// Otherwise, create/open the database.
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  /// Open Database
  ///
  /// If database exists -> open it
  /// If database does not exist -> create it
  Future<Database> openDB() async {
    /// Get application documents directory
    Directory appDir = await getApplicationDocumentsDirectory();

    /// Create database path
    String dbPath = join(appDir.path, "universityDb.db");

    /// Open/Create database
    return await openDatabase(
      dbPath,
      version: 1,

      /// Create table when database is created for the first time
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_NAME (
            $COL_STUDENT_SNO INTEGER PRIMARY KEY AUTOINCREMENT,
            $COL_STUDENT_NAME TEXT,
            $COL_STUDENT_EMAIL TEXT,
            $COL_STUDENT_PHONE TEXT,
            $COL_STUDENT_DEPARTMENT TEXT,
            $COL_STUDENT_SEMESTER INTEGER,
            $COL_STUDENT_CGPA REAL
          )
          ''');
      },
    );
  }

  // ============================================================
  // GET ALL STUDENTS
  // ============================================================

  /// Get all students
  Future<List<Map<String, dynamic>>> getAllStudents() async {
    var db = await getDB();

    List<Map<String, dynamic>> myData = await db.query(
      TABLE_NAME,
      orderBy: "$COL_STUDENT_SNO DESC",
    );

    return myData;
  }

  // ============================================================
  // INSERT STUDENT
  // ============================================================

  /// Add a new student
  Future<bool> addStudent({
    required String name,
    required String email,
    required String phone,
    required String department,
    required int semester,
    required double cgpa,
  }) async {
    var db = await getDB();

    int rowEffected = await db.insert(TABLE_NAME, {
      COL_STUDENT_NAME: name,
      COL_STUDENT_EMAIL: email,
      COL_STUDENT_PHONE: phone,
      COL_STUDENT_DEPARTMENT: department,
      COL_STUDENT_SEMESTER: semester,
      COL_STUDENT_CGPA: cgpa,
    });

    return rowEffected > 0;
  }

  // ============================================================
  // UPDATE STUDENT
  // ============================================================

  /// Update existing student
  Future<bool> updateStudent({
    required String name,
    required String email,
    required String phone,
    required String department,
    required int semester,
    required double cgpa,
    required int sno,
  }) async {
    var db = await getDB();

    int rowEffected = await db.update(
      TABLE_NAME,
      {
        COL_STUDENT_NAME: name,
        COL_STUDENT_EMAIL: email,
        COL_STUDENT_PHONE: phone,
        COL_STUDENT_DEPARTMENT: department,
        COL_STUDENT_SEMESTER: semester,
        COL_STUDENT_CGPA: cgpa,
      },
      where: "$COL_STUDENT_SNO = ?",
      whereArgs: [sno],
    );

    return rowEffected > 0;
  }

  // ============================================================
  // DELETE STUDENT
  // ============================================================

  /// Delete student
  Future<bool> deleteStudent({required int sno}) async {
    var db = await getDB();

    int rowEffected = await db.delete(
      TABLE_NAME,
      where: "$COL_STUDENT_SNO = ?",
      whereArgs: [sno],
    );

    return rowEffected > 0;
  }

  // ============================================================
  // GET SINGLE STUDENT
  // ============================================================

  /// Get one student by ID
  Future<Map<String, dynamic>?> getStudentById({required int sno}) async {
    var db = await getDB();

    List<Map<String, dynamic>> data = await db.query(
      TABLE_NAME,
      where: "$COL_STUDENT_SNO = ?",
      whereArgs: [sno],
    );

    if (data.isNotEmpty) {
      return data.first;
    }

    return null;
  }

  // ============================================================
  // SEARCH STUDENTS
  // ============================================================

  /// Search students by name
  Future<List<Map<String, dynamic>>> searchStudents({
    required String keyword,
  }) async {
    var db = await getDB();

    List<Map<String, dynamic>> data = await db.query(
      TABLE_NAME,
      where: "$COL_STUDENT_NAME LIKE ?",
      whereArgs: ["%$keyword%"],
      orderBy: "$COL_STUDENT_NAME ASC",
    );

    return data;
  }

  // ============================================================
  // GET STUDENTS BY DEPARTMENT
  // ============================================================

  /// Get students from a specific department
  Future<List<Map<String, dynamic>>> getStudentsByDepartment({
    required String department,
  }) async {
    var db = await getDB();

    List<Map<String, dynamic>> data = await db.query(
      TABLE_NAME,
      where: "$COL_STUDENT_DEPARTMENT = ?",
      whereArgs: [department],
      orderBy: "$COL_STUDENT_NAME ASC",
    );

    return data;
  }
}
