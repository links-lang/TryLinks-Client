import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/src/security/dom_sanitization_service.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_router/angular_router.dart';
import 'package:client/loading/loading.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:client/tutorial/tutorial_text.dart';
import 'package:markdown/markdown.dart';
import 'package:codemirror/codemirror.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@Component(
  selector: 'tutorial-page',
  templateUrl: 'tutorial.html',
  styleUrls: const [
    'markdown.css',
    'tutorial.css',
  ],
  directives: const [
    materialDirectives,
    DeferredContentDirective,
    NgFor,
    NgIf,
    ROUTER_DIRECTIVES,
    LoadingScreenComponent,
  ],
)
class TutorialPageComponent implements OnInit, OnDestroy {
  final TryLinksService _service;
  final Router _router;
  final RouteParams _routeParams;
  final DomSanitizationService _sanitizer;
  int id;
  CodeMirror editor;
  IO.Socket socket;
  int port;
  String compileError = "";
  bool showLoadingDialog = false;
  SafeResourceUrl renderUrl;

  TutorialPageComponent(
      this._service, this._router, this._routeParams, this._sanitizer);

  List<String> get headers => tutorialHeaders;

//  SafeResourceUrl get renderUrl => _sanitizer
//      .bypassSecurityTrustResourceUrl(TryLinksService.serverURL + ':$port');

  Future navToTutorial(int i) async {
    this.id = i;
    port = null;
    if (socket != null) socket.disconnect();
    await _service.updateUser(lastTutorial: i);
    _router.navigate([
      'Tutorial',
      {"id": i.toString()}
    ]);
  }

  Future onCompile() async {
    showLoadingDialog = true;
//    print('You want to compile the current Links program with id: ${id}');
    await _service.saveTutorialSource(this.id, this.editor.getDoc().getValue());
//    print("saved.");

    String socketPath = await _service.compileAndDeploy();

    if (socketPath == null) {
//      print('cannot find a socket path to connect to');
      return;
    }

    compileError = "";
    if (socket != null && socket.connected) {
//      print('Using existing connection.');
      socket.emit('compile');
    } else {
      String namespace = TryLinksService.serverAddr + socketPath;
//      print('connecting to $namespace');
      socket = IO.io(namespace);
      socket.on('connect', (_) {
//        print('connected to $namespace');

        socket.on('compiled', (port) {
          print(port);
          showLoadingDialog = false;
          this.port = port;
          renderUrl = _sanitizer
              .bypassSecurityTrustResourceUrl(TryLinksService.serverURL + ':$port');
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

//        print('emtting compile message');
        socket.emit('compile');
      });
    }
  }

  @override
  Future ngOnInit() async {
    var _id = _routeParams.get('id');
    this.id = int.parse(_id ?? '', onError: (_) => null);
    if (this.id == null) this.id = 0;
    String description = await _service.getTutorialDesc(this.id);
    if (description == null) {
      description = "The tutorial's description could not be retrieved.";
    }
    querySelector('div.tl-tutorial-main-desc')
        .setInnerHtml(markdownToHtml(description));

    Map options = {
      'mode': 'links',
      'theme': 'material',
      'lineNumbers': true,
      'autofocus': true,
      'lineWrapping': true,
      'indentWithTabs': true,
    };

    this.editor = new CodeMirror.fromTextArea(
        querySelector('textarea.tl-tutorial-main-editor'),
        options: options);
    this.editor.setSize('100%', '75vh');

    String source = await _service.getTutorialSource(this.id);
    if (source == null) _router.navigate(['Welcome']);
    this.editor.getDoc().setValue(source);
  }

  @override
  Future ngOnDestroy() async {
    port = null;
    if (socket != null) socket.disconnect();
    await _service.updateUser(lastTutorial: this.id);
  }

  void gotoInteractive() => _router.navigate(['Interactive']);

  void gotoDashboard() => _router.navigate(['Dashboard']);

  void logout() {
    _service.logout();
    _router.navigate(['Welcome']);
  }
}
