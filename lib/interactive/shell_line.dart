import 'package:angular/angular.dart';

@Component(
  selector: 'shell-line',
  styleUrls: const ['shell_line.css'],
  templateUrl: 'shell_line.html',
  directives: const [
    NgStyle,
  ],
)
class ShellLineComponent {
  @Input()
  ShellLine line;

  String getColor() {
    switch (line.type) {
      case LineType.userInput:
        return 'white';
      case LineType.stdout:
        return 'greenyellow';
      case LineType.stderr:
        return 'red';
      default:
        return '';
    }
  }
}

enum LineType {
  userInput,
  stdout,
  stderr,
}

class ShellLine {
  LineType type;
  String line;

  ShellLine(this.type, this.line);
}