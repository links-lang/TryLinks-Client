import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
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
  String usernameErrorMsg;

  void onLogin() {
    // Validate Username.
    if (!isAlphanumeric(username)) {
      usernameErrorMsg = "Username cannot have non-alphanumberic characters";
      return;
    }

    print("User $username wants to login with password: $password");
  }

}