import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_data/user_provider.dart';

class Information extends StatefulWidget {

  const Information({ Key? key }) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {

   @override
   Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email;
    context.read<UserProvider>().setEmail(email!);
       return Scaffold(
           appBar: AppBar(title: const Text('My Information'),),
           body: StreamBuilder<QuerySnapshot>(
            
        stream: FirebaseFirestore.instance
            .collection('students')
            .where('email', isEqualTo: email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              String documentId = document.id;
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
             
              return ListTile(
                title: Text(data['name'],
                style: TextStyle(
                  color: Colors.white
                ),),
                subtitle: Text(data['section'],style: TextStyle(
                  color: Colors.white
                ),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                   onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return EditTeacherScreen(documentId: documentId);
                          }));
                          
                          
                          
                        },
                ),
                
              );
            },
          );
        },
      ),
       );
  }
}



class EditTeacherScreen extends StatefulWidget {
  final String documentId;

  EditTeacherScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _EditTeacherScreenState createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _LRNController = TextEditingController();

  //GENDER
  final _GenderController = TextEditingController();
  //MOTHER
  final _MotherController = TextEditingController();
  //FATHER
  final _FatherController = TextEditingController();
  //ADDRESS
  final _AddressController = TextEditingController();
  //RELIGON
  final _ReligionController = TextEditingController();
  //MT
  final _MTController = TextEditingController();
  //EMAIL
   final _EmailController = TextEditingController();




  //BDAY




  //GENDER
   late String _initialGender;
  //MOTHER
  late String _initialMother;
  //FATHER
  late String _initialFather;
  //ADDRESS
  late String _initialAddress;
  //RELIGON
  late String _initialReligion;
  //MT
  late String _initialMT;
  //EMAIL
  late String _initialEmail;

  //BDAY

  late String _initialName;
  late String _initialSubject;
   late String _initialLRN;

  @override
  void initState() {
    super.initState();
    // Retrieve the current teacher data and populate the text fields
    FirebaseFirestore.instance
        .collection('students')
        .doc(widget.documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        _nameController.text = data['name'];
        _subjectController.text = data['section'];
        _GenderController.text = data['gender'];
        _MotherController.text =  data ['mother'];
        _FatherController.text = data['father'];
        _AddressController.text = data['address'];
        _ReligionController.text = data['religion'];
        _MTController.text = data['MT'];
        _EmailController.text = data['email'];


        _LRNController.text = data['LRN'];
        _initialName = data['name'];
       
      }
    });
  }

  Future<void> _updateTeacher() async {
    if (_formKey.currentState!.validate()) {
      try {
        String newName = _nameController.text;
        String newSubject = _subjectController.text;
        // Only update the fields that have changed
        if (newName != _initialName || newSubject != _initialSubject) {
          await FirebaseFirestore.instance
              .collection('students')
              .doc(widget.documentId)
              .update({
            if (newName != _initialName) 'name': newName,
           
          });
        }
        Navigator.pop(context); // Navigate back to the previous screen
      } catch (e) {
        print('Error updating teacher: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _nameController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _subjectController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Section',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _LRNController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'LRN',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _GenderController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Gender',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _MotherController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Mother',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _FatherController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Father',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _AddressController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
               TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _ReligionController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Religion',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _MTController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Mother Tongue',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _EmailController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _updateTeacher();
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color.fromARGB(255, 23, 133, 60), // set the background color
                    content: Text('Successfully Updated'), // set the message text
                    duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                  ),
        );
                },
                
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}