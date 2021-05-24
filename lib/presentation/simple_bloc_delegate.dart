import 'package:bloc/bloc.dart';
import 'package:totodo/utils/util.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    log('onEvent', event);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
    log('onError', error);
  }

  @override
  void onCreate(Cubit cubit) {
    // log('onCreate', cubit);
    super.onCreate(cubit);
  }

  @override
  void onClose(Cubit cubit) {
    log('onClose', cubit);
    super.onClose(cubit);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // log('onTransition', '');
    log(
        'onTransition',
        '\tcurrentState=${transition.currentState}\n'
            '\tnextState=${transition.nextState}');
  }
}
