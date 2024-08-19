import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/common/param/sign_up_param.dart';
import 'package:spotify/common/widgets/app_bar.dart';
import 'package:spotify/common/widgets/basic_app_button.dart';
import 'package:spotify/common/widgets/custom_snackbar.dart';
import 'package:spotify/core/config/assets.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:spotify/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:spotify/features/home/presentation/screens/home_screen.dart';
import 'package:spotify/features/home/presentation/screens/main_wrapper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController fullName;
  late TextEditingController email;
  late TextEditingController password;
  
  @override
  void initState() {
    super.initState();
    fullName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }
  
  @override
  void dispose() {
    super.dispose();
    fullName.dispose();
    email.dispose();
    password.dispose();
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
                  const SizedBox(height: 30,),
                  _registerText(),
                  const SizedBox(height: 20,),
                  _registerTextSub(),
                  const SizedBox(height: 20,),
                  _fullNameField(),
                  const SizedBox(height: 20,),
                  _enterEmailField(),
                  const SizedBox(height: 20,),
                  _passwordField(),
                  const SizedBox(height: 30,),
                  ///create Account button
                  BlocConsumer<AuthBloc,AuthState>(
                    listener: (context, state) {
                      if(state.signUpStatus is SignUpFailed){
                        SignUpFailed signUpFailed = state.signUpStatus as SignUpFailed;
                        CustomSnackBar.showSnack(
                          context: context,
                          success: false,
                          message: signUpFailed.message,
                        );
                      }
                      if(state.signUpStatus is SignUpSuccess){
                        SignUpSuccess signUpSuccess= state.signUpStatus as SignUpSuccess;
                        CustomSnackBar.showSnack(
                          context: context,
                          success: true,
                          message: signUpSuccess.message
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainWrapper(),),
                          (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      if(state.signUpStatus is SignUpLoading){
                        return const CircularProgressIndicator();
                      }
                      return BasicAppButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              context.read<AuthBloc>().add(SignUpEvent(
                                  signUpParam: SignUpParam(
                                    fullName: fullName.text,
                                    email: email.text,
                                    password: password.text,
                                  ),
                                ),
                              );
                            }
                          },
                          title: 'Create Account');
                    },
                  ),
                  const SizedBox(height: 20,),
                  _beautifulLines(),
                  const SizedBox(height: 20,),
                  _authIcons(),
                  const SizedBox(height: 40,),
                  _signInText(),
                  const SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _registerText (){
    return Text(
      'Register',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: context.isDarkMode ? Colors.white : Colors.black
      ),
    );
  }

  Widget _registerTextSub () {
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

  Widget _fullNameField () {
    return TextFormField(
      controller: fullName,
      decoration: const InputDecoration(
        hintText: 'Full Name',
      ),
      validator: (value) {
        if(value == null) return 'Cant be Empty';
        if(value.isEmpty) return 'Cant be Empty';
        if(value.length > 30) return 'Value is To Long';
        return null;
      },
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
            obscureText: state.togglePass,
            controller: password,
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
                    child: Icon(state.togglePass ? Icons.visibility_outlined : Icons.visibility_off_outlined)),              ),
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

  Widget _signInText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do You Have Any Account? ',
          style: TextStyle(
              fontSize: 12,
              color: context.isDarkMode ? Colors.white : Colors.black
          ),
        ),
        GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen(),));
            },
            child: const Text(
              'Sign In',
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
