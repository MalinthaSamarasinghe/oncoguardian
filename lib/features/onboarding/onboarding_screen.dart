import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/core/widgets/app_icon_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final ValueNotifier<int> _currentPageIndex = ValueNotifier(0);
  final List<List<String>> introList = [
    ['Know Your Risk. Take Control.', 'AI-driven cancer risk prediction built around your unique health profile.'],
    ['Eat Smart. Live Strong.', 'Personalized nutrition plans designed to reduce risk and improve long-term health.'],
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/app_logo.png', fit: BoxFit.cover),
            ),
            PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                _currentPageIndex.value = value;
                _pageController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.linear);
              },
              pageSnapping: true,
              allowImplicitScrolling: false,
              scrollDirection: Axis.horizontal,
              itemCount: introList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26, bottom: 220),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 26,
                    children: [
                      Text(
                        introList[index].first,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20, color: const Color(0xFF121212), fontWeight: FontWeight.w700, height: 1.35),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        introList[index].last,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16, color: const Color(0xFF121212), fontWeight: FontWeight.w500, height: 1.35),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            if (_currentPageIndex.value > 0)
              Positioned(
                top: 57,
                left: 26,
                child: AppIconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    setState(() {
                      if (_currentPageIndex.value > 0) {
                        _currentPageIndex.value--;
                        _pageController.animateToPage(_currentPageIndex.value, duration: const Duration(milliseconds: 300), curve: Curves.linear);
                      }
                    });
                  },
                  backgroundColor: const Color(0xFF525252),
                  iconWidget: SvgPicture.asset('assets/svg/back.svg', colorFilter: const ColorFilter.mode(Color(0xFFFFFFFF), BlendMode.srcIn)),
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 44,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 78, right: 78, bottom: 96),
                child: ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (_currentPageIndex.value < introList.length - 1) {
                      setState(() {
                        _currentPageIndex.value++;
                        _pageController.animateToPage(_currentPageIndex.value, duration: const Duration(milliseconds: 300), curve: Curves.linear);
                      });
                    } else {
                      context.go(AppRouter.signIn);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF525252),
                    foregroundColor: const Color(0xFFFFFFFF),
                  ),
                  child: Text(_currentPageIndex.value > 0 ? 'Get Started' : 'Next'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 58),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < introList.length; i++)
                      ValueListenableBuilder<int>(
                        valueListenable: _currentPageIndex,
                        builder: (context, value, child) => _pageIndexIndicator(_currentPageIndex.value == i, i),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageIndexIndicator(bool isCurrentPage, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 9,
      width: 9,
      margin: EdgeInsets.only(right: index != (introList.length - 1) ? 7 : 0),
      decoration: BoxDecoration(
        color: isCurrentPage
            ? const Color(0xFF000000)
            : const Color(0xFF525252),
        shape: BoxShape.circle,
      ),
    );
  }
}
