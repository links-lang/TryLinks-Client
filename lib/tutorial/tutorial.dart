import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:client/tutorial/tutorial_text.dart';
import 'package:markdown/markdown.dart';
import 'package:codemirror/codemirror.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@Component(
  selector: 'tutorial-page',
  templateUrl: 'tutorial.html',
  styleUrls: const [
    'tutorial.css',
    'markdown.css'
  ],
  directives: const[
    materialDirectives,
    DeferredContentDirective,
    NgFor,
    NgIf,
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
  IO.Socket socket;

  TutorialPageComponent(this._service, this._router, this._routeParams, this._sanitizer);

  List<String> get headers => tutorialHeaders;

  SafeResourceUrl get renderUrl => _sanitizer.bypassSecurityTrustResourceUrl('http://localhost:8000');

  int port;

  String compileError = r'''
  *** Parse error: tmp/nickwu_source.links:12

    servePages()
               ^''';

  Future onCompile() async {
    print('You want to compile the current Links program');
    await _service.saveTutorialSource(this.id, this.editor.getDoc().getValue());
    print("saved.");

    String socketPath = await _service.compileAndDeploy();

    if (socketPath == null) {
      print('cannot find a socket path to connect to');
      return;
    }

    compileError = "";
    String namespace = 'http://localhost:5000' + socketPath;
    print('connecting to $namespace');
    socket = IO.io(namespace);
    socket.on('connect', (_) {
      print('connected to $namespace');

      socket.on('compiled', (port) {
        print(port);
        this.port = port;
      });

      socket.on('compile error', (error) {
        print(error);
        this.compileError = error;
        this.port = null;
      });

      socket.on('shell error', (error) {
        print(error);
        this.compileError = error;
        this.port = null;
      });

      socket.emit('compile');
    });
  }

  @override
  ngOnInit() async {
    var _id = _routeParams.get('id');
    this.id = int.parse(_id ?? '', onError: (_) => null);
    // TODO: add check for id not null.
    print(this.id);
    querySelector('div.tl-tutorial-main-desc')
        .setInnerHtml(markdownToHtml(tutorialDescs[id-1]));

    Map options = {
      'mode':  'OCaml',
      'theme': 'monokai',
      'lineNumbers': true,
      'autofocus': true,
    };

    this.editor = new CodeMirror.fromTextArea(
        querySelector('textarea.tl-tutorial-main-editor'), options: options);
    this.editor.setSize('100%', '80%');

    String source = await _service.getTutorialSource(this.id);
    this.editor.getDoc().setValue(source);
  }
}
