import 'package:finalproject/pages/booking_page.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/profile_page.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        const HomePage(),
        const BookingPage(),
        BlocProvider(
          create: (context) {
            final cubit = ProfileCubit();
            cubit.getProfile();
            return cubit;
          },
          child: const ProfilePage(),
        ),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Theme.of(context).colorScheme.onSurface,
          inactiveColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.work),
          title: ("Jobs"),
          activeColorPrimary: Theme.of(context).colorScheme.onSurface,
          inactiveColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          activeColorPrimary: Theme.of(context).colorScheme.onSurface,
          inactiveColorPrimary: Theme.of(context).colorScheme.inversePrimary,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor:
          Theme.of(context).colorScheme.surface, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Theme.of(context).colorScheme.surface,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
