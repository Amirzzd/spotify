import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/param/sign_in_param.dart';
import 'package:spotify/common/widgets/app_bar.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/common/widgets/custom_snackbar.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spotify/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:spotify/features/home/presentation/screens/home_screen.dart';
import 'package:spotify/features/home/presentation/screens/main_wrapper.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: CustomAppBar(
        title: SvgPicture.asset(Assets.logo,height: 40,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60,),
                _titleText(),
                const SizedBox(height: 25,),
                _titleTextSub(),
                const SizedBox(height: 50,),
                _enterEmailField(),
                const SizedBox(height: 20,),
                _passwordField(),
                const SizedBox(height: 50,),
                ///SignIn button
                BlocConsumer<AuthBloc,AuthState>(
                  listener: (context, state) {
                    if(state.signInStatus is SignInFailed){
                      SignInFailed signInFailed = state.signInStatus as SignInFailed;
                      CustomSnackBar.showSnack(
                        context: context,
                        success: false,
                        message: signInFailed.message,
                      );
                    }
                    if(state.signInStatus is SignInSuccess){
                      SignInSuccess signInSuccess= state.signInStatus as SignInSuccess;
                      CustomSnackBar.showSnack(
                          context: context,
                          success: true,
                          message: signInSuccess.message
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainWrapper(),),
                          (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if(state.signInStatus is SignInLoading){
                      return const CircularProgressIndicator();
                    }
                    return BasicAppButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            context.read<AuthBloc>().add(SignInEvent(
                              signInParam: SignInParam(
                                email: email.text,
                                password: password.text,
                              ),
                            ),
                            );
                          }
                        },
                        title: 'Sign In');
                  },
                ),
                const SizedBox(height: 20,),
                _beautifulLines(),
                const SizedBox(height: 20,),
                _authIcons(),
                const SizedBox(height: 30,),
                _registerText(),
                const SizedBox(height: 50,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleText (){
    return Text(
      'Sign In',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: context.isDarkMode ? Colors.white : Colors.black
      ),
    );
  }

  Widget _titleTextSub () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'If You need Any Support ',
          style: TextStyle(
              fontSize: 12,
              color: context.isDarkMode ? Colors.white : Colors.black
          ),
        ),
        GestureDetector(
          child: const Text(
            'Click Here',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                color: Colors.green
            ),
          ),
        ),
      ],
    );
  }

  Widget _enterEmailField () {
    return TextFormField(
      controller: email,
      validator: (value) {
        if(value == null) return 'cant be Empty';
        if(value.isEmpty)return 'cant be Empty';
        if(!value.endsWith('.com') && !value.contains('@')){
          return 'Value is Invalid';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter Email',

      ),
    );
  }

  Widget _passwordField () {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context, state) {
        return TextFormField(
          controller: password,
          obscureText: state.togglePass,
          validator: (value) {
            if(value == null)return 'cant be Empty';
            if(value.isEmpty)return 'cant be Empty';
            if(value.length < 8){
              return 'Value is To Short';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'password',
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                  onTap: () => context.read<AuthBloc>().add(ShowPassword()),
                  child: Icon(state.togglePass ? Icons.visibility_outlined : Icons.visibility_off_outlined)),
            ),
          ),
        );
      },
    );
  }

  Widget _beautifulLines () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      context.isDarkMode ? const Color(0xff5B5B5B) : const Color(0xffB0B0B0),
                      context.isDarkMode ? const Color(0xff5B5B5B) : const Color(0xffD3D3D3),
                    ]
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Or',
            style: TextStyle(
                fontSize: 13,
                color: context.isDarkMode ? const Color(0xff383838) : Colors.black),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      context.isDarkMode ? const Color(0xff5B5B5B) : const Color(0xffD3D3D3),
                      context.isDarkMode ? const Color(0xff5B5B5B) : const Color(0xffB0B0B0),
                    ]
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget _authIcons () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(Assets.google,),
        SvgPicture.asset(context.isDarkMode ? Assets.lightApple : Assets.darkApple)
      ],
    );
  }

  Widget _registerText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Not A Member? ',
          style: TextStyle(
              fontSize: 12,
              color: context.isDarkMode ? Colors.white : Colors.black
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
          },
          child: const Text(
            'Register Now',
            style: TextStyle(
                fontSize: 14,
                color: Colors.blue
            ),
          ),
        )
      ],
    );
  }
}
