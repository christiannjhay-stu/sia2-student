import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String studentId;

  const MyHomePage({Key? key, required this.studentId}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = '2023'; // set default value for dropdown
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> subjectsRef =
        FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('Subjects')
            .where('Year', isEqualTo: _selectedYear);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grades'),
      ),
      body: Column(
        
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: DropdownButton<String>(
            value: _selectedYear,
            items: <String>['2023', '2022', '2021', '2020']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedYear = newValue!;
              });
            },
          )   
          ),
          
          Container(
            child: Text('WORKING'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: subjectsRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot) {
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
          )]
    ));
  }
}