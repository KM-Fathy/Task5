import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_5/cubit/custom_cubit.dart';
import 'package:task_5/cubit/custom_state.dart';
import 'package:task_5/main_layout.dart';
import 'package:task_5/ui/screens/login_page.dart';

class Register extends StatelessWidget {
  Register({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                      'Icons/back.svg'
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
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
                      hintText: "Username",
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
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name must be not empty';
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
                      hintText: "Email",
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
                      hintText: "Password",
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
                height: 10,
              ),
              SizedBox(
                width: 310,
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xfff7f8f9),
                      hintText: "Confirm password",
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
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: 310,
                child: BlocConsumer<CustomCubit, CustomState>(
                  listener: (context, state) {
                    if (state is RegisterErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        state.error,
                      )));
                    } else if (state is RegisterFinishedState) {
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
                          await context.read<CustomCubit>().signup(
                                name: name.text,
                                email: email.text,
                                password: password.text,
                              );
                        }
                      },
                      child: const Text(
                        'Register',
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
            ],
          ),
        ),
      ),
    );
  }
}
