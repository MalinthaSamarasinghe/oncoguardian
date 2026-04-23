import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/routes/app_router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oncoguardian/features/risk/widgets/risk_text_field.dart';
import 'package:oncoguardian/core/services/firebase_firestore_service.dart';

class RiskAssessmentScreen extends StatefulWidget {
  const RiskAssessmentScreen({super.key});

  @override
  State<RiskAssessmentScreen> createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Personal Information
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  int gender = 0; // 0 = Female, 1 = Male

  // Lifestyle & Behavior (Sliders)
  double smoking = 5.0; // 0-10
  double alcoholUse = 5.0; // 0-10
  double physicalActivity = 5.0; // 0-10
  double airPollution = 5.0; // 0-10
  double occupationalHazards = 3.0; // 0-10

  // Binary Radio Fields
  int familyHistory = 0; // 0 = No, 1 = Yes
  int brcaMutation = 0; // 0 = No, 1 = Yes
  int hPyloriInfection = 0; // 0 = No, 1 = Yes

  // Diet & Nutrition (Sliders)
  double dietRedMeat = 5.0; // 0-10
  double dietSaltedProcessed = 5.0; // 0-10
  double fruitVegIntake = 5.0; // 0-10
  double calciumIntake = 7.0; // 0-10

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Health Profile Assessment',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Step ${currentStep + 1} of 3',
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),
        _buildProgressIndicator(context),
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
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: currentStep == 0
                    ? _buildStep1() // Personal & Genetic Information
                    : currentStep == 1
                        ? _buildStep2() // Lifestyle & Behavior
                        : _buildStep3(), // Diet & Nutrition
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStepCircle(context, '1', 'Personal'),
              _buildStepCircle(context, '2', 'Lifestyle'),
              _buildStepCircle(context, '3', 'Diet'),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              color: Colors.grey[400],
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: currentStep == 0
                    ? MediaQuery.of(context).size.width / 4.35
                    : currentStep == 1
                        ? MediaQuery.of(context).size.width / 1.85
                        : double.infinity,
                height: 6,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStepCircle(BuildContext context, String number, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.brown,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Personal & Genetic Information',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        // Age Field
        RiskTextField(
          label: 'Age',
          hint: 'Enter age between 25-90 years',
          controller: ageController,
          keyboardType: TextInputType.number,
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Age is required';
            }
            final age = int.tryParse(value);
            if (age == null || age < 25 || age > 90) {
              return 'Age must be between 25 and 90';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        // Height Field
        RiskTextField(
          label: 'Height',
          hint: 'Enter height in cm',
          controller: heightController,
          keyboardType: TextInputType.number,
          inputFormatter: [FilteringTextInputFormatter.digitsOnly],
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Height is required';
          //   }
          //   final height = int.tryParse(value);
          //   if (height == null || height < 100 || height > 250) {
          //     return 'Please enter a valid height';
          //   }
          //   return null;
          // },
        ),
        const SizedBox(height: 16),
        // Weight Field
        RiskTextField(
          label: 'Weight',
          hint: 'Enter weight in kg',
          controller: weightController,
          keyboardType: TextInputType.number,
          inputFormatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Weight is required';
          //   }
          //   final weight = double.tryParse(value);
          //   if (weight == null || weight < 30 || weight > 300) {
          //     return 'Please enter a valid weight';
          //   }
          //   return null;
          // },
        ),
        const SizedBox(height: 16),
        // Gender Field
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Gender',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'Female',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            value: 0,
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value ?? 0),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'Male',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            value: 1,
            groupValue: gender,
            onChanged: (value) => setState(() => gender = value ?? 1),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 20),
        // Family History
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Family History of Cancer',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'No',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            value: 0,
            groupValue: familyHistory,
            onChanged: (value) => setState(() => familyHistory = value ?? 0),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'Yes',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            value: 1,
            groupValue: familyHistory,
            onChanged: (value) => setState(() => familyHistory = value ?? 1),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 20),
        // BRCA Mutation
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'BRCA Gene Mutation (BRCA1/BRCA2)',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'No Mutation',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            subtitle: Text(
              'Normal genetic status - standard risk',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
            value: 0,
            groupValue: brcaMutation,
            onChanged: (value) => setState(() => brcaMutation = value ?? 0),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'Mutation Present',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            subtitle: Text(
              'Elevated cancer risk - genetic counseling recommended',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
            value: 1,
            groupValue: brcaMutation,
            onChanged: (value) => setState(() => brcaMutation = value ?? 1),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 20),
        // H. Pylori Infection
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'H. Pylori Bacterial Infection',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'No Infection',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            subtitle: Text(
              'Tested negative or never tested',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
            value: 0,
            groupValue: hPyloriInfection,
            onChanged: (value) => setState(() => hPyloriInfection = value ?? 0),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 2),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
          ),
          child: RadioListTile<int>(
            title: Text(
              'Infected',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5),
            ),
            subtitle: Text(
              'Tested positive - increased gastric cancer risk',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
            value: 1,
            groupValue: hPyloriInfection,
            onChanged: (value) => setState(() => hPyloriInfection = value ?? 1),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ),
        const SizedBox(height: 32),
        _buildNavigationButtons(showBack: false),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Lifestyle & Behavior',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        // Smoking Slider
        _buildSliderField(
          label: 'Smoking Status & Intensity: ${smoking.toInt()}',
          value: smoking,
          onChanged: (value) => setState(() => smoking = value),
          description: '0 = Never smoked, 1-3 = Former smoker (quit), 4-6 = Light smoker, 7-8 = Moderate smoker, 9-10 = Heavy smoker',
        ),
        const SizedBox(height: 20),
        // Alcohol Use Slider
        _buildSliderField(
          label: 'Alcohol Consumption Level: ${alcoholUse.toInt()}',
          value: alcoholUse,
          onChanged: (value) => setState(() => alcoholUse = value),
          description: '0 = No consumption, 1-3 = Rare/occasional, 4-6 = Moderate (1-2 drinks/day), 7-8 = Heavy (3-4 drinks/day), 9-10 = Very heavy (5+ drinks/day)',
        ),
        const SizedBox(height: 20),
        // Physical Activity Slider
        _buildSliderField(
          label: 'Physical Activity Level: ${physicalActivity.toInt()}',
          value: physicalActivity,
          onChanged: (value) => setState(() => physicalActivity = value),
          description: '0 = Sedentary (no exercise), 1-3 = Very light (1-2 hours/week), 4-6 = Light (3-4 hours/week), 7-8 = Moderate (5-6 hours/week), 9-10 = Very active (7+ hours/week)',
        ),
        const SizedBox(height: 20),
        // Air Pollution Slider
        _buildSliderField(
          label: 'Air Pollution Exposure Level: ${airPollution.toInt()}',
          value: airPollution,
          onChanged: (value) => setState(() => airPollution = value),
          description: '0 = Clean air (AQI 0-50), 1-3 = Moderate (AQI 51-100), 4-6 = Unhealthy for sensitive groups (AQI 101-150), 7-8 = Unhealthy (AQI 151-200), 9-10 = Very unhealthy/Hazardous (AQI 201+)',
        ),
        const SizedBox(height: 20),
        // Occupational Hazards Slider
        _buildSliderField(
          label: 'Occupational Exposure Hazards: ${occupationalHazards.toInt()}',
          value: occupationalHazards,
          onChanged: (value) => setState(() => occupationalHazards = value),
          description: '0 = No occupational hazards, 1-3 = Low exposure (safe environment), 4-6 = Moderate exposure (some hazards present), 7-8 = High exposure (significant hazards), 9-10 = Very high exposure (dangerous workplace)',
        ),
        const SizedBox(height: 32),
        _buildNavigationButtons(showBack: true),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Diet & Nutrition',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        // Diet - Red Meat Slider
        _buildSliderField(
          label: 'Red Meat Consumption Frequency: ${dietRedMeat.toInt()}',
          value: dietRedMeat,
          onChanged: (value) => setState(() => dietRedMeat = value),
          description: '0 = Never, 1-3 = Rarely (< 1x/month), 4-6 = Moderate (1-2x/week), 7-8 = Frequent (3-4x/week), 9-10 = Very frequent (Daily+)',
        ),
        const SizedBox(height: 20),
        // Diet - Salted/Processed Slider
        _buildSliderField(
          label: 'Processed & Salted Food Intake: ${dietSaltedProcessed.toInt()}',
          value: dietSaltedProcessed,
          onChanged: (value) => setState(() => dietSaltedProcessed = value),
          description: '0 = Never eat processed, 1-3 = Rarely (< 1x/week), 4-6 = Moderate (2-3x/week), 7-8 = Frequent (4-5x/week), 9-10 = Very frequent (Daily)',
        ),
        const SizedBox(height: 20),
        // Fruit & Veg Intake Slider
        _buildSliderField(
          label: 'Fresh Fruit & Vegetable Intake: ${fruitVegIntake.toInt()}',
          value: fruitVegIntake,
          onChanged: (value) => setState(() => fruitVegIntake = value),
          description: '0 = Never eat fruits/vegetables, 1-3 = <1 serving/day, 4-6 = 2-3 servings/day, 7-8 = 4-5 servings/day, 9-10 = 5+ servings/day (recommended)',
        ),
        const SizedBox(height: 20),
        // Calcium Intake Slider
        _buildSliderField(
          label: 'Daily Calcium Intake: ${calciumIntake.toInt()}',
          value: calciumIntake,
          onChanged: (value) => setState(() => calciumIntake = value),
          description: '0 = None (0 mg), 1-3 = Low (<400 mg/day), 4-6 = Moderate (400-800 mg/day), 7-8 = Good (800-1000 mg/day), 9-10 = Excellent (1000+ mg/day)',
        ),
        const SizedBox(height: 32),
        _buildNavigationButtons(showBack: true, isLastStep: true),
      ],
    );
  }

  Widget _buildSliderField({required String label, required double value, required ValueChanged<double> onChanged, required String description}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: 0,
          max: 10,
          divisions: 10,
          label: value.toInt().toString(),
          onChanged: onChanged,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons({bool showBack = false, bool isLastStep = false}) {
    return Row(
      children: [
        if (showBack)
          SizedBox(
            width: 90,
            child: ElevatedButton(
              onPressed: () => setState(() => currentStep--),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF000000),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Back'),
                  ],
                ),
              ),
            ),
          ),
        const Spacer(),
        SizedBox(
          width: 90,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (isLastStep) {
                  _submitForm();
                } else {
                  setState(() => currentStep++);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isLastStep
                  ? Colors.green[600]
                  : const Color(0xFF000000),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
            child: Center(
              child: isLastStep
                  ? const Text('Finish')
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Next'),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    // Create data dictionary matching the ML model input format
    final int? age = int.tryParse(ageController.text);
    final double? height = double.tryParse(heightController.text);
    final double? weight = double.tryParse(weightController.text);

    if (age == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid age')));
      return;
    }

    Map<String, dynamic> patientData = {
      'Age': age,
      'Gender': gender,
      'Height': height,
      'Weight': weight,
      'Smoking': smoking.toInt(),
      'Alcohol_Use': alcoholUse.toInt(),
      'Family_History': familyHistory,
      'Diet_Red_Meat': dietRedMeat.toInt(),
      'Diet_Salted_Processed': dietSaltedProcessed.toInt(),
      'Fruit_Veg_Intake': fruitVegIntake.toInt(),
      'Physical_Activity': physicalActivity.toInt(),
      'Air_Pollution': airPollution.toInt(),
      'Occupational_Hazards': occupationalHazards.toInt(),
      'BRCA_Mutation': brcaMutation,
      'H_Pylori_Infection': hPyloriInfection,
      'Calcium_Intake': calciumIntake.toInt(),
    };

    try {
      // Show loading indicator
      EasyLoading.show(status: 'Processing your health data...');
      print('Submitting patient data: $patientData');

      // Send patient data to backend API and save prediction to Firestore
      final predictionResponse = await FirebaseFirestoreService().savePrediction(patientData);

      EasyLoading.dismiss();

      if (predictionResponse != null && predictionResponse.success) {
        // Navigate to results screen with the prediction response
        context.push(AppRouter.riskResults, extra: predictionResponse);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to get prediction. Please try again.')));
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Error submitting form: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }
}
