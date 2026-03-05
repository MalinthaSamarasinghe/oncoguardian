import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

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
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF3A493),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.dangerous_rounded, color: Color(0xFF000000), size: 32),
                    SvgPicture.asset('assets/svg/right_arrow.svg', colorFilter: const ColorFilter.mode(Color(0xFF000000), BlendMode.srcIn), width: 24, height: 24),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Check Cancer Risk', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('Get your personalized risk assessment', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFE0F689),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.rice_bowl_rounded, color: Color(0xFF000000), size: 32),
                    SvgPicture.asset('assets/svg/right_arrow.svg', colorFilter: const ColorFilter.mode(Color(0xFF000000), BlendMode.srcIn), width: 24, height: 24),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Food Recommendations', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('Discover healthy meal plans for you', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFFA70EA),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite_rounded, color: Color(0xFF000000), size: 32),
                    SvgPicture.asset('assets/svg/right_arrow.svg', colorFilter: const ColorFilter.mode(Color(0xFF000000), BlendMode.srcIn), width: 24, height: 24),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Health Tips', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('Daily wellness advice & tips', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
