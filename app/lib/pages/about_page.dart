import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 147, 93),
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Icon(
                    Icons.info,
                    size: 100,
                    color: Color.fromARGB(255, 113, 147, 93),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Project developed by:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                _buildDeveloperText('Joana Marques', 'up202103346'),
                SizedBox(height: 8),
                _buildDeveloperText('Miguel Rocha', 'up202108720'),
                SizedBox(height: 8),
                _buildDeveloperText('Inês Soares', 'up202108852'),
                SizedBox(height: 8),
                _buildDeveloperText('Miguel Pedrosa', 'up202108809'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperText(String name, String studentId) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 113, 147, 93),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            studentId,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
