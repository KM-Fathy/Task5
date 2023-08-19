import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_5/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:task_5/models/users_info.dart';



class DataSource {
  static List<Product> products = [];
  static Future<List<Product>> getData() async {
    final response =
    await http.get(Uri.parse('https://dummyjson.com/products'));
    List<Product> productsList = [];

    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (var item in jsonResponse['products']) {
        productsList.add(Product.fromJson(item));
      }
    }
    return productsList;
  }
  static Future<UserModel?> getDataFromFirebase() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      UserModel? user;
      DocumentSnapshot userA =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      user = UserModel(
        name: userA['name'],
        password: userA['password'],
        email: userA['email'],
        uid: userA['uid'],
      );
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  static bool isLoading = true;
  static UserModel? userData;
  static bool isLoadingProfile = true;
}
