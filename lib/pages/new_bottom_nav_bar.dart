import 'package:finalproject/pages/chats_page.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/profile_page.dart';
import 'package:finalproject/pages/orders_page.dart';
import 'package:finalproject/view_models/categories_cubit/categories_cubit.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:finalproject/view_models/workers_cubit/workers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarNew extends StatefulWidget {
  const BottomNavBarNew({super.key});

  @override
  State<BottomNavBarNew> createState() => _BottomNavBarNewState();
}

class _BottomNavBarNewState extends State<BottomNavBarNew> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.cases_outlined),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          BlocProvider(
            create: (context) {
              final cubit = CategoriesCubit();
              cubit.getCategories();
              return cubit;
            },
            child: const HomePage(),
          ),
          BlocProvider(
            create: (context) {
              final cubit = WorkersCubit();
              cubit.getWorkers();
              return cubit;
            },
            child: const ChatsListPage(),
          ),
          const OrdersPage(),
          BlocProvider(
            create: (context) {
              final cubit = ProfileCubit();
              cubit.getProfile();
              return cubit;
            },
            child: const ProfilePage(),
          ),
        ],
      ),
    );
  }
}
