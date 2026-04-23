import 'package:flutter/material.dart';
import 'package:oncoguardian/core/services/firebase_firestore_service.dart';
import 'package:oncoguardian/features/risk/models/prediction_response_model.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  int currentTab = 0;
  late final FirebaseFirestoreService _firestoreService;

  @override
  void initState() {
    super.initState();
    _firestoreService = FirebaseFirestoreService();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PredictionResponse?>(
      stream: _firestoreService.getPredictionStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final predictionResponse = snapshot.data;
        final recommendations = predictionResponse?.recommendations;
        final prediction = predictionResponse?.prediction;

        if (recommendations == null || prediction == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Health Tips',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Complete a risk assessment to get personalized health tips',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

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
                'Practical guidance for ${prediction.predictedCancerType ?? 'cancer'} prevention and wellness',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
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
                        child: Text('Lifestyle Tips', style: Theme.of(context).textTheme.bodySmall),
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
                        child: Text('Supplements', style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  ],
                ),
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
                      if (currentTab == 0)
                        // Lifestyle Tips Tab
                        if ((recommendations.lifestyleTips?.isNotEmpty ?? false))
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
                                Text(
                                  '${prediction.predictedCancerType ?? 'Cancer'} Prevention Tips',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Follow these evidence-based lifestyle recommendations to reduce your risk',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...recommendations.lifestyleTips!.map((tip) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Colors.green[100],
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  tip,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[400],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'No lifestyle tips available',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                      if (currentTab == 1)
                        // Supplements Tab
                        if ((recommendations.supplements?.isNotEmpty ?? false))
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
                                Text(
                                  'Recommended Supplements',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'These supplements may support your health and reduce cancer risk',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    ...recommendations.supplements!.map((supplement) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blue, width: 2),
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.blue[50],
                                        ),
                                        child: Text(
                                          supplement,
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[400],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'No supplements recommended',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
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
      },
    );
  }
}
