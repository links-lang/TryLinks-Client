import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:codemirror/codemirror.dart';

@Component(
  selector: 'admin',
  templateUrl: 'admin.html',
  styleUrls: const ['admin.css'],
  providers: const [overlayBindings],
  directives: const [
    materialDirectives
])

class AdminPageComponent implements OnInit {
  String title;
  CodeMirror descEditor;
  CodeMirror sourceEditor;
  String errorMsg;
  bool confirmTutorialCreation = false;
  bool validatedInput = false;
  bool success;

  TryLinksService _service;
  Router _router;

  AdminPageComponent(this._router, this._service);

  @override
  Future ngOnInit() async {
    success = null;

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
        querySelector('textarea.new-tutorial-desc'),
        options: descOptions);
    this.descEditor.setSize('100%', '100%');

    this.sourceEditor = new CodeMirror.fromTextArea(
        querySelector('textarea.new-tutorial-editor'),
        options: sourceOptions);
    this.sourceEditor.setSize('100%', '100%');
  }

  Future onCreateTutorial() async {
    final result = await _service.createTutorial(
        title, this.descEditor.getDoc().getValue(), this.sourceEditor.getDoc().getValue());

    if (result != true) {
      print('Failed to create a new tutorial');
    } else {
      this.title = null;
      this.descEditor.getDoc().setValue('');
      this.sourceEditor.getDoc().setValue('');
    }
  }

  void openModal() {
    this.confirmTutorialCreation = true;
    this.validatedInput = this.title != null && this.title != '' &&
          this.descEditor.getDoc().getValue() != null &&
          this.descEditor.getDoc().getValue() != '' &&
          this.sourceEditor.getDoc().getValue() != null &&
          this.sourceEditor.getDoc().getValue() != '';
  }

}