import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/features/auth/data/repository/auth_repository_impl.dart';
import 'package:spotify/features/auth/data/source/remote/auth_firebase_service.dart';
import 'package:spotify/features/auth/domain/repository/auth_repositoty.dart';
import 'package:spotify/features/auth/domain/usecases/get_user_use_case.dart';
import 'package:spotify/features/auth/domain/usecases/signin_use_case.dart';
import 'package:spotify/features/auth/domain/usecases/signup_use_case.dart';
import 'package:spotify/features/home/data/repository/song_repository_impl.dart';
import 'package:spotify/features/home/data/source/remote/song_firebase_service.dart';
import 'package:spotify/features/home/domain/repositroy/song_repository.dart';
import 'package:spotify/features/home/domain/usecase/add_or_remove_favorite_usecase.dart';
import 'package:spotify/features/home/domain/usecase/favorite_song_use_case.dart';
import 'package:spotify/features/home/domain/usecase/new_song_use_case.dart';
import 'package:spotify/features/intro/presentation/bloc/theme_cubit.dart';
import 'common/helper/shared_operator.dart';
import 'features/home/domain/usecase/get_favorite_songs_use_case.dart';

final locator = GetIt.instance;

Future<void> setUpGetIt () async {

  locator.registerSingleton<SharedPrefOperator>(SharedPrefOperator(await SharedPreferences.getInstance()));


  ///service locator
  locator.registerSingleton<AuthFireBaseService>(AuthFirebaseServiceImpl());
  locator.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  ///repository
  locator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  locator.registerSingleton<SongRepository>(SongRepositoryImpl());

  ///use case
  locator.registerSingleton<SignUpUseCase>(SignUpUseCase());
  locator.registerSingleton<SignInUseCase>(SignInUseCase());
  locator.registerSingleton<GetUserUseCase>(GetUserUseCase());
  locator.registerSingleton<NewSongUseCase>(NewSongUseCase());
  locator.registerSingleton<IsFavoriteSongUseCae>(IsFavoriteSongUseCae());
  locator.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());
  locator.registerSingleton<AddOrRemoveFavoriteUsecase>(AddOrRemoveFavoriteUsecase());

  ///themeCubit
  locator.registerSingleton<ThemeCubit>(ThemeCubit(locator()));

}
