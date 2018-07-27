import 'dart:async';
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
    NgIf
  ],
)
class DashboardPageComponent implements OnInit {
  Router _router;
  TryLinksService _service;
  String username;
  bool isAdmin;

  DashboardPageComponent(this._router, this._service);

  void gotoInteractivePage() {
    _router.navigate(['Interactive']);
  }

  void gotoTutorialPage() {
    _router.navigate([
      'Tutorial',
      {"id": _service.getLastTutorial()}
    ]);
  }

  void gotoAdmin() {
    _router.navigate(['Admin']);
  }

  Future logout() async {
    await _service.logout();
    _router.navigate(['Welcome']);
  }

  @override
  void ngOnInit() {
    this.username = _service.getUsername();
    if (this.username == null) {
      username = 'user';
      _router.navigate(['Welcome']);
    }
    this.isAdmin = _service.isAdmin();
  }
}
