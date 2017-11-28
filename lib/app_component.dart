import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/welcome/welcome.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    WelcomePageComponent,
    ROUTER_DIRECTIVES,
  ],
  providers: const [materialProviders],
)
@RouteConfig(const [
  const Route(
      path: '/welcome',
      name: 'Welcome',
      component: WelcomePageComponent,
      useAsDefault: true),
])
class AppComponent {
}
