import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealthflow/config/router/app_router.dart';
import 'package:wealthflow/core/network/api_client.dart';
import 'package:wealthflow/core/storage/app_storage.dart';
import 'package:wealthflow/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:wealthflow/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:wealthflow/features/auth/domain/repositories/auth_repository.dart';
import 'package:wealthflow/features/auth/domain/usecases/register_usecase.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wealthflow/features/auth/presentation/bloc/auth_event.dart';
import 'package:wealthflow/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:wealthflow/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:wealthflow/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:wealthflow/features/dashboard/domain/usecases/get_net_worth_usecase.dart';
import 'package:wealthflow/features/dashboard/domain/usecases/get_assets_usecase.dart';
import 'package:wealthflow/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:wealthflow/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:wealthflow/features/get_started/presentation/cubit/get_started_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<AppStorage>(() => AppStorage(sl()));
  
  // Register Dio
  sl.registerLazySingleton<Dio>(() => Dio());
  
  // Register ApiClient (which configures Dio with interceptors)
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>(), sl<SharedPreferences>()));

  // Features Initialization
  _initAuth();
  _initDashboard();
  _initSplash();
  _initGetStarted();

  // Router
  sl.registerLazySingleton<AppRouter>(() => AppRouter(sl<AuthBloc>()));

  // Initialize Global Logout Listener
  sl<ApiClient>().onUnauthorized = () {
    sl<AuthBloc>().add(const LogoutRequested());
  };
}

void _initAuth() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<ApiClient>().dio),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );
  sl.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
}

void _initDashboard() {
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(sl<ApiClient>().dio),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl<DashboardRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetNetWorthUseCase>(
    () => GetNetWorthUseCase(sl<DashboardRepository>()),
  );
  sl.registerLazySingleton<GetAssetsUseCase>(
    () => GetAssetsUseCase(sl<DashboardRepository>()),
  );
  sl.registerFactory<DashboardBloc>(
    () => DashboardBloc(sl<GetNetWorthUseCase>(), sl<GetAssetsUseCase>()),
  );
}

void _initSplash() {
  sl.registerFactory<SplashCubit>(() => SplashCubit());
}

void _initGetStarted() {
  sl.registerFactory<GetStartedCubit>(() => GetStartedCubit());
}
