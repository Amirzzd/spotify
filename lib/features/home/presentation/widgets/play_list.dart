import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/favorite_button.dart';
import 'package:spotify/core/config/app_colors.dart';
import 'package:spotify/features/home/domain/entities/song_entities.dart';
import 'package:spotify/features/home/presentation/bloc/songs_bloc.dart';
import 'package:spotify/features/song_player/presentation/song_player_screen.dart';

import '../../../../core/config/assets.dart';

class PlayListWidget extends StatelessWidget {
  const PlayListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongsBloc()..add(GetPlayListEvent()),
      child: BlocBuilder<SongsBloc,SongState>(
        builder: (context, state) {
          if(state.playListStatus is PlayListLoading){
            return Container();
          }

          if(state.playListStatus is PlayListSuccess){
            List<SongEntities> data = (state.playListStatus as PlayListSuccess).playListSong;
            return Padding(
              padding: const EdgeInsets.only(left: 40.0,right: 30,top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('PlayList',style: TextStyle(
                          color: context.isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      Text('See More',style: TextStyle(
                          color: context.isDarkMode ? Colors.white : const Color(0xffC6C6C6),
                          fontWeight: FontWeight.normal,
                          fontSize: 12
                       ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => SongPlayerScreen(song: data[index],songs: data,index: index,),));
                             },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: context.isDarkMode ? const Color(0xff2C2C2C) : const Color(0xffE6E6E6)
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                            height: 17,
                                            context.isDarkMode ? Assets.playMusicDarkTheme : Assets.playMusicLightTheme
                                        ),
                                      )
                                  ),
                                  const SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment : CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index].title!,style:
                                      TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: context.isDarkMode ? Colors.white : Colors.black),
                                      ),
                                      Text(data[index].artist!,style:
                                      TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: context.isDarkMode ? const Color(0xffE1E1E1) : Colors.black),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('${data[index].duration}'.replaceAll('.', ':'),style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: context.isDarkMode ? AppColors.grey : Colors.black
                                    ),
                                  ),
                                  const SizedBox(width: 40,),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: data[index].isFavorite!
                                        ? SvgPicture.asset(Assets.outlineLikeDarkTheme,color: Colors.green,)
                                        : SvgPicture.asset(context.isDarkMode ? Assets.outlineLikeDarkTheme : Assets.outlineLikeLightTheme),
                                  )

                                ],
                              )
                            ],
                          ),
                        );

                      },
                    separatorBuilder: (context, index) => const SizedBox(height: 30,),
                  ),
                  const SizedBox(height: 20,),

                ],
              ),
            );
          }

          if(state.playListStatus is PlayListFailed){
            var message = (state.playListStatus as PlayListFailed).message;
            return Text(message);
          }
          return Container();
        },
      ),
    );
  }
}
