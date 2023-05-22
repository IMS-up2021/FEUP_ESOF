import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geneio/components/bottom_nav_bar.dart';
import 'package:geneio/components/my_button.dart';
import 'package:geneio/components/my_textfield.dart';
import 'package:geneio/components/person_model.dart';
import 'package:geneio/pages/family.dart';
import 'package:geneio/pages/settings.dart';

class FamilyMemberInfoPage extends StatefulWidget {
  @override
  _FamilyMemberInfoPageState createState() => _FamilyMemberInfoPageState();
}

class _FamilyMemberInfoPageState extends State<FamilyMemberInfoPage> {
  TextEditingController degreeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController marriageController = TextEditingController();
  TextEditingController deathController = TextEditingController();

  String degree = '';
  String name = '';
  String age = '';
  String occupation = '';
  String birth = '';
  String marriage = '';
  String death = '';

  final _db = FirebaseFirestore.instance;

  createFamilyMember(FamilyMember member) async {
    try {
      DocumentReference newUserRef =
          await _db.collection('Person').add(member.toJson());

      final user = FirebaseAuth.instance.currentUser;
      final userId = user!.uid;

      final personDoc = await FirebaseFirestore.instance
          .collection('Person')
          .doc(userId)
          .get();

      final family = personDoc.get('family');

      await _db.collection('Family').doc(family).update({
        'members': FieldValue.arrayUnion([newUserRef])
      });

      showSuccessAlert(degree); // Show success alert with the entered degree
    } on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      print("Failed with error '${e.code}': ${e.message}");
    }
  }

  void showSuccessAlert(String degree) {
    showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          // Wrap the dialog with WillPopScope to handle Android back button
          onWillPop: () async => false,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AlertDialog(
              backgroundColor: Colors.grey[300],
              alignment: Alignment.center,
              title: Center(
                child: Text(
                  "Success",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 96, 125, 79),
                  ),
                ),
              ),
              content: Text(
                'Successfully added "$degree" to your family.',
                textAlign: TextAlign.center,
              ),
              actions: [
                Center(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff71935D),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                          context); // Pop the dialog from the navigator
                      Navigator.pop(context); //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FamilyPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 147, 93),
        title: Text('Family Member Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //person icon
              Icon(
                Icons.person_add_alt_1,
                size: 100,
                color: Color.fromARGB(255, 113, 147, 93),
              ),
              SizedBox(height: 16),
              MyTextField(
                controller: degreeController,
                hintText: 'Enter Degree of Kinship',
                obscureText: false,
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 113, 147, 93),
                ),
              ),
              SizedBox(height: 16),
              MyTextField(
                controller: nameController,
                hintText: 'Enter Name',
                obscureText: false,
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 113, 147, 93),
                ),
              ),
              SizedBox(height: 16),
              MyTextField(
                controller: ageController,
                hintText: 'Enter Age',
                obscureText: false,
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(255, 113, 147, 93),
                ),
              ),
              SizedBox(height: 16),
              MyTextField(
                controller: occupationController,
                hintText: 'Enter Occupation',
                obscureText: false,
                prefixIcon: Icon(
                  Icons.work,
                  color: Color.fromARGB(255, 113, 147, 93),
                ),
              ),
              SizedBox(height: 16),
              MyTextField(
                controller: birthController,
                hintText: 'Enter Birth Date',
                obscureText: false,
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(255, 113, 147, 93),
                ),
              ),
              SizedBox(height: 16),
              MyTextField(
                controller: marriageController,
                hintText: 'Enter Marriage Date',
                obscureText: false,
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(255, 113, 147, 93),
                ),
              ),
              SizedBox(height: 16),
              MyTextField(
                controller: deathController,
                hintText: 'Enter Death Date',
                obscureText: false,
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(255, 113, 147, 93),
                ),
              ),
              SizedBox(height: 16),

              MyButton(
                onTap: () {
                  setState(() {
                    degree = degreeController.text;
                    name = nameController.text;
                    age = ageController.text;
                    occupation = occupationController.text;
                    birth = birthController.text;
                    marriage = marriageController.text;
                    death = deathController.text;
                  });
                  createFamilyMember(
                    FamilyMember(
                      degree: degree,
                      name: name,
                      age: age,
                      occupation: occupation,
                      birth: birth,
                      marriage: marriage,
                      death: death,
                    ),
                  );
                },
                text: "Submit",
              ),

              SizedBox(height: 24),
              if (degree.isNotEmpty ||
                  name.isNotEmpty ||
                  age.isNotEmpty ||
                  occupation.isNotEmpty ||
                  birth.isNotEmpty ||
                  marriage.isNotEmpty ||
                  death.isNotEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Degree of Kinship: $degree'),
                        SizedBox(height: 8),
                        Text('Name: $name'),
                        SizedBox(height: 8),
                        Text('Age: $age'),
                        SizedBox(height: 8),
                        Text('Occupation: $occupation'),
                        SizedBox(height: 8),
                        Text('Birth Date: $birth'),
                        SizedBox(height: 8),
                        Text('Marriage Date: $marriage'),
                        SizedBox(height: 8),
                        Text('Death Date: $death'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
