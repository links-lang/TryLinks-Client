import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:validator/validator.dart';

@Component(
    selector: 'login-tab',
    templateUrl: 'login.html',
    styleUrls: const ['login.css'],
    directives: const [
      materialDirectives,
      NgModel,
    ]
)
class LoginTabComponent {

  String username;
  String password;
  String errorMsg;

  TryLinksService _service;
  Router _router;

  LoginTabComponent(this._router, this._service);

  Future onLogin() async {
    // Validate Username.
    if (!isAlphanumeric(username)) {
      errorMsg = "Username cannot have non-alphanumberic characters";
      return null;
    }

    final result = await _service.login(username, password);
    if (result) {
      _router.navigate(['Dashboard']);
    } else {
      errorMsg = 'Incorrect username or password.';
    }
  }

}