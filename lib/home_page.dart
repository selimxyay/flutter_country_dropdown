import 'package:flutter/material.dart';
import 'package:flutter_country_dropdown_app/home_page_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageService {
  // list that will store all the country data
  List countries = [];

  // variable that wil store the country that is selected by the user
  String? selectedCountry;

  // the method that fetches the country data will be executed before the home page widget is rendered
  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  // method to fetch the country data
  Future fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      setState(() {
        countries = data.map((country) => country['name']['common']).toList();
      });
    } else {
      throw Exception('Failed to load the country data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) const Center(child: CircularProgressIndicator());
          return Center(
            child: SizedBox(
              width: 400,
              child: DropdownButtonFormField<String>(
                focusColor: Colors.transparent,
                value: selectedCountry,
                decoration: const InputDecoration(labelText: 'Select a country'),
                onChanged: (newValue) {
                  setState(() {
                    selectedCountry = newValue;
                  });
                },
                items: countries.map<DropdownMenuItem<String>>((country) => DropdownMenuItem(
                    value: country,
                    child: Text(country),
                  ),
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
