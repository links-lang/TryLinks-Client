import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'loading-screen',
  templateUrl: 'loading.html',
  styleUrls: const ['loading.css'],
  directives: const [
    materialDirectives,
    ModalComponent,
  ],
)
class LoadingScreenComponent {
  @Input()
  bool showDialog;
}
