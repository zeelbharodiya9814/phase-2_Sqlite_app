import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../modal_class/product_class.dart';
import '../modal_class/product_data.dart';
import '../views/screens/list_res.dart';

class DBHelper {
  DBHelper._();

  static final dbHelper = DBHelper._();


   Database? db;

  Future<void> initDB() async {
    // String df = await getDatabasesPath();
    // String dm = await getDatabasesPath();

    String directory = await getDatabasesPath();
    String path = join(directory, "demo.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE IF NOT EXISTS products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT, price INTEGER,  quantity INTEGER);");
        });
  }

  // Future<void> insertData() async {
  //   initDB();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isStored = prefs.getBool('ALL_PRO') ?? false;
  //
  //   if (isStored == false) {
  //     for (int i = 0; i < allProduct.length; i++) {
  //       Product data = allProduct[i];
  //       String query =
  //           "INSERT INTO products(id, name, category,  quantity, price) VALUES(?, ?, ?, ?, ?);";
  //       List args = [
  //         data.id,
  //         data.name,
  //         data.category,
  //         data.quntity,
  //         data.price,
  //       ];
  //       await db!.rawInsert(query, args);
  //     }
  //     prefs.setBool('ALL_PRO', true);
  //     print('--------------------------');
  //     print('record Inserted');
  //     print('--------------------------');
  //   }
  // }


  Future<int?> insertData({required String name,required String category,required int price,required int quantity}) async {
    await initDB();

    String query = "INSERT INTO products(name,category,price,quantity) VALUES(?, ?, ?, ?);";
    List args = [name,category,price,quantity];

    int res = await db!.rawInsert(query, args);

    print("Table inserted Successfully $res");

    return res;
  }


  // Future<List<Product>> fetchData() async {
  //
  //   await initDB();
  //
  //   String query = "SELECT * FROM products";
  //
  //   List<Map<String, dynamic>> data = await db!.rawQuery(query);
  //   List<Product> allData =
  //   data.map((e) => Product.fromMap(data: e)).toList();
  //   return allData;
  // }


  Future<List<Product>> fetchData() async {

    await initDB();

    String query = "SELECT * FROM products;";

    List<Map<String , dynamic>> data = await db!.rawQuery(query);

    List<Product> allData = data.map((e) => Product.fromMap(data: e)).toList();

    print("Table fetched Successfully $allData");

    return allData;
  }




  Future<void> updateData({required int id, required int quantity}) async {

    await initDB();

    int? a = await db!.rawUpdate(
        "Update products SET quantity = ? WHERE id = ?",
        [quantity, id]);
  }


  JsonData1() async {
    String jsonData = await rootBundle.loadString("assets/json/data.json");

    List res = jsonDecode(jsonData);

    List allPro = res.map((e) => Product.fromMap(data: e)).toList();

    allPro.map((e) =>
        DBHelper.dbHelper.insertData(name: e.name, category: e.category, price: e.price, quantity: e.quntity))
        .toList();
  }

}






















// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../modal_class/product_class.dart';
//
//
// class DBHelper {
//   DBHelper._();
//
//   static final DBHelper dbHelper = DBHelper._();
//
//   Database? db;
//
//
//   Future<void> initDB() async {
//     String directory = await getDatabasesPath();
//     String path = join(directory, "demo.db");
//
//     db = await openDatabase(
//         path,
//         version: 1,
//         onCreate: (Database db,int version) async {
//
//           String query = "CREATE TABLE IF NOT EXISTS Products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT, price INTEGER,quantity INTEGER);";
//
//           await db.execute(query);
//
//           print("Table Create Successfully");
//         }
//     );
//   }
//
//   Future<int>insert({required Product data}) async {
//
//     await initDB();
//
//     String query = "INSERT INTO Products(name , category , price, quantity) VALUES(?, ?, ?, ?);";
//     List args = [data.name, data.category, data.price,data.quntity];
//
//     int res = await db!.rawInsert(query, args);
//
//     return res;
//
//   }
//
//   Future<List<Product>> fetchallProduct() async {
//
//     await initDB();
//
//     String query = "SELECT * FROM Products;";
//
//     List<Map<String , dynamic>> allRecords = await db!.rawQuery(query);
//
//     List<Product> allProduct = allRecords.map((e) => Product.fromMap(data: e)).toList();
//
//     return allProduct;
//   }
//
//
//   Future<int> delete({required int id}) async {
//
//     await initDB();
//
//     String query = "DELETE FROM Products WHERE id = ?;";
//     List args = [id];
//
//     int res = await db!.rawDelete(query, args); // returns total numbers of deleted records
//
//     return res;
//
//   }
//
//   Future<int> update({required Product data,required int id}) async {
//
//     await initDB();
//
//     String query = "UPDATE Products SET name=?,category=?, price=? WHERE id=?;";
//
//     List args = [data.name,data.category,data.price,id];
//
//     int res = await db!.rawUpdate(query, args);
//
//     return res;
//   }
//
//   // Future<List<Product>> fetchSearchProducts({required String data}) async {
//   //
//   //   await initDB();
//   //
//   //   String query = "SELECT * FROM Products WHERE name LIKE '$data%'";
//   //
//   //   List<Map<String , dynamic>> allRecords = await db!.rawQuery(query);
//   //
//   //   List<Product> allProduct = allRecords.map((e) => Product.fromMap(data: e)).toList();
//   //
//   //   return allProduct;
//   // }
// }