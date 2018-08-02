import 'dart:async';
import 'package:angular/angular.dart';

@Injectable()
class UpdateHeadersService {
  StreamController<bool> _updateListController = new StreamController();

  UpdateHeadersService();

  Stream get updateHeadersStream => _updateListController.stream;

  void onUpdateHeaders() {
    this._updateListController.add(true);
  }
}