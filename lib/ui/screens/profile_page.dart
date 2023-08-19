import 'package:flutter/material.dart';
import 'package:task_5/data_source/data_source.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    if (DataSource.isLoadingProfile) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.getDataFromFirebase();
        setState(() {
          DataSource.userData = data;
          DataSource.isLoadingProfile = false;
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
          title: const Center(child: Text('Profile')),
        ),
        backgroundColor: const Color(0xfff8f4fc),
        body: DataSource.isLoadingProfile
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Container(
                  width: 325,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xff6f6666),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('First Name',
                          style: TextStyle(
                            color: Color(0xff9a9595)
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(DataSource.userData!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 325,
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xff6f6666),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email',
                      style: TextStyle(
                          color: Color(0xff9a9595)
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(DataSource.userData!.email,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 325,
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xff6f6666),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Password',
                      style: TextStyle(
                          color: Color(0xff9a9595)
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(DataSource.userData!.password,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),

              ],
            )
    );
  }
}
