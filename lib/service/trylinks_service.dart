import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:client/model/links_user.dart';
import 'package:http/browser_client.dart';

@Injectable()
class TryLinksService {
  final BrowserClient _http;
  static final _headers = {'Content-Type': 'application/json'};
  static final String _signupUrl = 'http://localhost:5000/api/user/signup';
  static final String _loginUrl = 'http://localhost:5000/api/user/login';
  static final String _updateUserUrl = 'http://localhost:5000/api/user/update';
  static final String _interactiveUrl =
      'http://localhost:5000/api/initInteractive';
  LinksUser user;

  TryLinksService(this._http);

  Future<bool> signup(String username, String email, String password) async {
    try {
      final response = await _http.post(_signupUrl,
          headers: _headers,
          body: JSON.encode({
            'username': username,
            'email': email,
            'password': password,
          }));
      return response.statusCode == 200;
    } catch (e) {
      print("Signup API failed with the following detail:\n");
      print(e.toString());
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await _http.post(_loginUrl,
          headers: _headers,
          body: JSON.encode({
            'username': username,
            'password': password,
          }));
      if (response.statusCode == 200) {
        var result = JSON.decode(response.body);
        print(result);
        user = new LinksUser(result["data"]["username"],
            result["data"]["email"], result["data"]["last_tutorial"]);
      }
      return response.statusCode == 200;
    } catch (e) {
      print("Login API failed with the following detail:\n");
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateUser(String username,
      [String email, String password, int lastTutorial]) async {
    try {
      final response = await _http.post(_updateUserUrl,
          headers: _headers,
          body: JSON.encode({
            'username': username,
            'email': email,
            'password': password,
            'last_tutorial': lastTutorial,
          }));
      if (response.statusCode == 200) {
        user.last_tutorial = lastTutorial;
      }
      return response.statusCode == 200;
    } catch (e) {
      print("Update User API failed with the following detail:\n");
      print(e.toString());
      return false;
    }
  }

  Future<String> startInteractiveMode() async {
    try {
      final response = await _http.get(_interactiveUrl, headers: _headers);
      final socketPath = JSON.decode(response.body)['path'];
      print(socketPath);
      return socketPath;
    } catch (e) {
      print("InteractiveUrl API failed with the following detail:\n");
      print(e.toString());
      return null;
    }
  }
}
