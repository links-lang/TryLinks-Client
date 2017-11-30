import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'signup-tab',
    templateUrl: 'signup.html',
    styleUrls: const [
      'signup.css'
    ],
    directives: const [
      materialDirectives,
      NgModel,
    ])
class SignupTabComponent {
  String username;
  String email;
  String password;
  String con_password;

  void onSignup() {
    print(
        "User $username with email: $email and password: $password wants to signup");
  }
}
