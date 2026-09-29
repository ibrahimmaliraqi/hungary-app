import 'package:bloc/bloc.dart';
import 'package:hungry_app/features/home/domain/entities/category_entity.dart';
import 'package:hungry_app/features/home/domain/use_case/get_categories_usecase.dart';
import 'package:meta/meta.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  final GetCategoriesUsecase getCategoriesUsecase;
  GetCategoriesCubit({required this.getCategoriesUsecase})
    : super(GetCategoriesInitial());
  Future getCategories() async {
    emit(GetCategoriesLoading());
    final res = await getCategoriesUsecase.call();
    res.fold(
      (l) => emit(GetCategoriesFailure(l.message)),
      (r) => emit(GetCategoriesSuccess(r)),
    );
  }
}
