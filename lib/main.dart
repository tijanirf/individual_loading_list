import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:individual_loading_list/blocs/blocs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Individual Loading List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => ListBloc()..add(InitializeEvent()),
        child: ListScreen(),
      ),
    );
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Center(
          child: BlocBuilder<ListBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadedState) {
                return ListView.separated(
                  itemCount: state.data.length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return BlocProvider(
                      create: (context) => ListDetailBloc()
                        ..add(InitializeEvent(data: state.data[index]['id'])),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.data[index]['title']),
                              SizedBox(height: 20),
                              BlocBuilder<ListDetailBloc, BaseState>(
                                builder: (context, state) {
                                  if (state is LoadedState) {
                                    return Text(state.data);
                                  }

                                  return CircularProgressIndicator();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
