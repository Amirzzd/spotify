import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/shimmer_loading.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/core/config/constants.dart';
import 'package:spotify/features/home/presentation/bloc/songs_bloc.dart';
import 'package:spotify/features/song_player/presentation/song_player_screen.dart';

class NewsSongWidget extends StatelessWidget {
  final SongState state;

  const NewsSongWidget({super.key,required this.state});
  @override
  Widget build(BuildContext context) {
    if(state.newsSongsStatus is NewSongsLoading){
      return Container();
    }
    if(state.newsSongsStatus is NewSongsSuccess){
      BlocProvider.of<SongsBloc>(context).add(GetNewSongsEvent());
      var data = (state.newsSongsStatus as NewSongsSuccess).newSongs;
      return ListView.separated(
        shrinkWrap: true,
        dragStartBehavior: DragStartBehavior.start,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          var image = Constants.setImage(data[index].cover!);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SongPlayerScreen(song: data[index],songs: data,index: index,),));
                },
                child: SizedBox(
                    height: 185,
                    width: 150,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
                            imageUrl: image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              transform: Matrix4.translationValues(-20, 10, 0),
                              height: 35,
                              width: 35,
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
                        ),
                      ],
                    )
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
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
              )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20,),
        itemCount: data.length,
      );
    }
    if(state.newsSongsStatus is NewSongsFailed){
      var message = (state.newsSongsStatus as NewSongsFailed).message;
      return Text(message);
    }
    return Container();
  }
}
