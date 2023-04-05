import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Example'),
      ),
      body: Center(
        child: ElevatedButton(
      onPressed: () async {
    try {
      // Add a new document to the Grades collection
      DocumentReference<Map<String, dynamic>> gradeRef =
          FirebaseFirestore.instance
              .collection('students')
              .doc()
              .collection('Subjects')
              .doc()
              .collection('Grades')
              .doc();

      await gradeRef.set({
        'Grade1': 90,
      });

      print('Grade added successfully');
    } catch (e) {
      print('Error adding grade: $e');
    }
  },
  child: Text('Add Grade'),
        
)
      ),
      
    );
  }
}
