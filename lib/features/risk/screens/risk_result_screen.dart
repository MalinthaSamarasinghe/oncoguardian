import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/features/risk/models/prediction_response_model.dart';

class RiskResultScreen extends StatelessWidget {
  final PredictionResponse predictionResponse;

  const RiskResultScreen({
    super.key,
    required this.predictionResponse,
  });

  String _formatDate(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) {
      return 'Unknown Date';
    }
    try {
      return DateFormat('MMMM d, yyyy').format(DateTime.parse(timestamp));
    } catch (e) {
      return timestamp;
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
          backgroundColor: const Color(0xFFFFFFFF),
          body: Column(
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
                          '${((predictionResponse.prediction?.confidence ?? 0) * 100).toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 14),
                        Text(
                          '${predictionResponse.prediction?.predictedCancerType ?? 'Cancer'} Risk - ${predictionResponse.prediction?.riskLevel ?? 'UNKNOWN'}',
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
                              Text(
                                'Assessment Date: ${_formatDate(predictionResponse.timestamp)}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
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
                              Text('Cancer Type Probabilities', style: Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 16),
                              ...?predictionResponse.prediction?.probabilities?.entries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text.rich(
                                    TextSpan(
                                      text: '${entry.key}: ',
                                      style: Theme.of(context).textTheme.labelMedium,
                                      children: [
                                        TextSpan(
                                          text: '${(entry.value * 100).toStringAsFixed(1)}%',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        if (predictionResponse.recommendations != null) ...[
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
                                Text('Lifestyle Tips', style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 16),
                                ...?predictionResponse.recommendations?.lifestyleTips?.map((tip) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      '• $tip',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                                    ),
                                  );
                                }),
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
                                Text('Recommended Foods', style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 16),
                                ...?predictionResponse.recommendations?.recommendedFoods?.map((food) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      food,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                                    ),
                                  );
                                }),
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
                                Text('Foods to Avoid', style: Theme.of(context).textTheme.titleMedium),
                                const SizedBox(height: 16),
                                ...?predictionResponse.recommendations?.foodsToAvoid?.map((food) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      food,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          if ((predictionResponse.recommendations?.supplements?.isNotEmpty ?? false)) ...[
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
                                  Text('Recommended Supplements', style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: 16),
                                  ...?predictionResponse.recommendations?.supplements?.map((supplement) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        '• $supplement',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ],
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 160,
                          child: ElevatedButton(
                            onPressed: () => context.pushReplacement(AppRouter.risk),
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
          ),
        ),
      ),
    );
  }
}
