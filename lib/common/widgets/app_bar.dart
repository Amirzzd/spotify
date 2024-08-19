import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helper/is_dark_mode.dart';
import 'package:spotify/core/config/assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? title;
  final bool? hideBack;
  final Color? backGroundColor;
  const CustomAppBar({super.key,this.title,this.hideBack = false,this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title ?? const Text(''),
      backgroundColor: backGroundColor ?? Colors.transparent,
      foregroundColor: backGroundColor,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: hideBack! ? null : IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.isDarkMode ? Colors.grey.shade900 : Colors.grey.withOpacity(0.1)
          ),
          child: SvgPicture.asset(context.isDarkMode ? Assets.backButtonLight : Assets.backButtonDark,fit: BoxFit.none,),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
