import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String description;
  final String image;
  final int call;
  final String industry;
  final String email;
  
  Contact({
    required this.name,
    required this.description,
    required this.image,
    required this.call,
    required this.industry,
    required this.email,
  });

  void _onCall() {}

  Widget getCell() {
    return ListTile(
      title: Text(name),
      subtitle: Text(description),
      trailing: Icon(
        Icons.call,
        color: Colors.red.shade900,
      ),
      leading: SizedBox(
        child: Image.asset('assets/$image'),
      ),
      onTap: _onCall,
    );
  }
}
