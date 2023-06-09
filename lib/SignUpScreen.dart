
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:read_data/loginScreen.dart';

class CreateStudent extends StatefulWidget {
  final TextEditingController _controller = TextEditingController();

  CreateStudent({
    Key ? key
  }): super(key: key);

  @override
  State < CreateStudent > createState() => _CreateStudentState();
}



class _CreateStudentState extends State < CreateStudent > {

    DateTime? _selectedDate;


    final EController = TextEditingController();
    final PController = TextEditingController();


  
    final nameController = TextEditingController();
    final nameController1 = TextEditingController();
    final nameController2 = TextEditingController();
    final nameController3 = TextEditingController();
    

    final usernameController = TextEditingController();
    final GradeController = TextEditingController();
    final GenderController = TextEditingController();
    final GuardianController = TextEditingController();
    final RelationshipController = TextEditingController();
    final MotherController = TextEditingController();
    final FatherController = TextEditingController();
    final AddressController = TextEditingController();
    final ReligionController = TextEditingController();
    final MTController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null && picked != _selectedDate) {
    setState(() {
      _selectedDate = picked;
      DateTime truncatedDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        0,
        0,
        0,
        0,
        0,
      );
      String formattedDateString =
          DateFormat('dd/MM/yyyy').format(truncatedDate);
      widget._controller.text = formattedDateString;
    });
  }
}

  void _createStudent () async {

    final CollectionReference collectionRef = FirebaseFirestore.instance.collection('schoolyear');
    final DocumentSnapshot documentSnapshot = await collectionRef.doc('SchoolYear').get();

    final String Year = documentSnapshot.get('yearStarted');



    String email = EController.text;
    String password = PController.text;


    String name = nameController.text;
    String name1 = nameController1.text;
    String name2 = nameController2.text;
    String name3 = nameController3.text;
    




    String username = usernameController.text;

    String Grade = GradeController.text;
    String gender = GenderController.text;
    String Guardian = GuardianController.text;
    String Relationship = RelationshipController.text;
    String Mother = MotherController.text;
    String Father = FatherController.text;
    String Address = AddressController.text;
    String Religion = ReligionController.text;
    String MT = MTController.text;


    try {

            FirebaseFirestore firestore = FirebaseFirestore.instance;

                      // Create a new student document with the generated ID
              DocumentReference studentRef = firestore.collection('students').doc();

              // Create a batch object
              WriteBatch batch = firestore.batch();

              // Set the student's data
              batch.set(studentRef, {
                "name": name1+" "+name+" "+name2+" "+name3,
                "LRN": username,
                "email": email,
                "password": password,
                "MT": MT,
                "birthday":DateFormat('dd/MM/yyyy').format(_selectedDate ?? DateTime.now()),
                "gender": gender,
                "guardian": Guardian,
                "relationship": Relationship,
                "mother":Mother,
                "father":Father,
                "address":Address,
                "religion":Religion,
                "grade":Grade,
                "section": '',
                "status": 'Not Enrolled',
                "lacking documents":''
              });

              // Add subcollections for each subject
              CollectionReference subjectsRef = studentRef.collection('Subjects');
              List<String> subjects = ['MATH', 'SCIENCE', 'ENGLISH', 'MTB', 'MAPEH', 'ESP', 'AP', 'TLE', 'FILIPINO'];
              for (String subject in subjects) {
                // Use the subject name as the subcollection document ID
                DocumentReference subjectRef = subjectsRef.doc();

                // Set the subject's data
                batch.set(subjectRef, {
                  'name': subject,
                  'Year': Year,
                });

                // Add a new grade document to the subject's 'Grades' collection with a generated ID
                CollectionReference gradesRef = subjectRef.collection('Grades');
                DocumentReference gradeRef = gradesRef.doc();
                
                // Set the grade's data
                batch.set(gradeRef, {
                  'Grade1': '',
                  'Grade2': '',
                  'Grade3': '',
                  'Grade4': '',
                  'Final': '',
                  'Year': Year
                });
              }

              // Commit the batch
              batch.commit().then((value) => print('Grade added successfully'))
                        .catchError((error) => print('Error adding grade: $error'));




    } catch (e) {
      print('Error adding grade: $e');
    }

  }
      
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: const Text('Pre Registration'), ),
      body: ListView(
        children: < Widget > [
          Container(
            padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Pre Registration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ateneo",
                ),
              ),

          ),
          SizedBox(height: 25),
          Center(
            child: Image.asset(
              'assets/images/adduLogo.png',
              width: 200,
              height: 200,
            )
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Last Name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                     
                  )
                )
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  
                  child: TextFormField(
                    controller: nameController1,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'First Name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                     
                  )
                )
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  
                  child: TextFormField(
                    controller: nameController2,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Middle Name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                     
                  )
                )
              ],
            ),
          ),
            Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  
                  child: TextFormField(
                    controller: nameController3,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Extension Name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                     
                  )
                )
              ],
            ),
          ),
          
         
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextFormField(
                    controller: usernameController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'LRN',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                   
                  )
                )
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextFormField(
                    controller: EController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                  
                  )
                )
              ],
            )
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextFormField(
                    controller: PController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                   
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
                    controller: GenderController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Gender',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                  )
                )
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextFormField(
                    controller: GradeController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Grade',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                        return 'Please enter grade';
                      }
                      return null;
                    },
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                  controller: widget._controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'dd/mm/yyyy',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  keyboardType: TextInputType.datetime,
                ),
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextFormField(  
                    controller: GuardianController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Guardian',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                   
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
                    controller: RelationshipController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Relationship with guardian',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
                    controller: MotherController,
                   
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Mothers name',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
                    controller: FatherController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Fathers name',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextFormField(
                    controller: AddressController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Address',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                        return 'Please enter address';
                      }
                      return null;
                    },
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
                    controller: ReligionController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Religion',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                  )
                )
              ],
            ),
          ),
           Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A4859),
                      borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  width: 340,
                  child: TextField(
                    controller: MTController,
                    
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Mother Tongue',
                      hintStyle: TextStyle(
                        color: Colors.white,

                      )
                    ),
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 12, ),
          Center(
            child: Container(
              width: 340,
              height: 60,
              child: ElevatedButton(
                onPressed: () async{


                  
                   
               

                  if(AddressController.text.isEmpty || EController.text.isEmpty || PController.text.isEmpty || nameController.text.isEmpty || nameController1.text.isEmpty 
                  || nameController2.text.isEmpty || usernameController.text.isEmpty || GradeController.text.isEmpty || GenderController.text.isEmpty ||
                  GuardianController.text.isEmpty || RelationshipController.text.isEmpty || MotherController.text.isEmpty || FatherController.text.isEmpty || ReligionController.text.isEmpty||
                   MTController.text.isEmpty){

                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color.fromARGB(255, 255, 51, 0), // set the background color
                            content: Text('Please Complete All Fields'), // set the message text
                            duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                          ),
                        );

                    } else if (AddressController.text.isNotEmpty) {

                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: EController.text.trim(), 
                          password: PController.text.trim()   
                        );
                        _createStudent();
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreen();
                       }));
                        // User created successfully, show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color.fromARGB(255, 27, 100, 25), // set the background color
                            content: Text('Account Successfully Created'), // set the message text
                            duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                          ),
                        );
                        // Navigate to login screen
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return LoginScreen();
                        }));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          // The email address is already in use
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 255, 0, 0), // set the background color
                              content: Text('Email Already in Use'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          );
                        } else {
                          // Some other error occurred
                          print('Error: $e');
                        }
                      } catch (e) {
                        // Some other error occurred
                        print('Error: $e');
                      } 

                    }





                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll < Color > (Color(0xffFBB718)),
                  shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    )
                  )
                ),
                child: Text(
                  'Pre Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "Noopla"
                  ),

                ),
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20),
                child: Text(
                  textAlign: TextAlign.center,
                  'By using APJES you agree to our Term of Service and\nPrivacy Policy.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    letterSpacing: 1.2
                  ),
                )

            ),
          )

        ],
      ),
    );
  }
}