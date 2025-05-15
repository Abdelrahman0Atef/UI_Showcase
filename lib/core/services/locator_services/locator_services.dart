import 'package:get_it/get_it.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/core/services/rest_api_services/rest_api_services.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';
import 'package:untitled/views/sign_up/sign_up_imports.dart';

final getIt = GetIt.instance;

Future<void> locatorServices() async {
  final localStorageService = await LocalStorageService.init();
  getIt.registerSingleton<LocalStorageService>(localStorageService);
  getIt.registerFactory<SignInViewModel>(() => SignInViewModel());
  getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  getIt.registerLazySingleton<RestApiServices>(() => RestApiServices());
}
