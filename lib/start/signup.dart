import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:validator/validator.dart';

@Component(
    selector: 'signup-tab',
    templateUrl: 'signup.html',
    styleUrls: const ['signup.css'],
    directives: const [
      materialDirectives,
      NgModel,
    ])
class SignupTabComponent {
  String username;
  String email;
  String password;
  String con_password;

  String usernameErrorMsg;
  String emailErrorMsg;
  String passwordErrorMsg;

  void onSignup() {
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
    if (!valid) return;

    print(
        "User $username with email: $email and password: $password wants to signup");
  }
}
