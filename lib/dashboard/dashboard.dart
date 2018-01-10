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
class DashboardPageComponent implements OnInit {
  Router _router;
  TryLinksService _service;

  DashboardPageComponent(this._router, this._service);

  @override
  ngOnInit() {
    if (_service.user == null) {
      print('logging out.');
      _router.navigate(['Welcome']);
      return;
    }
  }

  void gotoInteractivePage() {
    _router.navigate(['Interactive']);
  }

  void gotoTutorialPage() {
    _router.navigate(['Tutorial', {"id": _service.user.last_tutorial.toString()}]);
  }

  String get username => _service.user == null ? '' : _service.user.username;
}
