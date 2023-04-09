


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_provider.dart';


class DetailScreen extends StatelessWidget {
  
  final Map < String, dynamic > data;

  const DetailScreen({
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email;
    context.read<UserProvider>().setEmail(email!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text(data['name']),
      ),
      body: ListView(
        children: [
          Center(
          child: Stack(
          children: < Widget > [
            Column(
              children: [
                Padding(padding: EdgeInsets.all(20),
                  
                ),
                Padding(padding: EdgeInsets.all(20),
                  child: Text(data['description'], style: TextStyle(

                    fontSize: 20,
                    color: Colors.white
                  ),)
                ),
                SizedBox(height: 20),
                
                
              ],
            )
          ],
        ),
        )
        ],
      )
    );
  }
}