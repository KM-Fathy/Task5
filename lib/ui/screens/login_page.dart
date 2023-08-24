import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                'Welcome back! Glad\nto see you, Again!',
                style: TextStyle(
                    color: Color(0xff1e232c),
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
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
                height: 25,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xffe8ecf4),
                      thickness: 1.5,
                      endIndent: 12,
                    ),
                  ),
                  Text(
                    'Or Login with',
                    style: TextStyle(color: Color(0xff858a93), fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xffe8ecf4),
                      thickness: 1.5,
                      indent: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'Icons/facebook.svg',
                  ),
                  SvgPicture.asset(
                    'Icons/google.svg',
                  ),
                  SvgPicture.asset(
                    'Icons/apple.svg',
                  )
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center ,
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
                      'Register Now',
                      style: TextStyle(color: Color(0xfff1473a)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
