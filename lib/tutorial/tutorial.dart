import 'dart:html';
import 'package:angular/angular.dart';
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
  int id;
  CodeMirror editor;

  TutorialPageComponent(this._service, this._router, this._routeParams);

  List<String> get headers => tutorialHeaders;

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
      'theme': 'monokai'
    };

    this.editor = new CodeMirror.fromElement(
        querySelector('div.tl-tutorial-main-editor'), options: options);
  }
}