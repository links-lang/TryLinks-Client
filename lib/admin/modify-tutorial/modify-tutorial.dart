import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:codemirror/codemirror.dart';

@Component(
  selector: 'modify-tutorial',
  templateUrl: 'modify-tutorial.html',
  styleUrls: const ['modify-tutorial.css'],
  providers: const [overlayBindings],
  directives: const [
    materialDirectives
])

class ModifyTutorialComponent implements OnInit {

  @override
  Future ngOnInit()async {

  }

}