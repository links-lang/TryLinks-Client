import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:client/tutorial/tutorial_text.dart';
import 'package:markdown/markdown.dart';
import 'package:codemirror/codemirror.dart';

@Component(
  selector: 'tutorial-page',
  templateUrl: 'tutorial.html',
  styleUrls: const [
    'tutorial.css'
  ],
  directives: const[
    materialDirectives,
    DeferredContentDirective,
    NgFor,
    ROUTER_DIRECTIVES,
  ],
)
class TutorialPageComponent implements OnInit{

  final TryLinksService _service;
  final Router _router;
  final RouteParams _routeParams;
  final DomSanitizationService _sanitizer;
  int id;
  CodeMirror editor;

  TutorialPageComponent(this._service, this._router, this._routeParams, this._sanitizer);

  List<String> get headers => tutorialHeaders;

  SafeResourceUrl get renderUrl => _sanitizer.bypassSecurityTrustResourceUrl('http://localhost:8000');

  @override
  ngOnInit() {
    var _id = _routeParams.get('id');
    this.id = int.parse(_id ?? '', onError: (_) => null);
    // TODO: add check for id not null.
    print(this.id);
    querySelector('div.tl-tutorial-main-desc')
        .setInnerHtml(markdownToHtml(tutorialDescs[0]));

    Map options = {
      'mode':  'javascript',
      'theme': 'monokai',
      'lineNumbers': true,
    };

    this.editor = new CodeMirror.fromTextArea(
        querySelector('textarea.tl-tutorial-main-editor'), options: options);
    this.editor.setSize('100%', '100%');
  }
}