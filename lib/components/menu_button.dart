import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({required this.icon, super.key});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: AppColors.darkGrey, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: SvgPicture.asset(
          icon,
          color: AppColors.appWhite,
        ),
      ),
    );
  }
}
