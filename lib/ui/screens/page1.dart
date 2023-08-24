import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_5/cubit/custom_cubit.dart';
import 'package:task_5/cubit/custom_state.dart';
import 'package:task_5/ui/widgets/my_widgets.dart';
import 'login_page.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff300046),
        foregroundColor: Colors.white,
        title: const Text('Welcome to EGYDYNAMIC'),
        leading: IconButton(
          onPressed: () async {
            await signOut().then((value) {
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              }
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<CustomCubit, CustomState>(
        builder: (context, state) {
          if (state is ProductsBeginState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductsFinishedState ||
              context.read<CustomCubit>().products.isNotEmpty) {
            return SafeArea(
                child: GridView.builder(
              itemCount: context.read<CustomCubit>().products.length,
              itemBuilder: (BuildContext context, int index) {
                return MyWidget(
                    product: context.read<CustomCubit>().products[index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ));
          } else {
            return const Center(
              child: Text('Error !!!'),
            );
          }
        },
      ),
    );
  }
}
