import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "pms.db";
  static final _databaseVersion = 1;
  static final columnId = 'id';
  static final date = 'date';

  static final table = 'pms_data_table';
  static final prodName = 'name';
  static final status = 'status';


  static final table_patient_serial = 'table_patient_serial';

  static final table_item_dispatch = 'table_item_dispatch';
  static final item_dispatch_quantity = 'item_dispatch_quantity';
  static final item_dispatch_serial = 'item_dispatch_serial';
  static final item_dispatch_medicine_name = 'item_dispatch_medicine_name';
  static final item_dispatch_medicine_id = 'item_dispatch_medicine_id';


  // table_drugs
  static final table_drugs = 'table_drugs';
  static final drug_name = 'drug_name';
  static final drug_id = 'drug_id';
  static final drug_generic_name = 'drug_generic_name';
  static final drug_generic_id = 'drug_generic_id';
  static final drug_pstrength_name = 'drug_pstrength_name';
  static final drug_pstrength_id = 'drug_pstrength_id';
  static final drug_available_stock = 'available_stock';
  static final drug_stock_receive = 'stock_receive';
  static final drug_stock_consume = 'stock_consume';
  static final drug_stock_lose = 'stock_lose';
  static final drug_reject_reason = 'reject_reason';
  static final drug_batch_no = 'batch_no';


  // table_internal_request
  static final table_internal_request = 'table_internal_request';

  static final internal_req_date = 'internal_req_date';
  static final internal_req_med_name = 'internal_req_med_name';
  static final internal_req_med_id = 'internal_req_med_id';
  static final internal_req_qty = 'internal_req_qty';
  static final internal_req_remark = 'internal_req_remark';


  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print(path);
    return await openDatabase(
        path, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $prodName TEXT NOT NULL,
             $status INT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_patient_serial (
            $columnId INTEGER PRIMARY KEY,
            $date INT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_item_dispatch (
            $columnId INTEGER PRIMARY KEY,
            $item_dispatch_serial INT NOT NULL,
            $date TEXT NOT NULL,
            $item_dispatch_medicine_name TEXT NOT NULL,
            $item_dispatch_medicine_id INT NOT NULL,
            $item_dispatch_quantity INT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_drugs (
            $columnId INTEGER PRIMARY KEY,
            $drug_id TEXT,
            $drug_name TEXT,
            $drug_generic_name TEXT,
            $drug_generic_id TEXT,
            $drug_pstrength_name TEXT,
            $drug_available_stock TEXT,
            $drug_stock_receive TEXT,
            $drug_stock_consume TEXT,
            $drug_stock_lose TEXT,
            $drug_batch_no TEXT,
            $drug_reject_reason TEXT,
            $drug_pstrength_id TEXT 
            
          )
          ''');


    await db.execute('''
          CREATE TABLE $table_internal_request (
            $columnId INTEGER PRIMARY KEY,
            $internal_req_date TEXT NOT NULL,
            $internal_req_med_name TEXT NOT NULL,
            $internal_req_med_id INT NOT NULL,
            $internal_req_qty INT NOT NULL,
            $internal_req_remark TEXT NOT NULL
          )
          ''');
  }

  // insert drug
  Future<int> insert_drug(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(
        table_drugs, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<int> deleteALlDrugs() async {
    Database db = await instance.database;
    return await db.delete(table_drugs);
  }

  Future<int> deleteALlDispatch() async {
    Database db = await instance.database;
    return await db.delete(table_item_dispatch);
  }

  Future<int> deletePserial() async {
    Database db = await instance.database;
    return await db.delete(table_patient_serial);
  }


  Future<List<Map<String, dynamic>>> queryAllDrugRows() async {
    Database db = await instance.database;
    return await db.query(table_drugs);
  }

  Future<List<Map<String, dynamic>>> queryAllDispatchRows() async {
    Database db = await instance.database;
    return await db.query(table_item_dispatch);
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  //Get all records which are unsynched
  Future<List<Map<String, dynamic>>> queryUnsynchedRecords() async {
    Database db = await instance.database;
    return await db.rawQuery(
        'SELECT id,name,status FROM $table WHERE status = 0');
  }

  Future<List<Map<String, dynamic>>> queryAllRecords() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT id,name,status FROM $table');
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }


  //patient_serial add
  Future<int> insert_patient_serial(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_patient_serial, row);
  }

  Future<int?> getAllPatientSerialCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table_patient_serial'));
  }

  Future<List<Map<String, dynamic>>> getAllPatientSerial() async {
    Database db = await instance.database;
    return await db.query(table_patient_serial);
  }

  Future<int> deleteSerial(String datedata) async {
    Database db = await instance.database;
    return await db.delete(
        table_patient_serial, where: '$date != ?', whereArgs: [datedata]);
  }

  //item dispatch add
  Future<int> insert_item_dispatch(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table_item_dispatch, row);
  }

  Future<List<Map<String, dynamic>>> get_tem_dispatch() async {
    Database db = await instance.database;
    return await db.query(table_item_dispatch);
  }

  // insert internal request
  Future<int> insert_internal_request(Map<String, dynamic> row) async {
    Database db = await instance.database;

    return await db.insert(table_internal_request, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

 // get internal request
  Future<List<Map<String, dynamic>>> get_internal_request() async {
    Database db = await instance.database;
    return await db.query(table_internal_request);
  }

  // delete internal request
  Future<int> delete_internal_request() async {
    Database db = await instance.database;
    return await db.delete(table_internal_request);
  }



}
