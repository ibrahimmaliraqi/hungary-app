import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'side_options_state.dart';

class SideOptionsCubit extends Cubit<SideOptionsState> {
  SideOptionsCubit() : super(SideOptionsInitial());
}
