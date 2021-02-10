import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:individual_loading_list/blocs/blocs.dart';

class ListBloc extends Bloc<BaseEvent, BaseState> {
  ListBloc() : super(InitializedState());

  @override
  Stream<BaseState> mapEventToState(
    BaseEvent event,
  ) async* {
    if (event is InitializeEvent) {
      yield* _mapInitializeEventToState();
    }
  }

  Stream<BaseState> _mapInitializeEventToState() async* {
    yield LoadingState();

    await Future.delayed(Duration(seconds: 2));

    List<Map<String, dynamic>> results = [
      {
        'id': 1,
        'title': 'Card 1',
      },
      {
        'id': 2,
        'title': 'Card 2',
      },
      {
        'id': 3,
        'title': 'Card 3',
      },
      {
        'id': 4,
        'title': 'Card 4',
      },
      {
        'id': 5,
        'title': 'Card 5',
      },
    ];

    yield LoadedState(data: results);
  }
}
