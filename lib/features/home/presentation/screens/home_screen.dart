import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/features/home/presentation/bloc/songs_bloc.dart';
import 'package:spotify/features/home/presentation/widgets/news_song.dart';
import 'package:spotify/features/home/presentation/widgets/play_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  final List tabBarItem = ['News', 'Videos', 'Artists', 'Podcast'];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      SongsBloc()
        ..add(GetNewSongsEvent()),
      child: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SongsBloc>().add(GetNewSongsEvent());
                await Future.delayed(Duration(seconds: 2));
              },
              child: SafeArea(
                child: Scaffold(
                  appBar: CustomAppBar(
                    hideBack: true,
                    title: Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(Assets.logo, height: 40)),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        _homeArtistCard(),
                        _tabBar(),
                        const PlayListWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  Widget _homeArtistCard() {
    var size = MediaQuery
        .of(context)
        .size;
    return SizedBox(
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(Assets.homeTopCard,)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: size.width / 8,),
                  child: Image.asset(Assets.homeArtist),
                ))
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return DefaultTabController(
      length: tabBarItem.length,
      child: Column(
        children: [

          ///tab bar
          TabBar(
            indicatorColor: Colors.green,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 12,),
            indicatorWeight: 3,
            padding: const EdgeInsets.all(20),
            tabAlignment: TabAlignment.start,
            splashFactory: NoSplash.splashFactory,
            labelPadding: const EdgeInsets.only(right: 35, left: 25),
            isScrollable: true,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.normal,
                fontSize: 18,
                color: context.isDarkMode ? Colors.white : Colors.black),
            dividerColor: Colors.transparent,
            tabs: List.generate(
              tabBarItem.length,
                  (index) =>
                  Tab(
                    text: tabBarItem[index],
                  ),
            ),
          ),

          ///tab bar view
          BlocBuilder<SongsBloc, SongState>(
            builder: (context, state) {
              BlocProvider.of<SongsBloc>(context).add(GetNewSongsEvent());
              return SizedBox(
                height: 260,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      NewsSongWidget(state: state,),
                      Container(),
                      Container(),
                      Container()
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}