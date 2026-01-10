import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_finder_app/core/const/api.dart';
import 'package:recipe_finder_app/core/const/local.dart';
import 'package:recipe_finder_app/data/repo/recipe.dart';
import 'package:recipe_finder_app/data/source/local/hive.dart';
import 'package:recipe_finder_app/data/source/remote/api.dart';
import 'package:recipe_finder_app/presentation/bloc/recipe_list/recipe_list_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  // open boxes
  await Hive.openBox(LocalConst.cache);
  await Hive.openBox(LocalConst.favs);
  await Hive.openBox(LocalConst.categories);
  await Hive.openBox(LocalConst.areas);

  // single logger
  getIt.registerLazySingleton<Logger>(() => Logger());

  // singular dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => getIt<Logger>().d(obj),
      ),
    );

    return dio;
  });

  // api singal
  getIt.registerLazySingleton<MealApiService>(
    () => MealApiService(dio: getIt<Dio>()),
  );

  // hive
  getIt.registerLazySingleton<HiveService>(() => HiveService());

  // Repository
  getIt.registerLazySingleton<RecipeRepo>(
    () => RecipeRepo(
      api: getIt<MealApiService>(),
      hive: getIt<HiveService>(),
      logger: getIt<Logger>(),
    ),
  );

  // BLoC
  getIt.registerFactory<RecipeListBloc>(
    () => RecipeListBloc(repo: getIt<RecipeRepo>()),
  );
}
