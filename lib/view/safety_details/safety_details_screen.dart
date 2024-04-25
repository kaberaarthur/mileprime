import 'package:flutter/material.dart';

class SafetyDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Safety Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(254, 185, 20, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'Call an Ambulance',
              details: '0725 225 225 || 0734 225 225',
            ),
            SizedBox(height: 16.0),
            _buildSection(
              title: 'Police Emergency Line',
              details: '999',
            ),
            SizedBox(height: 16.0),
            _buildSection(
              title: 'Contact Support',
              details: '0708 394 945 || support@mile.ke',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, String? details}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.0),
        if (details != null)
          Text(
            details,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SafetyDetailsScreen(),
  ));
}
