import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FamilyDatesPage extends StatefulWidget {
  @override
  _FamilyDatesPageState createState() => _FamilyDatesPageState();
}

class _FamilyDatesPageState extends State<FamilyDatesPage> {
  User? user;
  String? userId;
  DocumentSnapshot? personDoc;
  DocumentSnapshot? familyDoc;
  List<dynamic> members = [];
  List<dynamic> cards = [];

  @override
  void initState() {
    super.initState();
    fetchPersonData();
  }

  Future<void> fetchPersonData() async {
    user = FirebaseAuth.instance.currentUser;
    userId = user!.uid;

    personDoc =
        await FirebaseFirestore.instance.collection('Person').doc(userId).get();

    final family = personDoc!.get('family');

    familyDoc =
        await FirebaseFirestore.instance.collection('Family').doc(family).get();

    members = familyDoc!.get('members');

    members.forEach((element) async {
      final doc = await FirebaseFirestore.instance
          .collection('Person')
          .doc(element.id)
          .get();

      if (doc.get('birth') != "") {
        setState(() {
          cards.add(doc.get('name').toString().split(" ")[0] +
              " was born on " +
              doc.get('birth'));
        });
      }

      if (doc.get('death') != "") {
        setState(() {
          cards.add(doc.get('name').toString().split(" ")[0] +
              " died on " +
              doc.get('death'));
        });
      }

      if (doc.get('marriage') != "") {
        setState(() {
          cards.add(doc.get('name').toString().split(" ")[0] +
              " got married on " +
              doc.get('marriage'));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff71935D),
        appBar: AppBar(
          backgroundColor: const Color(0xff71935D),
          title: Text('Family History'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context); // Return to the previous screen
            },
          ),
        ),
        body: cards.length == 0
            ? Center(
                child: Text(
                  "No history added yet",
                  style: TextStyle(fontSize: 23, color: Colors.white),
                ),
              )
            : ListView.builder(
                itemCount: cards.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 96, 126, 79),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromARGB(255, 88, 116, 70),
                        width: 2,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text(
                        cards[index],
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
