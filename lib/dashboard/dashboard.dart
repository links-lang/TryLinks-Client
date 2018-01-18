import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/service/trylinks_service.dart';

@Component(
  selector: 'dashboard-page',
  templateUrl: 'dashboard.html',
  styleUrls: const ['dashboard.css'],
  directives: const [
    materialDirectives,
  ],
)
class DashboardPageComponent {
  Router _router;
  TryLinksService _service;

  DashboardPageComponent(this._router, this._service);

  void gotoInteractivePage() {
    _router.navigate(['Interactive']);
  }

  void gotoTutorialPage() {
    _router.navigate(['Tutorial', {"id": _service.getLastTutorial()}]);
  }

  String get username => _service.getUsername();
}
