import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void login(user, pwd) async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url = Uri.http('localhost:8080', '/api/v1/login');
  var body = convert.jsonEncode({'user': user, 'pwd': pwd});

  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
  }
}
