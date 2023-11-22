

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class DioExampleScreen extends StatefulWidget {
  @override
  _DioExampleScreen createState() => _DioExampleScreen();
}

class _DioExampleScreen extends State {
  final String apiUrl =
      'https://datausa.io/api/data?drilldowns=Nation&measures=Population';
  Map<String, dynamic> data = {};
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['data'];

        setState(() {
          data = {
            'data': responseData.map((item) {
              return {
                'Nation': item['Nation'],
                'Year': item['Year'],
                'Population': item['Population'],
              };
            }).toList(),
          };
        });

        // Show success message
        showSnackBar('Data loaded successfully');
      } else {
        // Show error message
        showSnackBar('Failed to load data. Please try again.');
      }
    } catch (e) {
      // Handle Dio errors
      print('Error: $e');
      // Show error message
      showSnackBar('An error occurred. Please try again.');
    }
  }
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data USA Population'),
      ),
      body: Center(
        child: data.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
          itemCount: data['data'].length,
          itemBuilder: (context, index) {
            final item = data['data'][index];
            return Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Nation: ${item['Nation']}' +
                    '\nYear: ${item['Year']}'),
                subtitle: Text('Population: ${item['Population']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}