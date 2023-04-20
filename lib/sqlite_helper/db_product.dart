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

    String directory = await getDatabasesPath();
    String path = join(directory, "demo.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE IF NOT EXISTS products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category TEXT, price INTEGER,  quantity INTEGER);");
        });
  }

  Future<void> insertData() async {
    await initDB();


      for (int i = 0; i < allProduct.length; i++) {
        ProductData data = ProductData.fromMap(data: allProduct[i]);
        String query =
            "INSERT INTO products(name, category,  quantity, price) VALUES(?, ?, ?, ?);";
        List args = [

          data.name,
          data.category,
          data.quantity,
          data.price,
        ];
        await db!.rawInsert(query, args);
      }

      print('--------------------------');
      print('record Inserted');
      print('--------------------------');
  }



  Future<List<Product>> fetchData() async {

    await initDB();
    await insertData();
   
    String query = "SELECT * FROM products;";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Product> allData = data.map((e) => Product.fromMap(data: e)).toList();

    print("Table fetched Successfully $allData");

    return allData;
  }




  Future<void> updateData({required int id, required int quantity,required String stock}) async {

    await initDB();

    int? a = await db!.rawUpdate(
        "Update products SET quantity = ? WHERE id = ?",
        [quantity, id]);
  }


  Future<int> delete({required int id}) async {

    await initDB();

    String query = "DELETE FROM products WHERE id = ?;";
    List args = [id];

    int res = await db!.rawDelete(query, args); // returns total numbers of deleted records

    return res;

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