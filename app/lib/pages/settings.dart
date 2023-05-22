import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationEnabled = true;
  int? _selectedThemeIndex = 0;
  List<String> _themeOptions = ['Light', 'Dark', 'System'];

  void _toggleNotification(bool value) {
    setState(() {
      _notificationEnabled = value;
    });
  }

  void _selectTheme(int? index) {
    setState(() {
      _selectedThemeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 147, 93),
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SwitchListTile(
              title: Text('Enable Notification'),
              value: _notificationEnabled,
              onChanged: _toggleNotification,
            ),
            SizedBox(height: 16),
            Text(
              'Theme',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _themeOptions.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  title: Text(_themeOptions[index]),
                  value: index,
                  groupValue: _selectedThemeIndex,
                  onChanged: _selectTheme,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
