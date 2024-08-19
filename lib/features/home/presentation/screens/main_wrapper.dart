import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/core/config/app_colors.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/features/download/presentation/screen/download_screen.dart';
import 'package:spotify/features/home/presentation/screens/home_screen.dart';
import 'package:spotify/features/profile/presentation/screens/profile_screen.dart';
import 'package:spotify/features/search/presentation/screen/search_screen.dart';

import '../bloc/bottom nav/bottom_nav_cubit.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final List bottomTab = [Assets.homeTab, Assets.searchTab, Assets.downloadTab,Assets.profileTab];
  final List<Widget> bottomNavScreens =  [
    HomeScreen(),
    const SearchScreen(),
    const DownloadScreen(),
    const ProfileScreen()
  ];
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: const ClampingScrollPhysics(),
          onPageChanged: (value) {

            context.read<BottomNavCubit>().changeIndex(value);
          },
        controller: pageController,
        children: bottomNavScreens
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit,int>(
        builder: (context, state) {
          return BottomNavigationBar(
              backgroundColor: context.isDarkMode ? AppColors.cardColor : Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                context.read<BottomNavCubit>().changeIndex(value);
                pageController.jumpToPage(value);
              },
            currentIndex: state,
            items: List.generate(
            bottomTab.length,
            (index) => BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0, -13, 0),
                      height: 5,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
                      ),

                    ),
                    SvgPicture.asset(bottomTab[index], color: AppColors.primary,),
                  ],
                ),
                label: '',icon: SvgPicture.asset(bottomTab[index],color: context.isDarkMode ? AppColors.darkGrey : Colors.black,),
              ),
            )
          );
        },
      ),
    );
  }
}
