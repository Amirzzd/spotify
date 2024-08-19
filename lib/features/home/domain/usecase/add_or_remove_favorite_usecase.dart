import 'package:spotify/common/error_handling/data_state.dart';
import 'package:spotify/core/config/usecase.dart';
import 'package:spotify/features/home/domain/repositroy/song_repository.dart';
import 'package:spotify/locator.dart';

class AddOrRemoveFavoriteUsecase implements UseCase<DataState,String>{
  @override
  Future<DataState<dynamic>> call({required String param}) async {
    return await locator<SongRepository>().addOrRemoveFavoriteSongsRepository(param);
  }

}