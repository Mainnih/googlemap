import 'package:flutter/material.dart';

class HomeScreenCopy extends StatelessWidget {
  const HomeScreenCopy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: false,
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                constraints: BoxConstraints(maxHeight: 40),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(children: const [
                Card(
                  child: Text('data'),
                ),
              ]),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
