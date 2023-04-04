
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:read_data/homeScreen.dart';
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


    

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
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

    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
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



       FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

      // Create a collection reference
      CollectionReference teachersCollectionRef = firestoreInstance.collection('students');

      // Create a document and add it to the collection
      DocumentReference newTeacherDocRef = teachersCollectionRef.doc();
      newTeacherDocRef.set({
        "name": name,
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
         "section": ''
      });

      // Create a subcollection reference for the new document
      CollectionReference coursesCollectionRef = newTeacherDocRef.collection('affiliations');

      // Add a document to the subcollection
      coursesCollectionRef.add({
        'name': 'FILIPINO',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });

      coursesCollectionRef.add({
        'name': 'TLE',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });

       coursesCollectionRef.add({
        'name': 'AP',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });

       coursesCollectionRef.add({
        'name': 'ENGLISH',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });
       coursesCollectionRef.add({
        'name': 'MATH',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });
       coursesCollectionRef.add({
        'name': 'MAPEH',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });
       coursesCollectionRef.add({
        'name': 'ESP',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });
       coursesCollectionRef.add({
        'name': 'SCIENCE',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });
       coursesCollectionRef.add({
        'name': 'MTB',
        'Grade1': '',
        'Grade2': '',
        'Grade3': '',
        'Grade4': '',
      });

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
                  
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 8, left: 20),
                      hintText: 'Name',
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
                  child: TextField(
                    controller: emailController,
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
                  child: TextField(
                    controller: passwordController,
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
                  child: TextField(
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
                  child: TextField(
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
                  child: TextField(
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
              child: TextButton(
                onPressed: () {

                  _createStudent();

                   FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text.trim(), 
                            password: passwordController.text.trim()
                            
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Color.fromARGB(255, 27, 100, 25), // set the background color
                      content: Text('Account Successfully Created'), // set the message text
                      duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                    ),
                  );

                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return LoginScreen();
                  }));
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