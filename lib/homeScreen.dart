import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:read_data/Grades.dart';

import 'package:read_data/detailScreen.dart';
import 'package:read_data/information.dart';
import 'package:read_data/loginScreen.dart';
import 'package:read_data/user_provider.dart';






class FirestoreDataScreen extends StatelessWidget {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('clubs');
  
  
      
  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
   
    

    String? email = FirebaseAuth.instance.currentUser?.email;
    context.read<UserProvider>().setEmail(email!);
    
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String loggedInEmail = email;

    // ignore: unused_element
    Future<String> getStudentDocumentId() async {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('students').where('email', isEqualTo: loggedInEmail).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return '';
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Announcements'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _collectionRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          if (documents == null || documents.isEmpty) {
            return Center(child: Text('No data found'));
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final data = documents[index].data();
              if (data == null) {
                return SizedBox();
              }
              final mapData = data as Map<String, dynamic>;

              Stack(

              );
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(data: mapData),
                    ),
                  );
                },
                child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                borderOnForeground: true,
                
                color: Color.fromARGB(255, 9, 26, 47).withOpacity(0.2),
                  child: ListTile(
                  
                  title: Text(mapData['name'] ?? '',
                  style: TextStyle(

                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      Text(mapData['description'] ?? '',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                      Text(''),
                      Text(mapData['date'] ?? '',
                  style: TextStyle(
                    color: Color.fromARGB(246, 255, 208, 0)
                  ),),
                      
                    ],
                  ) 
                ),
                )
              );
              
            },
          );
        },
      ),
      
      drawer: Drawer(
        
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          children: [

            SizedBox(height: 20),
             ListTileTheme(
              child: ListTile(
                
                leading: Icon(Icons.contact_mail),
                title: Text('${context.watch<UserProvider>().email}'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 30),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.home),
                title: const Text('Home'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.work),
                title: const Text('My Grades'),
                  onTap: () async {
                    
                   
                    String parentDocumentId = await getStudentDocumentId();
                    print('$parentDocumentId');
                    Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage(studentId: parentDocumentId)),
                              );
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('My Information'),
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return Information();
                          }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 520),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.settings),
                title: const Text('Settings'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.logout),
                title: const Text('Log out'),
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return LoginScreen();
                    }));


                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromARGB(255, 255, 0, 0), // set the background color
                        content: Text('Logged out'), // set the message text
                        duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                      ),
                    );


                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
          ],
        ),
      ),
     
    );
  }
}