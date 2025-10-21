import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("Change            $change");
  }

  @override
  void onClose(BlocBase bloc) {
    print("close            $bloc");

    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    print("create            $bloc");

    super.onCreate(bloc);
  }
}
