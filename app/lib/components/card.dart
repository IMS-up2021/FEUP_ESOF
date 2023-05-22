import 'package:flutter/material.dart';
import 'package:geneio/pages/family_member_info.dart';
import 'package:geneio/pages/genetic.dart';

class MyCard extends StatelessWidget {
  final String text1;
  final String imagePath1;
  final String text2;
  final String imagePath2;
  final Widget page1;
  final Widget page2;

  const MyCard({
    super.key,
    required this.text1,
    required this.imagePath1,
    required this.text2,
    required this.imagePath2,
    required this.page1,
    required this.page2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page1),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.asset(
                    imagePath1,
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff71935D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      text1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page2),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Image.asset(
                    imagePath2,
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff71935D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      text2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
