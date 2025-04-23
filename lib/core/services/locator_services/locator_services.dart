import 'package:get_it/get_it.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';

final getIt = GetIt.instance;

Future<void> locatorServices() async {
  final localStorageService = await LocalStorageService.init();
  getIt.registerSingleton<LocalStorageService>(localStorageService);
  getIt.registerLazySingleton<SignInCubit>(() => SignInCubit(getIt<LocalStorageService>()));
}