import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class HttpExample extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HttpExample> {
  final String apiUrl =
      'https://datausa.io/api/data?drilldowns=Nation&measures=Population';
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Check if data is cached
      DefaultCacheManager cacheManager = DefaultCacheManager();
      FileInfo? fileInfo = await cacheManager.getFileFromCache(apiUrl);

      if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
        // Cached data is available and not expired
        String cachedData = await fileInfo.file.readAsString();
        setState(() {
          data = json.decode(cachedData);
        });
      } else {
        // No cached data or expired, make a network request
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          setState(() {
            data = json.decode(response.body);
          });

          // Save data to cache
          cacheManager.putFile(apiUrl, response.bodyBytes);
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data USA Population Using Http and cashe '),
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
                title: Text('Nation: ${item['Nation']}'+'\nYear: ${item['Year']}'),
                subtitle: Text('Population: ${item['Population']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
