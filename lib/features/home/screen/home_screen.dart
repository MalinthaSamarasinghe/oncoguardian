import 'package:flutter/material.dart';
import 'package:oncoguardian/features/home/widgets/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Track your health, assess cancer risk, and receive personalized prevention guidance — all in one place.',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Quick Action',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 16),
          HomeCard(
            onPressed: () {},
            title: 'Check Cancer Risk',
            subtitle: 'Get your personalized risk assessment',
            icon: Icons.dangerous_rounded,
            color: const Color(0xFFF3A493),
          ),
          const SizedBox(height: 20),
          HomeCard(
            onPressed: () {},
            title: 'Food Recommendations',
            subtitle: 'Discover healthy meal plans for you',
            icon: Icons.rice_bowl_rounded,
            color: const Color(0xFFE0F689),
          ),
          const SizedBox(height: 20),
          HomeCard(
            onPressed: () {},
            title: 'Health Tips',
            subtitle: 'Daily wellness advice & tips',
            icon: Icons.favorite_rounded,
            color: const Color(0xFFFA70EA),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
