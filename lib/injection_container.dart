import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'features/contact_us/data/datasources/remote_datasource.dart';
import 'features/contact_us/data/repositories/contact_us_repository.dart';
import 'features/contact_us/data/repositories/contact_us_repository_impl.dart';
import 'features/contact_us/domain/usecases/send_message_usecase.dart';
import 'features/contact_us/presentation/bloc/contact_us_cubit/contact_us_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /// BLoCs
  sl.registerFactory<ContactUsCubit>(
    () => ContactUsCubit(submitFormUseCase: sl()),
  );

  /// Use Cases
  sl.registerFactory<SubmitFormUseCase>(() => SubmitFormUseCase(sl()));

  /// Repositories
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(remoteDatasource: sl()),
  );

  /// Remote Data sources
  sl.registerLazySingleton<RemoteDatasource>(
    () => RemoteDatasourceImpl(),
  );

  /// Core
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  sl.registerLazySingleton<GlobalKey<NavigatorState>>(() => navigatorKey);
}
