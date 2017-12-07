import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_router/angular_router.dart';
import 'package:client/interactive/shell_line.dart';
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
  ],
)
class InteractiveShellPageComponent implements OnInit{

  @ViewChild('shellInput')
  MaterialInputComponent shellInput;

  List<ShellLine> allLines = [];

  String currentCmd = '';

  IO.Socket socket;

  String inputPrompt = 'links> ';

  TryLinksService _service;
  Router _router;

  InteractiveShellPageComponent(this._router, this._service);

  @override
  ngOnInit() async {

    String socketPath = await _service.startInteractiveMode();

    if (socketPath == null) {
      print('logging out.');
      _router.navigate(['Welcome']);
      return;
    }

    String namespace = 'http://localhost:5000' + socketPath;
    print('connecting to $namespace');
    socket = IO.io(namespace);
    socket.on('connect', (_) {
      print('connected to $namespace');

      socket.on('shell output', (output) {
        print(output);
        allLines.add(new ShellLine(LineType.STDOUT, output));
      });

      socket.on('shell error', (error) {
        print(error);
        allLines.add(new ShellLine(LineType.STDERR, error));
      });
    });
  }

  void onInputChange() {
    // TODO: Add user input validation.

    // TODO: Add scroll to bottom logic.

    currentCmd += "\n" + shellInput.inputText;
    if (shellInput.inputText.endsWith(";")) {
      print('sending to socket: $currentCmd');
      socket.emit('new command', currentCmd);
      inputPrompt = 'links >';
      currentCmd = '';
    } else {
      inputPrompt = '...... ';
    }
    allLines.add(new ShellLine(LineType.USER_INPUT, shellInput.inputText));
    shellInput.inputText = '';
  }
}
