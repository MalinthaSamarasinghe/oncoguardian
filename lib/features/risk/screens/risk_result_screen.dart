import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';

class RiskResultScreen extends StatelessWidget {
  const RiskResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Your Cancer Risk Assessment',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Based on your health profile data',
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Text(
                    '30%',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Cancer Risk Level',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[400],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('What This Means', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        Text(
                          'This result is based on your provided health and family history data. Your risk assessment takes into account factors such as age, lifestyle habits, family history, and existing health conditions.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 12),
                        Text('Assessment Date: January 26, 2026', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[400],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Key Contributing', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        Text.rich(
                          TextSpan(
                            text: 'Factors Moderate Risk Factors\n',
                            style: Theme.of(context).textTheme.labelMedium,
                            children: [
                              TextSpan(
                                text: '• Some lifestyle and health factors may influence your risk profile',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text.rich(
                          TextSpan(
                            text: 'Improvement Opportunity\n',
                            style: Theme.of(context).textTheme.labelMedium,
                            children: [
                              TextSpan(
                                text: '• Lifestyle modifications could help reduce your risk',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () => context.push(AppRouter.risk),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF000000),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: const Center(child: Text('New Assessment')),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
