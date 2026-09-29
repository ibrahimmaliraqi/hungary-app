import 'package:go_router/go_router.dart';
import 'package:hungry_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:hungry_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/home/presentation/views/product_view.dart';
import 'package:hungry_app/root_view.dart';
import 'package:hungry_app/splash_view.dart';

class AppRouter {
  static const splashView = '/';
  static const login = '/login';
  static const rootView = '/rootView';
  static const register = '/register';
  static const productView = '/productView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: splashView,
        builder: (context, state) => SplashView(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => SignInView(),
      ),
      GoRoute(
        path: rootView,
        builder: (context, state) => RootView(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => SignUpView(),
      ),
      GoRoute(
        path: productView,
        builder: (context, state) {
          final ProductEntity data = state.extra as ProductEntity;
          return ProductDetailsView(
            productEntity: data,
          );
        },
      ),
    ],
  );
}
