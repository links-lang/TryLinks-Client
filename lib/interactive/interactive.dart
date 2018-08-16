import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_router/angular_router.dart';
import 'package:client/interactive/shell_line.dart';
import 'package:client/interactive/starter.dart';
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
class InteractiveShellPageComponent implements OnInit, OnDestroy {
  @ViewChild('shellInput')
  MaterialInputComponent shellInput;
  List<ShellLine> allLines = [];
  String currentCmd = '';
  IO.Socket socket;
  String inputPrompt = ' links> ';
  bool showLoadingDialog = false;
  TryLinksService _service;
  Router _router;
  int introIndex;

  InteractiveShellPageComponent(this._router, this._service);

  @override
  Future ngOnInit() async {
    showLoadingDialog = true;
    String socketPath = await _service.startInteractiveMode();

    if (socketPath == null) {
//      print('logging out.');
      _router.navigate(['Welcome']);
      return;
    }

    String namespace = TryLinksService.serverAddr + socketPath;
//    print('connecting to $namespace');
    socket = IO.io(namespace);
    socket.on('server', (_) => print('handshake'));

    socket.on('connect_error', (error) => print(error.toString()));
    socket.on('connect', (_) {
//      print('connected to $namespace');
      introIndex = 0;
      socket.on('shell output', (output) {
        if (showLoadingDialog) _showNewIntro();
        showLoadingDialog = false;
        allLines.add(new ShellLine(LineType.stdout, output));
        scrollToBottom();
      });

      socket.on('shell error', (error) {
        // TODO
        // When the raw error message is sent, it often is not printed as
        // It starts with <stdin> which DART's default sanitizer does not allow
        // The custom sanitizer should be implemented,
        // Yet for now <stdin> is simply removed
        String sanitizedError = error.replaceFirst(new RegExp(r"<stdin>(:\d+(: )?)?"), '');
        allLines.add(new ShellLine(LineType.stderr, sanitizedError));
        scrollToBottom();
      });
    });
  }

  void onInputChange() {
    scrollToBottom();
    print(shellInput.focused);
    if (!shellInput.focused) return;

    currentCmd += "\n" + shellInput.inputText;
    if (currentCmd.trim() == 'skip intro;') {
      allLines.add(new ShellLine(LineType.stdout,
          "Syntax introduction series disabled. To enable, please refresh the page."));
      introIndex = starterTutorialDesc.length;
      currentCmd = '';
    } else if (currentCmd.trim() == 'next tip;') {
      _showNewIntro();
      currentCmd = '';
    } else if (currentCmd.trim() == 'go back;') {
      introIndex = introIndex > 1 ? introIndex - 2 : 0;
      _showNewIntro();
      currentCmd = '';
    } else {
      allLines.add(new ShellLine(LineType.userInput, shellInput.inputText));
      if (shellInput.inputText.endsWith(";")) {
        for (String cmd in currentCmd.split(";")) {
//          print('sending to socket: $cmd;');
          socket.emit('new command', cmd + ";");
        }
        inputPrompt = 'links >';
        currentCmd = '';
      } else {
        inputPrompt = '...... ';
      }
    }
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

  void _showNewIntro() {
    if (introIndex < starterTutorialDesc.length) {
      allLines
          .add(new ShellLine(LineType.intro, starterTutorialDesc[introIndex]));
      introIndex++;
    }
  }
}
