import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/admin/add-tutorial/add-tutorial.dart';
import 'package:client/admin/modify-tutorial/modify-tutorial.dart';
import 'package:client/admin/update-list-service.dart';
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

class AdminPageComponent implements OnInit, OnDestroy {
  List headers;

  TryLinksService _tryLinksService;
  Router _router;
  UpdateHeadersService _updateHeadersService;
  StreamSubscription updateHeaderSubscription;

  AdminPageComponent(this._router, this._tryLinksService, this._updateHeadersService);

  @override
  Future ngOnInit() async {
    if (!_tryLinksService.isAdmin()) {
      _router.navigate(['Dashboard']);
    }
    this.headers = await _tryLinksService.getTutorialHeaders();

    this.updateHeaderSubscription =
      _updateHeadersService.updateHeadersStream.listen((data) =>
      _tryLinksService.getTutorialHeaders()
        .then((headers) => this.headers = headers)
        .catchError(() => print("Could not retrieve the list of tutorials"))
    );
  }

  @override
  Future ngOnDestroy() async {
    this.updateHeaderSubscription.cancel();
  }

  // Navigation functions
  void gotoAddTutorial() => _router.navigate(['AddTutorial']);

  void gotoModifyTutorial(int id) => _router.navigate(['ModifyTutorial', {'id': id.toString()}]);

  void gotoDashboard() => _router.navigate(['Dashboard']);

  Future logout() async {
    await _tryLinksService.logout();
    _router.navigate(['Welcome']);
  }

}