import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetFlagRequest {
  static Widget getFlag(String? country) {
    if (country != null) {
      String flagApiUrl = 'https://flagsapi.com/$country/flat/64.png';
      return FutureBuilder(
        future: http.get(Uri.parse(flagApiUrl)),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          if (snapshot.hasData) {
            // Parse the response and extract the flag API
            // Example: String flagApi = jsonDecode(snapshot.data.body)['flags']['png'];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 20,
                      height: 20,
                      // Use the flag API to display the flag
                      // Example: Image.network(flagApi),
                      child: Image.network((flagApiUrl))),
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                  Text(country),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Error fetching flag API');
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    } else {
      return const SizedBox(
        child: Text('No flag'),
      );
    }
  }
}
