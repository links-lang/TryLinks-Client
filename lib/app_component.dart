import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:client/welcome/welcome.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [materialDirectives, WelcomePageComponent],
  providers: const [materialProviders],
)
class AppComponent {
}
