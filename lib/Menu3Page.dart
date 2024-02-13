import 'package:flutter/material.dart';

class Menu3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Hero(
          tag: 'menu2',
          child: Text(
            'This is Menu 3',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}
