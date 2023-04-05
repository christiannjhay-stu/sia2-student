import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
        title: Text('My Grades'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Row(
              children: [
                Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 115),
              child: Text(
                '1ST',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 45),
              child: Text(
                '2ND',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 40),
              child: Text(
                '3RD',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 40),
              child: Text(
                '4TH',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 50),
              child: Text(
                'REMARKS',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
              ],
            ),
           
            
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      Subject,
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade1'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade2'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade3'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                  
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade4'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                   
                                ],
                              )
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
            )
          ],
        ),
      )
      
      
    );
  }
}