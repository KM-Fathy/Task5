import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_5/cubit/custom_cubit.dart';
import 'package:task_5/cubit/custom_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff8f4fc),
        foregroundColor: Colors.black,
        title: const Center(child: Text('Profile')),
      ),
      backgroundColor: const Color(0xfff8f4fc),
      body: BlocBuilder<CustomCubit, CustomState>(builder: (context, state) {
        if (context.read<CustomCubit>().user != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 83,
                        backgroundColor: const Color(0xff848c8e),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: context
                                      .read<CustomCubit>()
                                      .user!
                                      .image ==
                                  ''
                              ? const NetworkImage(
                                  'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg')
                              : NetworkImage(
                                  context.read<CustomCubit>().user!.image),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: const Color(0xff848c8e)),
                              borderRadius: BorderRadius.circular(90)),
                          child: IconButton(
                              onPressed: () {
                                context.read<CustomCubit>().pickImage();
                              },
                              icon: const Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black,
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  Container(
                    width: 310,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffdadada),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'User Name :',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                context.read<CustomCubit>().user!.name,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 310,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffdadada),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Email :',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                context.read<CustomCubit>().user!.email,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 310,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffdadada),
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Password :',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                context.read<CustomCubit>().user!.password,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Text('Error !!!');
        }
      }),
    );
  }
}
