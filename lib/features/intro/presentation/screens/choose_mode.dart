import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helper/shared_operator.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/core/config/app_colors.dart';
import 'package:spotify/features/auth/presentation/screens/singin_or_signup.dart';
import 'package:spotify/features/intro/presentation/bloc/theme_cubit.dart';
import 'package:spotify/features/intro/presentation/bloc/theme_state.dart';
import 'package:spotify/locator.dart';


class ChooseModeScreen extends StatelessWidget {
  const ChooseModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackGround,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.chooseModeBG),
                  fit: BoxFit.cover
              ),
            ),
            child: Container(color: Colors.black.withOpacity(0.15)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0,horizontal: 20),
            child: Column(
              children: [
                SvgPicture.asset(Assets.logo),
                const Spacer(),
                const Text(
                  'Choose Mode',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 23),
                ),
                const SizedBox(height: 20,),
                BlocBuilder<ThemeCubit,ThemeState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap : () {
                                  context.read<ThemeCubit>().updateThemeMode(false);
                                  locator<SharedPrefOperator>().saveThemeMode(false);
                                },
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur( sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration:  BoxDecoration(
                                          color: const Color(0xff30393c).withOpacity(0.5),
                                          shape: BoxShape.circle
                                      ),
                                      child: SvgPicture.asset(state.currentTheme!  ? Assets.moon : Assets.selectedMoon,fit: BoxFit.none,),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              const Text(
                                "Dark Mode",
                                style: TextStyle(color: Color(0xffDADADA,),fontSize: 17,fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50,),
                          Column(
                            children: [
                              GestureDetector(
                                onTap : () {
                                  context.read<ThemeCubit>().updateThemeMode(true);
                                  locator<SharedPrefOperator>().saveThemeMode(true);
                                },
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur( sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration:  BoxDecoration(
                                          color: const Color(0xff30393c).withOpacity(0.5),
                                          shape: BoxShape.circle
                                      ),
                                      child: SvgPicture.asset(state.currentTheme! ? Assets.selectedSun : Assets.sun ,fit: BoxFit.none,),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              const Text(
                                "Light Mode",
                                style: TextStyle(color: Color(0xffDADADA,),fontSize: 17,fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                ),
                const SizedBox(height: 50,),
                BasicAppButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInOrSignUpScreen(),
                      )),
                  title: 'Continue',
                  height: 92,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
