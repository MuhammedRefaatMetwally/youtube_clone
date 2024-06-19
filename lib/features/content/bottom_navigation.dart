import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavigation extends StatefulWidget {
  final Function(int index) onPressed;
  const CustomBottomNavigation({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black54, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 8.0.h),
        child: GNav(
          rippleColor: Colors.grey[100]!,
          hoverColor: Colors.grey[100]!,
          haptic: true,
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(
            color: Colors.white,
            width: 1,
          ),
          tabBorder: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
          tabShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 13,
            ),
          ],
          curve: Curves.easeInToLinear,
          duration: const Duration(milliseconds: 300),
          gap: 8,
          color: Colors.white70,
          activeColor: Colors.white,
          iconSize: 24,
          padding:  EdgeInsets.symmetric(horizontal: 19.5.w),
          tabs: const [
            GButton(icon: Icons.home, text: "Home"),
            GButton(icon: Icons.videocam, text: "Shorts"),
            GButton(icon: Icons.cloud_upload),
            GButton(icon: Icons.search, text: "Search"),
            GButton(icon: Icons.logout, text: "Log out"),
          ],
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
            widget.onPressed(index);
          },
          selectedIndex: currentIndex,
        ),
      ),
    );
  }
}
