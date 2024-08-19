import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/features/intro/presentation/screens/choose_mode.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.introBG),
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
                  'Enjoy Listening To Music',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 23),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff797979),fontSize: 15,),
                ),
                const SizedBox(height: 50,),
                BasicAppButton(
                  onPressed: () => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const ChooseModeScreen(),)),
                  title: 'Get Started',
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

