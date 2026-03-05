import 'package:flutter/material.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Health Tips & Awareness',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Practical guidance for cancer prevention and wellness',
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GestureDetector(
              onTap: () => setState(() => currentTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF000000), width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: currentTab == 0 ? Colors.blue[200] : null,
                ),
                child: Text('Daily Tips', style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => currentTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF000000), width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: currentTab == 1 ? Colors.blue[200] : null,
                ),
                child: Text('Lifestyle Challenges', style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => currentTab = 2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF000000), width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: currentTab == 2 ? Colors.blue[200] : null,
                ),
                child: Text('Awareness & Screening', style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
          ],
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
                        Text('Stay Hydrated', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        Text(
                          'Drink 8-10 glasses of water daily to support detoxification and cellular health.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Hydration', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
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
                        Text('Stay Hydrated', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        Text(
                          'Drink 8-10 glasses of water daily to support detoxification and cellular health.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Hydration', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
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
                        Text('Stay Hydrated', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 16),
                        Text(
                          'Drink 8-10 glasses of water daily to support detoxification and cellular health.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Hydration', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
