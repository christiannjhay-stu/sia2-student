import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Test extends StatefulWidget {

  final String studentId;
  Test({Key? key, required this.studentId}) : super(key: key);
  

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  String _selectedValue = '2023';

   @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> subjectsRef =
        FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('Subjects')
            .where('Year', isEqualTo: _selectedValue);

    return Scaffold(
      appBar: AppBar(
        
        title: Text('Grades'),
      ),
      
      body: Stack(
        children: <Widget>[
          Container(
            child:  DropdownButton<String>(
          value: _selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue!;
            });
          },
          items: <String>['2023', '2024', '2025', 'Option 4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
              style: TextStyle(color: Color.fromARGB(255, 255, 208, 0)),),
            );
          }).toList(),
        ),
          ),
          Container(
                child: ElevatedButton(
                onPressed: () async {
              try {


                FirebaseFirestore firestore = FirebaseFirestore.instance;

                // Add a new student document with a generated ID
                DocumentReference studentRef = firestore.collection('students').doc();

                // Set the student's data
                studentRef.set({
                  "name": "test",
                  "LRN": "test",
                  "email": "test",
                  "password": "test",
                  "MT": "test",
                  "birthday":'12/12/2001',
                  "gender": "test",
                  "guardian": "test",
                  "relationship": "test",
                  "mother":"test",
                  "father":"test",
                  "address":"test",
                  "religion":"test",
                    "grade":"test",
                  "section": '',
                  "status": '',
                  "lacking documents":''
                });

               String studentId = studentRef.id;
               CollectionReference subjectsRef = studentRef.collection('subjects');
               List<String> subjects = ['MATH', 'SCIENCE', 'ENGLISH', 'MTB', 'MAPEH', 'ESP', 'AP', 'TLE', 'FILIPINO'];

                for (String subject in subjects) {
                DocumentReference subjectRef = await subjectsRef.add({
                  'name': subject,
                  'year': 2023,
                });
                
                // Add a new grade document to the subject's 'Grades' collection with a generated ID
                CollectionReference gradesRef = subjectRef.collection('Grades');
                DocumentReference gradeRef = gradesRef.doc();
                
                // Set the grade's data
                gradeRef.set({
                  'Grade1': 0,
                  'Grade2': 0,
                  'Grade3': 0,
                  'Grade4': 0,
                });
              }

                print('Grade added successfully');
              } catch (e) {
                print('Error adding grade: $e');
              }
            },
            
            child: Text('Add Grade'),
                  
          ),
          ),
          Padding(padding: EdgeInsets.only(top: 50),
          child: Container(
            child:  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: subjectsRef.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text('No subjects found for this student.');
          }
          

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              QueryDocumentSnapshot<Map<String, dynamic>> subjectDoc =
                  snapshot.data!.docs[index];
          
              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        subjectDoc['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: subjectDoc.reference
                            .collection('Grades')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                gradesSnapshot) {
                          if (gradesSnapshot.hasError) {
                            return Text('Error: ${gradesSnapshot.error}');
                          }

                          if (gradesSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text('Loading...');
                          }

                          if (gradesSnapshot.data == null ||
                              gradesSnapshot.data!.docs.isEmpty) {
                            return Text('No grades found for this subject.');
                          }

                          List<String> gradesList = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade1'] as String,
                                  )
                              .toList();

                               List<String> gradesList1 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade2'] as String,
                                  )
                              .toList();
                                List<String> gradesList2 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade3'] as String,
                                  )
                              .toList();
                                List<String> gradesList3 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade4'] as String,
                                  )
                              .toList();

                          
                          return Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Text(
                                'Grades:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              ...gradesList.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                'Grades:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              ...gradesList1.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                'Grades:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              ...gradesList2.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                'Grades:',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 5),
                              ...gradesList3.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                             
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
          ),
          
          ),
          
        ],
      )
     
      
      
    );
    
  }
}

