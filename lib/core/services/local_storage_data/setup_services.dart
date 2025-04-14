import 'package:get_it/get_it.dart';
import 'package:untitled/core/services/local_storage_data/local_storage_data.dart';
import 'package:untitled/views/sign_in/sign_in_imports.dart';

final getIt = GetIt.instance;

Future<void> setupServices() async {
  await LocalStorageService.initAndRegister();
  getIt.registerFactory<SignInCubit>(() => SignInCubit(getIt<LocalStorageService>()));
}