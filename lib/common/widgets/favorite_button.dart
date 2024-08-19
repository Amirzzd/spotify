import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/features/home/domain/entities/song_entities.dart';
import 'package:spotify/features/home/presentation/bloc/songs_bloc.dart';

import '../bloc/favorite_button_bloc/favorite_button_bloc.dart';

class FavoriteButton extends StatelessWidget {
  SongEntities song;
  final Function ? function;
  FavoriteButton({super.key,required this.song,this.function});

  @override
  Widget build(BuildContext context) {
    SongsBloc songsBloc = SongsBloc();
    return BlocProvider(
      create: (context) => FavoriteButtonBloc(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<FavoriteButtonBloc,FavoriteButtonState>(
              builder: (context, state) {
                if(state.favoriteButtonStatus is FavoriteButtonInitial){
                  return GestureDetector(
                      onTap: () {
                        context.read<FavoriteButtonBloc>().add(UpdateButton(songId: song.songId!));
                        if(function != null){
                          function!();
                        }
                      },
                      child: song.isFavorite!
                          ? SvgPicture.asset(Assets.outlineLikeDarkTheme,color: Colors.green,)
                          : SvgPicture.asset(context.isDarkMode ? Assets.outlineLikeDarkTheme : Assets.outlineLikeLightTheme)
                  );
                }
                if(state.favoriteButtonStatus is FavoriteButtonSuccess){
                  bool isFavorite = (state.favoriteButtonStatus as FavoriteButtonSuccess).isFavorite ;
                  return GestureDetector(
                      onTap: () {
                        context.read<FavoriteButtonBloc>().add(UpdateButton(songId: song.songId!));
                        songsBloc.add(GetNewSongsEvent());
                      },
                      child: isFavorite
                          ? SvgPicture.asset(Assets.outlineLikeDarkTheme,color: Colors.green,)
                          : SvgPicture.asset(context.isDarkMode ? Assets.outlineLikeDarkTheme : Assets.outlineLikeLightTheme)
                  );
                }
                return Container();
              },
          );
        }
      ),
    );
  }
}
