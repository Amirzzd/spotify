import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/widgets/app_bar.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spotify/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:spotify/features/auth/presentation/screens/sign_up_screen.dart';

class SignInOrSignUpScreen extends StatelessWidget {
  const SignInOrSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const CustomAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(Assets.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(Assets.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(Assets.authBG),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.logo),
                  const SizedBox(height: 50,),
                  const Text(
                    'Enjoy listening to music',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Color(0xff797979)),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpScreen(),),
                            );
                          },
                          title: 'Register',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignInScreen())
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 19,
                                  color: context.isDarkMode ? Colors.white : Colors.black
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
