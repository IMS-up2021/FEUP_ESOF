import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geneio/components/my_button.dart';
import 'package:geneio/components/my_textfield.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController deathController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController marriageController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPersonData();
  }

  void fetchPersonData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;

    final personDoc =
        await FirebaseFirestore.instance.collection('Person').doc(userId).get();

    if (personDoc.exists) {
      setState(() {
        nameController.text = personDoc.get('name');
        ageController.text = personDoc.get('age');
        birthController.text = personDoc.get('birth');
        deathController.text = personDoc.get('death');
        familyController.text = personDoc.get('family');
        marriageController.text = personDoc.get('marriage');
        occupationController.text = personDoc.get('occupation');
      });
    }
  }

  void updatePersonData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;

    // Check if the family document exists
    final familyDoc = await FirebaseFirestore.instance
        .collection('Family')
        .doc(familyController.text)
        .get();

    if (!familyDoc.exists) {
      // Create a new family document if it doesn't exist
      await FirebaseFirestore.instance
          .collection('Family')
          .doc(familyController.text)
          .set({});
    }

    await FirebaseFirestore.instance.collection('Person').doc(userId).update({
      'name': nameController.text,
      'age': ageController.text,
      'birth': birthController.text,
      'death': deathController.text,
      'family': familyController.text,
      'marriage': marriageController.text,
      'occupation': occupationController.text,
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Center(
            child: Text(
              'Success',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 96, 125, 79),
              ),
            ),
          ),
          content: Text(
            'Person information updated successfully.',
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xFF71935D),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 147, 93),
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.person,
                size: 100,
                color: Color.fromARGB(255, 113, 147, 93),
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
                controller: familyController,
                obscureText: false,
                hintText: "Family Key",
                prefixIcon: Icon(
                  Icons.family_restroom,
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
                onTap: updatePersonData,
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
