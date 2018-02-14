import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_router/angular_router.dart';
import 'package:client/interactive/shell_line.dart';
import 'package:client/loading/loading.dart';
import 'package:client/service/trylinks_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@Component(
  selector: 'interactive-shell',
  styleUrls: const ['interactive.css'],
  templateUrl: 'interactive.html',
  directives: const [
    ShellLineComponent,
    NgFor,
    materialDirectives,
    materialInputDirectives,
    LoadingScreenComponent,
  ],
)
class InteractiveShellPageComponent implements OnInit, OnDestroy{

  @ViewChild('shellInput')
  MaterialInputComponent shellInput;

  List<ShellLine> allLines = [];

  String currentCmd = '';

  IO.Socket socket;

  String inputPrompt = 'links> ';

  bool showLoadingDialog = false;

  TryLinksService _service;
  Router _router;

  InteractiveShellPageComponent(this._router, this._service);

  @override
  Future ngOnInit() async {
    showLoadingDialog = true;
    String socketPath = await _service.startInteractiveMode();

    if (socketPath == null) {
      print('logging out.');
      _router.navigate(['Welcome']);
      return;
    }

    String namespace = TryLinksService.serverAddr + socketPath;
    print('connecting to $namespace');
    socket = IO.io(namespace);
    socket.on('server', (_) => print('handshake'));

    socket.on('connect_error', (error) => print(error.toString()));
    socket.on('connect', (_) {
      print('connected to $namespace');

      socket.on('shell output', (output) {
        showLoadingDialog = false;
        allLines.add(new ShellLine(LineType.stdout, output));
        scrollToBottom();
      });

      socket.on('shell error', (error) {
        allLines.add(new ShellLine(LineType.stderr, error));
        scrollToBottom();
      });
    });
  }

  void onInputChange() {
    scrollToBottom();

    currentCmd += "\n" + shellInput.inputText;
    if (shellInput.inputText.endsWith(";")) {
      print('sending to socket: $currentCmd');
      socket.emit('new command', currentCmd);
      inputPrompt = 'links >';
      currentCmd = '';
    } else {
      inputPrompt = '...... ';
    }
    allLines.add(new ShellLine(LineType.userInput, shellInput.inputText));
    shellInput.inputText = '';
  }

  void scrollToBottom() {
    Element shell = querySelector(".tl-interactive-shell");
    shell.scrollTop = shell.scrollHeight;
  }
  @override
  void ngOnDestroy() {
    if (socket != null) socket.disconnect();
  }

  void gotoDashboard() => _router.navigate(['Dashboard']);

  Future logout() async {
    await _service.logout();
    _router.navigate(['Welcome']);
  }
}
