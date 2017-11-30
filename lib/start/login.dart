import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

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

  void onLogin() {
    print("User $username wants to login with password: $password");
  }

}