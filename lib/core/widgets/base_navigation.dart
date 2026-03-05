import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';

class BaseNavigation extends StatefulWidget {
  final Widget child;

  const BaseNavigation({required this.child, Key? key}) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  @override
  State<BaseNavigation> createState() => _BaseNavigationState();
}

class _BaseNavigationState extends State<BaseNavigation> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentIndex();
  }

  void _updateCurrentIndex() {
    final String location = GoRouterState.of(context).uri.path;
    final int newIndex = _navigationItems.indexWhere((item) => location.contains(item.path));
    if (newIndex != -1 && newIndex != _currentIndex) {
      setState(() => _currentIndex = newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          key: _scaffoldKey,
          body: widget.child,
          backgroundColor: const Color(0xFFFFFFFF),
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text('Hello Anushka'),
            ),
            actions: [
              const SizedBox(width: 14),
              AppIconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                backgroundColor: const Color(0xFFF3F4F6),
                iconWidget: SvgPicture.asset('assets/svg/notification.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn), width: 20, height: 20),
              ),
              const SizedBox(width: 14),
              AppIconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  context.push(AppRouter.settings);
                },
                backgroundColor: const Color(0xFFF3F4F6),
                iconWidget: SvgPicture.asset('assets/svg/settings.svg', colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn)),
              ),
              const SizedBox(width: 20),
            ],
          ),
          /// TODO: Height of BottomNavigationBar ???
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
              _onItemTapped(context, index);
            },
            items: _navigationItems.map((item) {
              return BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Icon(
                    item.icon,
                    color: _currentIndex == _navigationItems.indexOf(item)
                        ? const Color(0xFF000000)
                        : const Color(0xFFB3B3B3),
                  ),
                ),
                label: item.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  static const List<NavigationItem> _navigationItems = [
    NavigationItem(path: AppRouter.home, icon: Icons.home_rounded, label: 'Home'),
    NavigationItem(path: AppRouter.risk, icon: Icons.dangerous_rounded, label: 'Risk'),
    NavigationItem(path: AppRouter.food, icon: Icons.rice_bowl_rounded, label: 'Food'),
    NavigationItem(path: AppRouter.tips, icon: Icons.favorite_rounded, label: 'Tips'),
  ];

  /// Handle navigation item tap
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Home
        context.go(AppRouter.home);
        break;
      case 1:
        // Search
        context.go(AppRouter.risk);
        break;
      case 2:
        // Music Library
        context.go(AppRouter.food);
        break;
      case 3:
        // News Feed
        context.go(AppRouter.tips);
        break;
    }
  }
}

class NavigationItem {
  final String path;
  final IconData icon;
  final String label;

  const NavigationItem({
    required this.path,
    required this.icon,
    required this.label,
  });
}
