import 'package:angular/angular.dart';

@Component(
  selector: 'interactive-shell',
  styleUrls: const ['interactive.css'],
  templateUrl: 'interactive.html',
  directives: const [NgFor],
)
class InteractiveShellPageComponent {

  List<String> allLines = const [
    "var a = 2;",
    "var b = 2;",
    "a+b;",
    "4",
  ];

}