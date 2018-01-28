import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:validator/validator.dart';

@Component(
    selector: 'signup-tab',
    templateUrl: 'signup.html',
    styleUrls: const ['signup.css'],
    directives: const [
      materialDirectives,
      NgModel,
      AutoDismissDirective,
      AutoFocusDirective,
      MaterialButtonComponent,
      MaterialDialogComponent,
      MaterialIconComponent,
      ModalComponent,
    ])
class SignupTabComponent {
  String username;
  String email;
  String password;
  String con_password;

  String usernameErrorMsg;
  String emailErrorMsg;
  String passwordErrorMsg;
  bool showGotoLoginDialog = false;

  TryLinksService _service;

  SignupTabComponent(this._service);

  Future onSignup() async {
    bool valid = true;

    // Validate username
    if (!isAlphanumeric(username)) {
      usernameErrorMsg = "Username cannot have non-alphanumberic characters";
      valid = false;
    }

    // Validate email
    if (!isEmail(email)) {
      emailErrorMsg = "Invalid email address";
      valid = false;
    }

    // Validate password
    if (password != con_password) {
      passwordErrorMsg = "Passwords do not match";
      valid = false;
    }
    if (!valid) return null;

    final result = await _service.signup(username, email, password);
    if (result) {
      username = '';
      email = '';
      password = '';
      con_password = '';
      showGotoLoginDialog = true;
    } else {
      usernameErrorMsg = 'Sign Up Failed. Try Again';
      emailErrorMsg = 'Sign Up Failed. Try Again';
      passwordErrorMsg = 'Sign Up Failed. Try Again';
    }
  }

  void clearErrorMsg() {
    usernameErrorMsg = '';
    emailErrorMsg = '';
    passwordErrorMsg = '';
  }
}
