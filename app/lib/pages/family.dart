import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geneio/components/my_button.dart';
import 'package:geneio/pages/edit_family_member.dart';
import 'package:geneio/pages/family_member_info.dart';
import '../components/family_card.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  User? user;
  String? userId;
  DocumentSnapshot? personDoc;
  DocumentSnapshot? familyDoc;
  List<dynamic> cards = [];

  bool isLoading = true;

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

    //now get the familyDoc field 'members', which is an array of references to Person documents
    List<dynamic> members = familyDoc!.get('members');

    //for each member, get the Person document and add it to the cards list
    members.forEach((element) async {
      final doc = await FirebaseFirestore.instance
          .collection('Person')
          .doc(element.id)
          .get();

      if (doc.get('degree') == doc.get('name')) {
        return;
      }

      setState(() {
        cards.add([
          doc.get('degree') + " - " + doc.get('name').toString().split(" ")[0],
          EditFamilyMemberInfoPage(
            memberDoc: doc,
          ),
        ]);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 147, 93),
        title: const Text('Family'),
      ),
      body: cards.length == 0
          ? Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "No family members added yet!",
                      style: TextStyle(fontSize: 23),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: MyButton(
                      onTap: addFamilyMember, text: "Add Family Member"),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff71935D),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cards.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => cards[index][1]),
                                );
                              },
                              child: FamilyCard(
                                text: cards[index][0],
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: MyButton(
                      onTap: addFamilyMember, text: "Add Family Member"),
                ),
              ],
            ),
    );
  }

  void addFamilyMember() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FamilyMemberInfoPage()),
    );
  }
}
