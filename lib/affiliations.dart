import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_data/homeScreen.dart';

class StudentAffiliations extends StatefulWidget {
  final String email;

  StudentAffiliations({required this.email});

  @override
  _StudentAffiliationsState createState() => _StudentAffiliationsState();
}

class _StudentAffiliationsState extends State<StudentAffiliations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Student Affiliations'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .where('email', isEqualTo: widget.email)
            .snapshots()
            .asyncMap((QuerySnapshot<Map<String, dynamic>> query) async {
          return await query.docs.first.reference
              .collection('affiliations')
              .get();
        }),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
             children: snapshot.data!.docs.map((DocumentSnapshot document) {
              String documentID = document.id;
             
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
                  String Subject = data['name'];
              return new Card(
                color: Color.fromARGB(255, 9, 26, 47).withOpacity(0.2),
                child: new Padding(
                  padding: const EdgeInsets.all(15),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              
                              children: <Widget>[
                                 Text(Subject + '     ' + data['Grade1'] +'         '+ data['Grade2']+'         '+ data['Grade3']+'         '+ data['Grade4'],
                                 style: TextStyle(
                                  color: Color.fromARGB(246, 255, 208, 0)
                                 ),),
                              ],
                            ),
                            
                            
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}