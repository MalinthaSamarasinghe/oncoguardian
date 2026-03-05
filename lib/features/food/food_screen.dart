import 'package:flutter/material.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Cancer Risk Reduction Diet',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Based on your risk profile, increasing fiber-rich and antioxidant-rich foods may help reduce cancer risk',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Fruits & Vegetables', style: Theme.of(context).textTheme.titleMedium),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check, color: Color(0xFF000000), size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Recommended',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Rich in vitamins, minerals, and antioxidants that protect cells',
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
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Fruits & Vegetables', style: Theme.of(context).textTheme.titleMedium),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check, color: Color(0xFF000000), size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Recommended',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Rich in vitamins, minerals, and antioxidants that protect cells',
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
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Fruits & Vegetables', style: Theme.of(context).textTheme.titleMedium),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green[400],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.check, color: Color(0xFF000000), size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Recommended',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Rich in vitamins, minerals, and antioxidants that protect cells',
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
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Broccoli', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF000000), width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Spinach', style: Theme.of(context).textTheme.bodyMedium),
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
