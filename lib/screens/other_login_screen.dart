import 'dart:developer';
import '../helper/dialogs.dart';
import 'package:chill_chat_v2/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OtherMethodLogin extends StatefulWidget {
  const OtherMethodLogin({super.key});

  @override
  State<OtherMethodLogin> createState() => _OtherMethodLoginState();
}

class _OtherMethodLoginState extends State<OtherMethodLogin> {
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    Future<void> signInWithGoogle() async {
      try {
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        // Use the user object for further operations or navigate to a new screen.
      } catch (e) {
        print(e.toString());
      }
    }

    late GoogleSignInAccount userObj;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                leading: Image.asset("assets/icon_app.png"),
                elevation: 0.0,
                title: const Text('ChillChat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    )),
              ),
              const SizedBox(height: 50),
              const Text(
                'Welcome to ChillChat',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Sign up to unlock all features',
                style: TextStyle(color: Color.fromRGBO(167, 158, 158, 1)),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        // Dialogs.showProgressBar(context);
                        try {
                          // Kiểm tra xem người dùng đã đăng nhập vào tài khoản Google hay chưa
                          final isSignedIn = await googleSignIn.isSignedIn();
                          if (!isSignedIn) {
                            // Nếu chưa đăng nhập, hiển thị giao diện đăng nhập Google
                            await googleSignIn.signIn().then((userData) {
                              setState(() {
                                userObj = userData!;
                                log(userData.toString());
                              });
                            });
                          } else {
                            // Nếu đã đăng nhập, chỉ đợi một khoảng thời gian ngắn trước khi chuyển đến HomeScreen
                            // await Future.delayed(const Duration(seconds: 3));
                          }
                          Dialogs.showProgressBar(context);
                          await Future.delayed(Duration(seconds: 3));
                          // Đóng progress bar
                          Navigator.of(context).pop();

                          // Chuyển đến HomeScreen
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false,
                          );
                        } catch (error) {
                          print(error);
                          // Xử lý lỗi nếu cần
                        }
                      },
                      icon: const Icon(Icons.g_translate),
                      label: const Text('Continue with Google',
                          style: TextStyle(fontSize: 16)),
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        shadowColor:
                            const MaterialStatePropertyAll(Colors.white10),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(14)),
                        iconSize: const MaterialStatePropertyAll(28),
                        shape: const MaterialStatePropertyAll(
                          ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.black26),
                          ),
                        ),
                        minimumSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width * 0.89, 0),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
                      },
                      icon: const Icon(Icons.facebook),
                      label: const Text('Continue with Facebook',
                          style: TextStyle(fontSize: 16)),
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        shadowColor:
                            const MaterialStatePropertyAll(Colors.white10),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(14)),
                        iconSize: const MaterialStatePropertyAll(28),
                        shape: const MaterialStatePropertyAll(
                          ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.black26),
                          ),
                        ),
                        minimumSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width * 0.89, 0),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_sharp),
                      label: const Text('Continue with ChillChat ',
                          style: TextStyle(fontSize: 16)),
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        shadowColor:
                            const MaterialStatePropertyAll(Colors.white10),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(14)),
                        iconSize: const MaterialStatePropertyAll(28),
                        shape: const MaterialStatePropertyAll(
                          ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.black26),
                          ),
                        ),
                        minimumSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width * 0.89, 0),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Divider(
                      height: 2,
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.grey),
                      softWrap: true,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 1.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vui lòng nhập email';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll(Color(0xFF00CAE0)),
                    shadowColor: const MaterialStatePropertyAll(Colors.white10),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    iconSize: const MaterialStatePropertyAll(28),
                    shape: const MaterialStatePropertyAll(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.black26),
                      ),
                    ),
                    minimumSize: MaterialStatePropertyAll(
                      Size(MediaQuery.of(context).size.width * 0.89, 0),
                    ),
                  ),
                  child: const Text('Continue',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'By clicking Continue, you accept the Terms of Use and Privacy Policy.',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
