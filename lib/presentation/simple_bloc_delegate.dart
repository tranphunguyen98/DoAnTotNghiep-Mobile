import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

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
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition', '');
    // log(
    //     'onTransition',
    //     '\tcurrentState=${transition.currentState}\n'
    //         '\tnextState=${transition.nextState}');
  }

  void log(String name, Object msg) {
    print(
        '===== ${DateFormat("HH:mm:ss-dd MMM, yyyy").format(DateTime.now())}: $name\n'
        '$msg');
  }
}
