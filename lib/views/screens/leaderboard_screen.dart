import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text("Xusanboy Tursunov"),
            trailing: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("10"),
              ),
            ),
          );
        },
      ),
    );
  }
}
