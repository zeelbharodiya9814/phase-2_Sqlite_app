import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phase2_exam/views/screens/list_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal_class/product_class.dart';
import '../../sqlite_helper/db_product.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  // late Future<List<Product>> getAllProduct;







  // forGetVariable() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? ispositionalArrived = prefs.getBool('positionalArrived') ?? false;
  //
  //   (ispositionalArrived == false)
  //       ? DBHelper.dbHelper.JsonData1()
  //       : getAllProduct = DBHelper.dbHelper.fetchData();
  // }

  int z = Random().nextInt(allProduct.length);

  stocksOut() async {
    Future.delayed(const Duration(seconds: 30), () async {
      z;
      await DBHelper.dbHelper.updateData(
        quantity: 0,
        id: z,
        stock: "Out Of Stock",
      );
    });
  }


  // int seconds = 30;

  // Duration? time() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     if (seconds > 0) {
  //       seconds--;
  //
  //       print("==============");
  //       print("time: $seconds");
  //       print("==============");
  //
  //       return time();
  //
  //     } else {
  //
  //       return null;
  //
  //     }
  //   });
  //   return null;
  // }


  int t = 30;

  timeOut() async {
    Future.delayed(
       Duration(seconds: 1),
          () {
        if (t > 0) {
          timeOut();
          setState(() {
            t--;
            // if(t == 0) {
            //   Random().nextInt(allProduct.length);
            //   stocksOut();
            // }
          });
        }
        return null;
      },
    );
  }


  Future? getData;


  // fetch() async {
  //   Future.delayed(
  //       const Duration(seconds: 10),
  //           () => setState(() {
  //         getData = DBHelper.dbHelper.fetchData();
  //       }));
  // }

  @override
  void initState() {
    super.initState();
    getData = DBHelper.dbHelper.fetchData();
    stocksOut();
    timeOut();
    // forGetVariable();
    // fetch();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product",style: TextStyle(
          color: Colors.white,fontSize: 20,
        ),),
        actions: [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 15),
        ],
      ),
      drawer: Drawer(),
      body: FutureBuilder(
        future: getData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            List<Product> data = snapshot.data;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 7,right: 7),
                    child: Card(
                      child: ListTile(
                          isThreeLine: false,
                         leading: Text("${i + 1}"),
                          title: Text(
                            '${data[i].name}\n${data[i].price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          subtitle: Text('${data[i].category}'),
                          trailing:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               InkWell(
                                 onTap: () {
                                   setState(() {
                                     
                                   });
                                 },
                                   child: Icon(Icons.add_shopping_cart)),
                          SizedBox(height: 12,),
                          (data[i].id == z)
                              ? StatefulBuilder(
                            builder: (context, setState) {
                              return Text(t.toString());
                            },
                          )
                              : Text('Out of Stock'),

                         ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}















































































//
//
// import 'dart:async';
//
// import 'package:flutter/material.dart
// import 'package:phase2_exam/modal_class/product_class.dart';';
// import 'package:project_final/Modals/productDB.dart';
// import 'package:project_final/db_helper/db_helper.dart';
// import 'dart:math';
//
// import 'package:project_final/views/res.dart';
//
// import '../../sqlite_helper/db_product.dart';
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   getDB() async {
//     await DBHelper.dbHelper.initDB();
//     await DBHelper.dbHelper.insertRecord();
//   }
//
// //---------
//
//   int a = 2;
//
//   outOfStock() async {
//     Future.delayed(const Duration(seconds: 30), () async {
//       a = Random().nextInt(AllProducts.length);
//
//       await DBHelper.dbHelper.updateRecord(quantity: 0, id: a);
//     });
//   }
//
//   int second = 30;
//
//   Duration? time() {
//     Future.delayed(const Duration(seconds: 1), () {
//       if (second > 0) {
//         second--;
//
//         print("==============");
//         print("time: $second");
//         print("==============");
//
//         return time();
//       } else {
//         return null;
//       }
//     });
//     return null;
//   }
//
//   @override
//   void initState() {
//     outOfStock();
//     getDB();
//     getOut();
//     super.initState();
//   }
//
//   int t = 30;
//
//   getOut() async {
//     Future.delayed(
//       const Duration(seconds: 1),
//           () {
//         if (t > 0) {
//           getOut();
//           setState(() {
//             t--;
//           });
//
//           print(t.toString());
//         }
//         return null;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product List'),
//       ),
//       body: FutureBuilder(
//         future: DBHelper.dbHelper.getAllRecode(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<productDB>? Data = snapshot.data;
//             return ListView.builder(
//                 itemCount: Data!.length,
//                 itemBuilder: (context, i) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                           isThreeLine: true,
//                           leading: Transform.scale(
//                               scale: 1.5,
//                               child: Image.asset('${Data[i].image}')),
//                           title: Text(
//                             '${Data[i].name}',
//                             style: const TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 25),
//                           ),
//                           subtitle: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('${Data[i].category}'),
//                               Text('${Data[i].description}'),
//                             ],
//                           ),
//                           trailing: (Data[i].id == a)
//                               ? StatefulBuilder(
//                             builder: (context, setState) {
//                               return Text(t.toString());
//                             },
//                           )
//                               : Text('Out of Stock')),
//                     ),
//                   );
//                 });
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
