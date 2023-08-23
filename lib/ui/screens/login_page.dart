import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_5/cubit/custom_cubit.dart';
import 'package:task_5/cubit/custom_state.dart';
import 'package:task_5/main_layout.dart';
import 'package:task_5/ui/screens/sign_up_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back! Glad to see you, Again!',
                style: TextStyle(color: Color(0xff1e232c), fontSize: 32),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 310,
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff7f8f9),
                      hintText: "Enter your email",
                      hintStyle: const TextStyle(color: Color(0xff909caa)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffeceded))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffeceded)))),
                  style: const TextStyle(color: Color(0xff909caa)),
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email must be not empty';
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 310,
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff7f8f9),
                      hintText: "Enter your password",
                      hintStyle: const TextStyle(color: Color(0xff909caa)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffeceded))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xffeceded)))),
                  style: const TextStyle(color: Color(0xff909caa)),
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password must be not empty';
                    } else if (value.length < 6) {
                      return 'password must be 6 numbers';
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 310,
                        child: BlocConsumer<CustomCubit, CustomState>(
                          listener: (context, state) {
                            if (state is LoginErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    state.error,
                                  ),
                                ),
                              );
                            } else if (state is LoginFinishedState) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const MainPage();
                              }));
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff300046),
                                  alignment: Alignment.center,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  context.read<CustomCubit>().login(
                                        email.text,
                                        password.text,
                                      );
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Or Login with',
                        style: TextStyle(color: Color(0xff858a93)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 103.33,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.facebook,
                                    color: Color(0xff4595ff),
                                    size: 32,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 103.33,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.chrome_reader_mode,
                                    color: Color(0xfffbbb00),
                                    size: 32,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            width: 103.33,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.apple,
                                    color: Colors.black,
                                    size: 32,
                                  )),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Register();
                              }));
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Color(0xfff1473a)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}