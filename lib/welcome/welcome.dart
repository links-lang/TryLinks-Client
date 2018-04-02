import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';

@Component(
    selector: 'welcome',
    templateUrl: 'welcome.html',
    styleUrls: const ['welcome.css'],
    directives: const [materialDirectives, ROUTER_DIRECTIVES])
class WelcomePageComponent { }
