import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_5/cubit/custom_state.dart';
import 'package:task_5/models/products_model.dart';
import 'package:task_5/models/users_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CustomCubit extends Cubit<CustomState> {
  CustomCubit() : super(CustomInitial());

  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      emit(LoginBeginState());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (value.user != null) {
          emit(LoginFinishedState());
        }
      });
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterBeginState());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (value.user != null) {
          saveUserData(
            email: email,
            password: password,
            name: name,
            uid: value.user!.uid,
          ).then((value) {
            if (value) {
              emit(RegisterFinishedState());
            } else {
              emit(RegisterErrorState('Error to save user data !!!'));
            }
          });
        }
      });
    } catch (error) {
      emit(RegisterErrorState(error.toString()));
    }
  }

  Future<bool> saveUserData({
    required String email,
    required String password,
    required String name,
    required String uid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'name': name,
        'uid': uid,
        'image': '',
      }, SetOptions(merge: true));
      return true;
    } catch (error) {
      return false;
    }
  }

  UserModel? user;

  Future<void> getDataFromFirebase() async {
    try {
      emit(ProfileBeginState());
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userA =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      user = UserModel(
          name: userA['name'],
          password: userA['password'],
          email: userA['email'],
          uid: userA['uid'],
          image: userA['image']);
      emit(ProfileFinishedState());
    } catch (error) {
      emit(ProfileErrorState(error.toString()));
    }
  }

  List<Product> products = [];

  Future<void> getData() async {
    try {
      emit(ProductsBeginState());
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var item in jsonResponse['products']) {
          products.add(Product.fromJson(item));
        }
      }
      emit(ProductsFinishedState());
    } catch (error) {
      emit(ProductErrorState());
    }
  }

  ImagePicker picker = ImagePicker();
  File? Image;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Image = File(image.path);
      uploadImage(File(image.path));
      emit(ChooseImageState());
    } else {
      print('No Image');
    }
  }

  Future<void> uploadImage(File image) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child('usersImages')
          .child('${DateTime.now()}.jpg');

      await ref.putFile(File(image.path));

      String? url;

      url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'image': url,
        },
      );
    } catch (error) {}
  }
}
