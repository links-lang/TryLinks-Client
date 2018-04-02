import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:client/start/login.dart';
import 'package:client/start/signup.dart';

@Component(selector: 'start', templateUrl: 'start.html', styleUrls: const [
  'start.css'
], directives: const [
  materialDirectives,
  DeferredContentDirective,
  MaterialTabComponent,
  MaterialTabPanelComponent,
  LoginTabComponent,
  SignupTabComponent,
])
class StartPageComponent {}
