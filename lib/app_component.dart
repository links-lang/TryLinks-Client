import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/dashboard/dashboard.dart';
import 'package:client/interactive/interactive.dart';
import 'package:client/start/start.dart';
import 'package:client/tutorial/tutorial.dart';
import 'package:client/welcome/welcome.dart';
import 'package:client/admin/admin.dart';

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
  const Route(path: '/start', name: 'Start', component: StartPageComponent),
  const Route(
      path: '/dashboard', name: 'Dashboard', component: DashboardPageComponent),
  const Route(
      path: '/interactive',
      name: 'Interactive',
      component: InteractiveShellPageComponent),
  const Route(
      path: '/tutorial/:id',
      name: 'Tutorial',
      component: TutorialPageComponent),
  const Route(path: '/admin', name: 'Admin', component: AdminPageComponent),
])
class AppComponent {}
