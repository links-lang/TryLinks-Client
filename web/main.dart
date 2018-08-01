import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:http/browser_client.dart';

import 'package:client/app_component.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:client/admin/update-list-service.dart';

void main() {
  bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    provide(LocationStrategy, useClass: HashLocationStrategy),
    provide(BrowserClient,
        useFactory: () => new BrowserClient()..withCredentials = true,
        deps: []),
    TryLinksService,
    UpdateListService
  ]);
}
