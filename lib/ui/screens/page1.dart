import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_5/data_source/data_source.dart';
import 'package:task_5/ui/widgets/my_widgets.dart';
import 'login_page.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  void initState() {
    if (DataSource.products.isEmpty) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.getData();
        setState(() {
          DataSource.products = data;
          DataSource.isLoading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8f4fc),
        foregroundColor: Colors.black,
        title: const Text('New Products'),
        leading: IconButton(
          onPressed: () async {
            await signOut().then((value) {
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              }
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      backgroundColor: const Color(0xfff8f4fc),
      body: DataSource.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: GridView.builder(
              itemCount: DataSource.products.length,
              itemBuilder: (BuildContext context, int index) {
                return MyWidget(product: DataSource.products[index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            )),
    );
  }
}
