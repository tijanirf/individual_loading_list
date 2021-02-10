import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:individual_loading_list/blocs/blocs.dart';

class ListDetailBloc extends Bloc<BaseEvent, BaseState> {
  ListDetailBloc() : super(InitializedState());

  @override
  Stream<BaseState> mapEventToState(
    BaseEvent event,
  ) async* {
    if (event is InitializeEvent) {
      yield* _mapInitializeEventToState(event.data);
    }
  }

  Stream<BaseState> _mapInitializeEventToState(int id) async* {
    yield LoadingState();

    // This is hardcoded for demo purposes
    if (id == 1 || id == 3 || id == 5) {
      await Future.delayed(Duration(seconds: 2));
    } else {
      await Future.delayed(Duration(seconds: 5));
    }

    yield LoadedState(data: 'This is Detail List Data, ID=$id');
  }
}
