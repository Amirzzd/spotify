import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button.dart';
import 'package:spotify/core/config/app_colors.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/core/config/constants.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spotify/features/home/domain/entities/song_entities.dart';
import 'package:spotify/features/home/presentation/bloc/songs_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        backGroundColor: context.isDarkMode ? AppColors.cardColor : Colors.grey,
        title: Text('Profile',style: TextStyle(fontSize: 17,color: context.isDarkMode ? Colors.white : Colors.black,fontWeight: FontWeight.bold),),
        hideBack: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileInfo(context),
            _favoriteSongs(context),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo (BuildContext context){
    return BlocProvider(
      create: (context) => AuthBloc()..add(GetUserEvent()),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60),
            bottomRight: Radius.circular(60)
          ),
          color: context.isDarkMode ? AppColors.cardColor : Colors.white
        ),
        child: BlocBuilder<AuthBloc,AuthState>(
            builder: (context, state) {

              if(state.getUserStatus is GetUserStatusLoading){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(state.getUserStatus is GetUserStatusSuccess){
                var userEntity = (state.getUserStatus as GetUserStatusSuccess).userEntity;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    Container(
                      height: 90,
                      width: double.infinity,
                      decoration:  const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                           image: AssetImage(Assets.profile)
                        )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(userEntity.email!,style: TextStyle(color: context.isDarkMode ? AppColors.grey : Colors.black,fontSize: 13),),
                    const SizedBox(height: 10,),
                    Text(userEntity.fullName!,style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                );
              }
              if(state.getUserStatus is GetUserStatusFailed){
                var message = (state.getUserStatus as GetUserStatusFailed).message;
                return Center(child: Text(message,style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),),);
              }
              return Container();
            },
        ),
      ),
    );
  }

  Widget _favoriteSongs (BuildContext context){
    return BlocProvider(
      create: (context) => SongsBloc()..add(GetUserFavoriteSongsEvent()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'FAVORITE SONGS',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: context.isDarkMode ? const Color(0xffD6D6D6) : Colors.black),
              ),
            ),
            BlocBuilder<SongsBloc,SongState>(
              builder: (context, state) {
                if(state.getUserFavoriteSongsStatus is GetUserFavoriteSongsLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                if(state.getUserFavoriteSongsStatus is GetUserFavoriteSongsSuccess){
                  List<SongEntities> songs = (state.getUserFavoriteSongsStatus as GetUserFavoriteSongsSuccess).favoriteSongs;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(Constants.setImage(songs[index].cover!))
                                      )
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Column(
                                  crossAxisAlignment : CrossAxisAlignment.start,
                                  children: [
                                    Text(songs[index].title!,style:
                                    TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: context.isDarkMode ? Colors.white : Colors.black),
                                    ),
                                    Text(songs[index].artist!,style:
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
                                Text('${songs[index].duration}'.replaceAll('.', ':'),style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: context.isDarkMode ? AppColors.grey : Colors.black
                                ),
                                ),
                                const SizedBox(width: 40,),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: FavoriteButton(
                                    function: ()=> context.read<SongsBloc>().add(RemoveSong(index: index)),
                                    song: songs[index],
                                    key: UniqueKey(),
                                  )
                                )

                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 15,);
                      },
                      itemCount: songs.length);
                }
                if(state.getUserFavoriteSongsStatus is GetUserFavoriteSongsFailed){
                  String message = (state.getUserFavoriteSongsStatus as GetUserFavoriteSongsFailed).message;
                  return Center(child: Text(message,style: TextStyle(color: context.isDarkMode ? Colors.white : Colors.black),));
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}