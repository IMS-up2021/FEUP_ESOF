// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geneio/pages/about_page.dart';
import 'package:geneio/pages/family_history.dart';
import 'package:geneio/pages/family_member_info.dart';
import 'package:geneio/pages/genetic.dart';
import 'package:geneio/pages/profile.dart';

import '../components/card.dart';
import 'family.dart';

class MenuPage extends StatefulWidget {
  final List cards = [
    //[tittle, subtitle, image]
    [
      "Family",
      "lib/images/family.png",
      FamilyPage(),
      "History",
      "lib/images/history.png",
      FamilyDatesPage(),
    ],
    [
      "Genetic",
      "lib/images/genetic.png",
      GenealogyFormPage(),
      "About",
      "lib/images/about.png",
      AboutPage(),
    ],
  ];

  MenuPage({super.key});
  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff71935D),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => widget.logout(),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                          onPressed: () => widget.logout(),
                        ),
                        Text(
                          "Exit",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('lib/images/geneio.png', height: 60),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cards.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FamilyMemberInfoPage()),
                      );
                    },
                    child: MyCard(
                      text1: widget.cards[index][0],
                      imagePath1: widget.cards[index][1],
                      page1: widget.cards[index][2],
                      text2: widget.cards[index][3],
                      imagePath2: widget.cards[index][4],
                      page2: widget.cards[index][5],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
