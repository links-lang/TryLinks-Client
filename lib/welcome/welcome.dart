import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'welcome',
  templateUrl: 'welcome.html',
  styleUrls: const ['welcome.css'],
  directives: const [materialDirectives]
)
class WelcomePageComponent {

  void routeToStartPage() {
    print("should route to Start page");
  }

}