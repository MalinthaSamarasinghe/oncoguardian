import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:oncoguardian/features/home/widgets/home_card.dart';
import 'package:oncoguardian/core/services/firebase_firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? _hasPrediction;
  late final FirebaseFirestoreService _firestoreService;

  @override
  void initState() {
    super.initState();
    _firestoreService = FirebaseFirestoreService();
    // Listen to prediction stream for real-time updates
    _firestoreService.getPredictionStream().listen((prediction) {
      setState(() => _hasPrediction = prediction != null);
    });
  }

  @override
  void dispose() {
    _firestoreService.getPredictionStream().drain(); // Stop listening to the stream when widget is disposed
    super.dispose();
  }

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
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.go(AppRouter.risk);
            },
            title: 'Check Cancer Risk',
            subtitle: 'Get your personalized risk assessment',
            icon: Icons.dangerous_rounded,
            color: const Color(0xFFF3A493),
          ),
          const SizedBox(height: 20),
          HomeCard(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              _navigateOrShowAlert(context, 'Food Recommendations', AppRouter.food);
            },
            title: 'Food Recommendations',
            subtitle: 'Discover healthy meal plans for you',
            icon: Icons.rice_bowl_rounded,
            color: const Color(0xFFE0F689),
          ),
          const SizedBox(height: 20),
          HomeCard(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              _navigateOrShowAlert(context, 'Health Tips', AppRouter.tips);
            },
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

  /// Navigate to screen or show alert if no prediction data
  void _navigateOrShowAlert(BuildContext context, String screenName, String screenPath) {
    // Use cached prediction status from stream (instant, no async delay)
    if (_hasPrediction == true) {
      context.go(screenPath);
    } else {
      _showNoPredictionAlert(context, screenName);
    }
  }

  /// Show alert when prediction data is not available
  void _showNoPredictionAlert(BuildContext context, String screenName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Text('Complete Risk Assessment First'),
          content: Text('Please complete your health profile assessment in the Risk section to access $screenName.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(AppRouter.risk);
              },
              child: const Text('Go to Risk Assessment'),
            ),
          ],
        );
      },
    );
  }
}
