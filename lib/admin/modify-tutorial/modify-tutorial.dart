import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/model/links_tutorial.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:codemirror/codemirror.dart';

@Component(
  selector: 'modify-tutorial',
  templateUrl: 'modify-tutorial.html',
  styleUrls: const ['../tutorial-editor.css'],
  directives: const [
    materialDirectives
])

class ModifyTutorialComponent implements OnInit {
  TryLinksService _service;
  final Router _router;
  final RouteParams _routeParams;
  int tutorialId;
  LinksTutorial tutorial = new LinksTutorial(null, null, null, null);
  CodeMirror descEditor;
  CodeMirror sourceEditor;
  String errorMsg;
  bool confirmTutorialUpdate = false;
  bool validatedInput = false;
  bool success;

  ModifyTutorialComponent(this._service, this._router, this._routeParams);

  @override
  Future ngOnInit() async {
    Map descOptions = {
      'mode': 'markdown',
      'autofocus': true,
      'lineWrapping': true,
      'indentWithTabs': true,
    };

    Map sourceOptions = {
      'mode': 'links',
      'theme': 'material',
      'lineNumbers': true,
      'lineWrapping': true,
      'indentWithTabs': true,
    };

    this.descEditor = new CodeMirror.fromTextArea(
      querySelector('textarea.tutorial-desc-editor'),
      options: descOptions);
    this.descEditor.setSize('100%', '54vh');


    this.sourceEditor = new CodeMirror.fromTextArea(
      querySelector('textarea.tutorial-source-editor'),
      options: sourceOptions);
    this.sourceEditor.setSize('100%', '54vh');

    var _id = _routeParams.get('id');
    this.tutorialId = int.parse(_id ?? '', onError: (_) => null);

    this.tutorial = await _service.getTutorial(this.tutorialId);

    if (this.tutorial == null) {
      _router.navigate(['AddTutorial']);
    }
    this.descEditor.getDoc().setValue(this.tutorial.description);
    this.sourceEditor.getDoc().setValue(this.tutorial.source);
  }

  Future onUpdateTutorial() async {
    this.tutorial.description = this.descEditor.getDoc().getValue();
    this.tutorial.source = this.sourceEditor.getDoc().getValue();

    final result = await _service.updateTutorial(this.tutorial);

    if (result != true) {
      this.success = false;
      print('Failed to update a tutorial');
    } else {
      this.success = true;
    }
  }

  void openModal() {
    this.confirmTutorialUpdate = true;
    this.validatedInput = this.tutorial.title != null && this.tutorial.title != '' &&
      this.descEditor.getDoc().getValue() != null &&
      this.descEditor.getDoc().getValue() != '' &&
      this.sourceEditor.getDoc().getValue() != null &&
      this.sourceEditor.getDoc().getValue() != '';
  }
}