import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button.dart';
import 'package:spotify/common/widgets/shimmer_loading.dart';
import 'package:spotify/core/config/app_colors.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/core/config/constants.dart';
import 'package:spotify/features/home/domain/entities/song_entities.dart';
import 'package:spotify/features/song_player/bloc/song_player_bloc.dart';
import 'package:spotify/features/song_player/bloc/song_player_status.dart';

class SongPlayerScreen extends StatefulWidget {
  final SongEntities song;
  final List<SongEntities> songs;
  final int index;

  const SongPlayerScreen({super.key,required this.song,required this.songs,required this.index});

  @override
  State<SongPlayerScreen> createState() => _SongPlayerScreenState();
}

class _SongPlayerScreenState extends State<SongPlayerScreen> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: BlocProvider.of<SongPlayerBloc>(context)..add(LoadSong(url: Constants.setAudio(widget.song.song!),),),
      child: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          if(didPop){
            return;
          }
          if(didPop == true){
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              title: Text(
                'Now Playing',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: context.isDarkMode ? Colors.white : Colors.white,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
               _songCover(context),
                const SizedBox(height: 15,),
                _songDetail(context),
                const SizedBox(height: 15,),
                _songPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _songCover (BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            height: MediaQuery.of(context).size.height / 1.9,
            imageUrl: Constants.setImage(widget.song.cover!),
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
          )
      ),
    );
  }

  Widget _songDetail (BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.song.title!,style:
              TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: context.isDarkMode ? Colors.white : Colors.black),
              ),
              Text(widget.song.artist!,style:
              TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: context.isDarkMode ? AppColors.grey : const Color(0xff404040)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FavoriteButton(song: widget.song,)
          ),
        ],
      ),
    );
  }

  Widget _songPlayer (){
    return BlocBuilder<SongPlayerBloc,SongPlayerState>(
      buildWhen: (previous, current) =>
        previous.songPlayerStatus != current.songPlayerStatus,
        builder: (context, state) {
          if(state.songPlayerStatus is SongPlayerLoading){
            return Container();
          }
          if(state.songPlayerStatus is SongPlayerSuccess){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: state.songPosition.inSeconds.toDouble(),
                  max: state.songDuration.inSeconds.toDouble(),
                  min: 0.0,
                  onChanged: (value) {
                    context.read<SongPlayerBloc>().add(SliderChanged(value: value));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Constants.formatDuration(state.songPosition),style: TextStyle(
                        color: context.isDarkMode ? AppColors.grey : Colors.black,
                        fontSize: 14
                       ),
                      ),
                      Text(Constants.formatDuration(state.songDuration),style: TextStyle(
                          color: context.isDarkMode ? AppColors.grey : Colors.black,
                          fontSize: 14
                       ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<SongPlayerBloc>().add(PlayPreviousSong(length: widget.songs.length,index: widget.index));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SongPlayerScreen(song: widget.songs[state.currentIndex], songs: widget.songs,index: state.currentIndex,),));
                      },
                      child: SvgPicture.asset(Assets.previousButton),
                    ),
                    GestureDetector(
                      onTap: () => context.read<SongPlayerBloc>().add(PlayOrPauseSong()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 75,
                          width: 75,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: SvgPicture.asset(
                              context.read<SongPlayerBloc>().audioPlayer.playing ? Assets.pause : Assets.playMusicDarkTheme
                              ,color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('length : ${widget.songs.length}');
                        print('index : ${widget.index}');
                        context.read<SongPlayerBloc>().add(PlayNextSong(length: widget.songs.length,nextSongIndex: widget.index));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SongPlayerScreen(song: widget.songs[state.currentIndex], songs: widget.songs,index: state.currentIndex,),),);
                      },
                      child: SvgPicture.asset(Assets.nextButton),
                    )
                  ],
                ),
              ],
            );
          }
          if(state.songPlayerStatus is SongPlayerFailed){
            const Text('a problem occurred');
          }
          return Container();
        },
    );
  }
}
