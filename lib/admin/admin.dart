import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/admin/add-tutorial/add-tutorial.dart';
import 'package:client/admin/modify-tutorial/modify-tutorial.dart';
import 'package:client/service/trylinks_service.dart';

@Component(
  selector: 'admin',
  templateUrl: 'admin.html',
  styleUrls: const ['admin.css', 'package:angular_components/app_layout/layout.scss.css'],
  directives: const [
    materialDirectives,
    ROUTER_DIRECTIVES,
    NgFor
])
@RouteConfig(const [
  const Route(
    path: '/add-tutorial',
    name: 'AddTutorial',
    component: AddTutorialComponent,
    useAsDefault: true),
  const Route(
    path: '/modify-tutorial/:id',
    name: 'ModifyTutorial',
    component: ModifyTutorialComponent
  )
])

class AdminPageComponent implements OnInit {
  String title;
  String errorMsg;
  bool confirmTutorialCreation = false;
  bool validatedInput = false;
  bool success;
  List headers;

  TryLinksService _service;
  Router _router;

  AdminPageComponent(this._router, this._service);

  @override
  Future ngOnInit() async {
    if (!_service.isAdmin()) {
      _router.navigate(['Dashboard']);
    }
    success = null;
    this.headers = await _service.getTutorialHeaders();

  }

  void openModal() {
    this.confirmTutorialCreation = true;
  }


  // Navigation functions
  void gotoAddTutorial() => _router.navigate(['AddTutorial']);

  void gotoModifyTutorial(int id) => _router.navigate(['ModifyTutorial', {'id': id.toString()}]);

  void gotoDashboard() => _router.navigate(['Dashboard']);

  Future logout() async {
    await _service.logout();
    _router.navigate(['Welcome']);
  }

}