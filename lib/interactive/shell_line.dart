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
      case LineType.USER_INPUT:
        return 'white';
      case LineType.STDOUT:
        return 'greenyellow';
      case LineType.STDERR:
        return 'red';
      default:
        return '';
    }
  }
}

enum LineType {
  USER_INPUT,
  STDOUT,
  STDERR,
}

class ShellLine {
  LineType type;
  String line;

  ShellLine(this.type, this.line);
}