import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 250,
              child: DropdownButtonFormField(
                hint: const Text('Select a country'),
                items: const [], 
                onChanged: (value) => '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}