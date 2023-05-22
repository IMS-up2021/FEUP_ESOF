import 'package:flutter/material.dart';

class GenealogyFormPage extends StatefulWidget {
  @override
  _GenealogyFormPageState createState() => _GenealogyFormPageState();
}

class _GenealogyFormPageState extends State<GenealogyFormPage> {
  String? _selectedMotherHairColor;
  String? _selectedMotherEyeColor;
  String? _selectedFatherHairColor;
  String? _selectedFatherEyeColor;
  double _motherHairProbability = 0.0;
  double _motherEyeProbability = 0.0;
  double _fatherHairProbability = 0.0;
  double _fatherEyeProbability = 0.0;

  final List<String> hairColors = ['Brown', 'Blonde', 'Black', 'Red'];
  final List<String> eyeColors = ['Brown', 'Blue', 'Green'];

  void _calculateProbabilities() {
    setState(() {
      // Reset probabilities
      _motherHairProbability = 0.0;
      _motherEyeProbability = 0.0;
      _fatherHairProbability = 0.0;
      _fatherEyeProbability = 0.0;

      // Calculate mother's hair color probability based on user's input
      if (_selectedMotherHairColor == 'Brown') {
        _motherHairProbability = 0.6;
      } else if (_selectedMotherHairColor == 'Blonde') {
        _motherHairProbability = 0.2;
      } else if (_selectedMotherHairColor == 'Black') {
        _motherHairProbability = 0.1;
      } else if (_selectedMotherHairColor == 'Red') {
        _motherHairProbability = 0.3;
      }

      // Calculate mother's eye color probability based on user's input
      if (_selectedMotherEyeColor == 'Brown') {
        _motherEyeProbability = 0.7;
      } else if (_selectedMotherEyeColor == 'Blue') {
        _motherEyeProbability = 0.2;
      } else if (_selectedMotherEyeColor == 'Green') {
        _motherEyeProbability = 0.1;
      }

      // Calculate father's hair color probability based on user's input
      if (_selectedFatherHairColor == 'Brown') {
        _fatherHairProbability = 0.6;
      } else if (_selectedFatherHairColor == 'Blonde') {
        _fatherHairProbability = 0.2;
      } else if (_selectedFatherHairColor == 'Black') {
        _fatherHairProbability = 0.1;
      } else if (_selectedFatherHairColor == 'Red') {
        _fatherHairProbability = 0.3;
      }

      // Calculate father's eye color probability based on user's input
      if (_selectedFatherEyeColor == 'Brown') {
        _fatherEyeProbability = 0.7;
      } else if (_selectedFatherEyeColor == 'Blue') {
        _fatherEyeProbability = 0.2;
      } else if (_selectedFatherEyeColor == 'Green') {
        _fatherEyeProbability = 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genealogy Form'),
        backgroundColor: Color.fromARGB(255, 113, 147, 93),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parent Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Text(
              'Mother',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 113, 147, 93),
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hair Color: ',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<String>(
                  value: _selectedMotherHairColor,
                  onChanged: (value) {
                    setState(() {
                      _selectedMotherHairColor = value;
                    });
                  },
                  items: hairColors.map((String color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Text(
                        color,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Eye Color: ',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<String>(
                  value: _selectedMotherEyeColor,
                  onChanged: (value) {
                    setState(() {
                      _selectedMotherEyeColor = value;
                    });
                  },
                  items: eyeColors.map((String color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Text(
                        color,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Father',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 113, 147, 93),
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hair Color: ',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<String>(
                  value: _selectedFatherHairColor,
                  onChanged: (value) {
                    setState(() {
                      _selectedFatherHairColor = value;
                    });
                  },
                  items: hairColors.map((String color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Text(
                        color,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Eye Color: ',
                  style: TextStyle(fontSize: 18),
                ),
                DropdownButton<String>(
                  value: _selectedFatherEyeColor,
                  onChanged: (value) {
                    setState(() {
                      _selectedFatherEyeColor = value;
                    });
                  },
                  items: eyeColors.map((String color) {
                    return DropdownMenuItem<String>(
                      value: color,
                      child: Text(
                        color,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _calculateProbabilities();
              },
              child: Text(
                'Calculate Probabilities',
                style: TextStyle(fontSize: 20),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 113, 147, 93)),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 113, 147, 93),
                border: Border.all(
                  color: Color.fromARGB(255, 66, 88, 54),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Probabilities',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Mother Hair Color: $_motherHairProbability',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Mother Eye Color: $_motherEyeProbability',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Father Hair Color: $_fatherHairProbability',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Father Eye Color: $_fatherEyeProbability',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
