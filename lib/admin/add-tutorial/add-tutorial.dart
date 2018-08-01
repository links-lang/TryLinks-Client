import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:client/admin/update-list-service.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:codemirror/codemirror.dart';

@Component(
  selector: 'add-tutorial',
  templateUrl: 'add-tutorial.html',
  styleUrls: const ['../tutorial-editor.css'],
  directives: const [
    materialDirectives
])

class AddTutorialComponent implements OnInit {
  String title;
  CodeMirror descEditor;
  CodeMirror sourceEditor;
  String errorMsg;
  bool confirmTutorialCreation = false;
  bool validatedInput = false;
  bool success;

  TryLinksService _service;
  UpdateListService _updateListService;

  AddTutorialComponent(this._service, this._updateListService);

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
        querySelector('textarea.tutorial-desc-editor'),
        options: descOptions);
    this.descEditor.setSize('100%', '54vh');

    this.sourceEditor = new CodeMirror.fromTextArea(
        querySelector('textarea.tutorial-source-editor'),
        options: sourceOptions);
    this.sourceEditor.setSize('100%', '54vh');
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
      _updateListService.onUpdateList();
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
