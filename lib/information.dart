

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:read_data/detailScreen.dart';
import 'package:read_data/test.dart';
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
           appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 26, 47),
            
            title: const Text('My Information'),),
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
                
                title: Container(
                  
                  child:Text(data['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
                ),), 
                ),
                
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: < Widget > [
                    SizedBox(height: 10,),
                    Text('Grade', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['grade'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Section', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['section'], style: TextStyle(
                      color: Colors.white
                    ), ),
                   
                    SizedBox(height: 10,),
                    Text('LRN', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['LRN'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Birthay', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['birthday'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Email', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['email'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Address', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['address'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Mother Tongue', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['MT'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Gender', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['gender'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Mothers name', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['mother'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Fathers name', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['father'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Guardian', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['guardian'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Relationship with Guardian', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['relationship'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                     Text('Religion', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['religion'], style: TextStyle(
                      color: Colors.white
                    ), ),
                  ],
                ),
  
                trailing: IconButton(
                  icon: Icon(Icons.edit,
                  color: Colors.white,),
                   onPressed: () {
                    print(documentId);
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

  final _GradeController = TextEditingController();

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
   final _BirthdayController = TextEditingController();

   final _GuardianController = TextEditingController();

   



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

  
   late String _initialGuardian;
   

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
        _BirthdayController.text = data['birthday'];
        _GuardianController.text = data['guardian'];
        _LRNController.text = data['LRN'];
        _GradeController.text = data['grade'];

        _initialName = data['name'];
        _initialEmail = data['email'];
        _initialSubject = data['section'];
        _initialAddress = data['address'];
        _initialReligion = data['religion'];
        _initialGuardian = data['guardian'];

    



      
         
       
      }
    });
  }

  Future<void> _updateTeacher() async {
    if (_formKey.currentState!.validate()) {
      try {
        String newName = _nameController.text;
        
        String newAddress = _AddressController.text;

        String newGuardian = _GuardianController.text;

        String newReligion = _ReligionController.text;

        String newSection = _subjectController.text;
        // Only update the fields that have changed
        if (newName != _initialName || newAddress != _initialAddress || newReligion != _initialReligion || newGuardian != _initialGuardian || newSection != _initialSubject) {
          await FirebaseFirestore.instance
              .collection('students')
              .doc(widget.documentId)
              .update({
            if (newName != _initialName) 'name': newName,
            if (newAddress != _initialAddress) 'address': newAddress,
            if (newReligion != _initialReligion) 'religion': newReligion,
            if (newGuardian != _initialGuardian) 'guardian': newGuardian,
            if (newSection != _initialSubject) 'section': newSection,
           
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
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
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
                controller: _BirthdayController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Birthday',
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
                controller: _GradeController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Grade',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a grade';
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
                
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _GuardianController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Guardian',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                
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