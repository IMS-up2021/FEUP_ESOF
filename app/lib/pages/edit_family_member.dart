import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geneio/components/bottom_nav_bar.dart';
import 'package:geneio/components/my_button.dart';
import 'package:geneio/components/my_textfield.dart';
import 'package:geneio/components/person_model.dart';
import 'package:geneio/pages/family.dart';
import 'package:geneio/pages/settings.dart';

class EditFamilyMemberInfoPage extends StatefulWidget {
  final DocumentSnapshot memberDoc;

  EditFamilyMemberInfoPage({required this.memberDoc});

  @override
  _EditFamilyMemberInfoPageState createState() =>
      _EditFamilyMemberInfoPageState();
}

class _EditFamilyMemberInfoPageState extends State<EditFamilyMemberInfoPage> {
  TextEditingController degreeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController marriageController = TextEditingController();
  TextEditingController deathController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fillTextFields();
  }

  void fillTextFields() {
    degreeController.text = widget.memberDoc.get('degree');
    nameController.text = widget.memberDoc.get('name');
    ageController.text = widget.memberDoc.get('age');
    occupationController.text = widget.memberDoc.get('occupation');
    birthController.text = widget.memberDoc.get('birth');
    marriageController.text = widget.memberDoc.get('marriage');
    deathController.text = widget.memberDoc.get('death');
  }

  updateFamilyMember() async {
    try {
      final db = FirebaseFirestore.instance;

      await db.collection('Person').doc(widget.memberDoc.id).update({
        'degree': degreeController.text,
        'name': nameController.text,
        'age': ageController.text,
        'occupation': occupationController.text,
        'birth': birthController.text,
        'marriage': marriageController.text,
        'death': deathController.text,
      });

      showSuccessAlert(); // Show success alert after updating the family member
    } catch (e) {
      // Handle any errors that occur during the update process
      print('Failed to update family member: $e');
    }
  }

  void showSuccessAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
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
            'Family member details updated successfully.',
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
                      context); // Pop the dialog from the navigator/ Pop the current page
                },
                child: const Text(
                  "OK",
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
        title: Text('Edit Family Member'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //person icon
              Icon(
                Icons.person,
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
                  updateFamilyMember(); // Call the updateFamilyMember method
                  Navigator.pop(context); // Pop the current page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FamilyPage()),
                  );
                },
                text: "Update",
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
