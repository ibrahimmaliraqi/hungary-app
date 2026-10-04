import 'package:get_it/get_it.dart';
import 'package:hungry_app/core/network/dio_client.dart';
import 'package:hungry_app/features/auth/data/data_source/auth_remote.dart';
import 'package:hungry_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry_app/features/auth/domain/repo/auth_repo.dart';
import 'package:hungry_app/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:hungry_app/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:hungry_app/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:hungry_app/features/cart/data/data_source/cart_data_source.dart';
import 'package:hungry_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:hungry_app/features/cart/domain/repo/cart_repo.dart';
import 'package:hungry_app/features/cart/domain/use_cases/add_to_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/clear_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/delete_item_from_cart_usecase.dart';
import 'package:hungry_app/features/cart/domain/use_cases/get_cart_items_usecase.dart';
import 'package:hungry_app/features/home/data/data_source/home_remote.dart';
import 'package:hungry_app/features/home/data/repos/home_repo_impl.dart';
import 'package:hungry_app/features/home/domain/repo/home_repo.dart';
import 'package:hungry_app/features/home/domain/use_case/get_categories_usecase.dart';
import 'package:hungry_app/features/home/domain/use_case/get_products_usecase.dart';
import 'package:hungry_app/features/home/domain/use_case/get_side_option_usecase.dart';
import 'package:hungry_app/features/home/domain/use_case/get_toppings_usecase.dart';
import 'package:hungry_app/features/order/data/remote/order_remote.dart';
import 'package:hungry_app/features/order/data/repo/order_repo_impl.dart';
import 'package:hungry_app/features/order/domain/repo/order_repo.dart';
import 'package:hungry_app/features/order/domain/use_cases/create_order.dart';
import 'package:hungry_app/features/order/domain/use_cases/create_payment_usecase.dart';
import 'package:hungry_app/features/order/domain/use_cases/get_orders_usecase.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  //Services
  getIt.registerSingleton<DioClient>(DioClient());

  getIt.registerSingleton<AuthRemote>(
    ApiAuthRemoteImpl(dioClient: getIt.get<DioClient>()),
  );
  getIt.registerSingleton<HomeRemote>(
    ApiHomeRemoteImpl(dioClient: getIt.get<DioClient>()),
  );
  getIt.registerSingleton<CartDataSource>(
    ApiCartDataSourceImpl(dioClient: getIt.get<DioClient>()),
  );
  getIt.registerSingleton<OrderRemote>(
    ApiOrderRemoteImpl(dioClient: getIt.get<DioClient>()),
  );

  //repo
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authRemote: getIt.get<AuthRemote>()),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(homeRemote: getIt.get<HomeRemote>()),
  );
  getIt.registerSingleton<CartRepo>(
    CartRepoImpl(cartDataSource: getIt.get<CartDataSource>()),
  );
  getIt.registerSingleton<OrderRepo>(
    OrderRepoImpl(orderRemote: getIt.get<OrderRemote>()),
  );

  //use case
  getIt.registerSingleton<RegisterUserUsecase>(
    RegisterUserUsecase(authRepo: getIt.get<AuthRepo>()),
  );
  getIt.registerSingleton<LoginUserUsecase>(
    LoginUserUsecase(authRepo: getIt.get<AuthRepo>()),
  );
  getIt.registerSingleton<GetProductsUsecase>(
    GetProductsUsecase(homeRepo: getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<GetCategoriesUsecase>(
    GetCategoriesUsecase(homeRepo: getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<GetSideOptionUsecase>(
    GetSideOptionUsecase(homeRepo: getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<GetToppingsUsecase>(
    GetToppingsUsecase(homeRepo: getIt.get<HomeRepo>()),
  );
  getIt.registerSingleton<AddToCartUsecase>(
    AddToCartUsecase(cartRepo: getIt.get<CartRepo>()),
  );
  getIt.registerSingleton<GetCartItemsUsecase>(
    GetCartItemsUsecase(cartRepo: getIt.get<CartRepo>()),
  );
  getIt.registerSingleton<DeleteItemFromCartUsecase>(
    DeleteItemFromCartUsecase(cartRepo: getIt.get<CartRepo>()),
  );
  getIt.registerSingleton<ClearCartUsecase>(
    ClearCartUsecase(cartRepo: getIt.get<CartRepo>()),
  );
  getIt.registerSingleton<UpdateUserUsecase>(
    UpdateUserUsecase(authRepo: getIt.get<AuthRepo>()),
  );
  getIt.registerSingleton<CreateOrderUseCase>(
    CreateOrderUseCase(orderRepo: getIt.get<OrderRepo>()),
  );
  getIt.registerSingleton<GetOrdersUsecase>(
    GetOrdersUsecase(orderRepo: getIt.get<OrderRepo>()),
  );
  getIt.registerSingleton<CreatePaymentUsecase>(
    CreatePaymentUsecase(orderRepo: getIt.get<OrderRepo>()),
  );
}
