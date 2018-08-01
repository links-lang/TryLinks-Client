import 'dart:async';
import 'package:angular/angular.dart';

@Injectable()
class UpdateListService {
  StreamController<bool> _updateListController = new StreamController();

  UpdateListService();

  Stream get updateList => _updateListController.stream;

  void onUpdateList() {
    this._updateListController.add(true);
  }
}