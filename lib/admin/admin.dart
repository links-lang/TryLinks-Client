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
    if (!_service.isAdmin()) {
      _router.navigate(['Dashboard']);
    }

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
    this.descEditor.setSize('100%', '77vh');

    this.sourceEditor = new CodeMirror.fromTextArea(
        querySelector('textarea.new-tutorial-editor'),
        options: sourceOptions);
    this.sourceEditor.setSize('100%', '77vh');
  }

  Future onCreateTutorial() async {
    final result = await _service.createTutorial(
        title, this.descEditor.getDoc().getValue(), this.sourceEditor.getDoc().getValue());

    if (result != true) {
      this.success = false;
      print('Failed to create a new tutorial');
    } else {
      this.success = true;
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

  void gotoDashboard() => _router.navigate(['Dashboard']);

  Future logout() async {
    await _service.logout();
    _router.navigate(['Welcome']);
  }

}