import 'dart:convert';
import 'dart:developer';

import 'package:chill_chat_v2/apis/apis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import 'other_login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _nameState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
final listName = [];
final listAvatar = [];
// void shutdownFirestore() async {
//   print("Starting Firestore shutdown...");

//   try {
//     print("Terminating Firestore...");
//     await firestore.terminate();
//     print("Clearing Firestore persistence...");
//     await firestore.clearPersistence();
//     print("Firestore shutdown complete.");
//   } catch (e) {
//     print("Error during Firestore shutdown: $e");
//   }
// }

class _nameState extends State<HomeScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> handleLogOutGoogle() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const IconButton(onPressed: null, icon: Icon(Icons.menu)),
        title: const Text('Chats'),
        actions: [
          IconButton(
              onPressed: () {
                _googleSignIn.signOut().then((value) {
                  setState(() {
                    handleLogOutGoogle();
                  });
                }).catchError((e) {});
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OtherMethodLogin(),
                    ));
              },
              icon: const Icon(Icons.vertical_distribute_outlined))
        ],
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: false,
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
                readOnly: true,
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const OtherMethodLogin(),
                  //     ));
                },
                decoration: const InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.only(left: 10),
                    prefixIcon: Icon(Icons.search))),
          ),
        ),
        SliverToBoxAdapter(
            child: SizedBox(
                height: 80,
                child:
                    ListView(scrollDirection: Axis.horizontal, children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                  ),
                ]))),
        // load dât from Firestorefirebase
        StreamBuilder(
          stream: Apis.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              // return Text('No Connection');
              case ConnectionState.waiting:
              // return CircularProgressIndicator();
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  for (var i in data!) {
                    log('data: ${jsonEncode(i.data())}');
                    listName.add(i.data()['name']);
                    listAvatar.add(i.data()['image']);
                  }
                } else if (snapshot.hasError) {
                  log('Error: ${snapshot.error}');
                } else {
                  log('No data');
                }
                break;
              case ConnectionState.done:
                break;
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(20, 20))),
                      child: Row(children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(listAvatar[index]),
                        ),
                        const SizedBox(width: 20),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${listName[index]}'),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'last message',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      DateFormat('MMM d')
                                          .format(DateTime.now()),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    )
                                  ]),
                            ]),
                      ]),
                    )
                  ],
                );
              }, childCount: 3),
            );
          },
        ),
      ]),
    );
  }
}
