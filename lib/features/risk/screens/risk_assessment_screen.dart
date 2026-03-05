import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oncoguardian/features/risk/widgets/risk_text_field.dart';

class RiskAssessmentScreen extends StatefulWidget {
  const RiskAssessmentScreen({super.key});

  @override
  State<RiskAssessmentScreen> createState() => _RiskAssessmentScreenState();
}

class _RiskAssessmentScreenState extends State<RiskAssessmentScreen> {
  int currentStep = 0;
  FamilyHistory? familyHistory;
  SmokingStatus? smokingStatus;
  AlcoholLevel? alcoholLevel;
  Set<HealthCondition> selectedConditions = {};
  ActivityLevel? activityLevel;

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
        Container(
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
                  Column(
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
                            '1',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Personal',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Column(
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
                            '2',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lifestyle',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  Column(
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
                            '3',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Health',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
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
              child: IndexedStack(
                index: currentStep,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Personal Information',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RiskTextField(
                        label: 'Age',
                        hint: 'Enter your age',
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                      const SizedBox(height: 16),
                      RiskTextField(
                        label: 'Gender',
                        hint: 'Enter your gender',
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                      const SizedBox(height: 16),
                      RiskTextField(
                        label: 'Height (inches)',
                        hint: 'Enter your height in inches',
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                      const SizedBox(height: 16),
                      RiskTextField(
                        label: 'Weight (lbs)',
                        hint: 'Enter your weight in pounds',
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                      const SizedBox(height: 16),
                      RiskTextField(
                        label: 'BMI',
                        hint: 'Enter your BMI',
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (String text) {},
                        onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () => setState(() => currentStep++),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF000000),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                              ),
                              child: const Center(
                                child: Row(
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
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lifestyle Information',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Family History of Cancer',
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
                        child: RadioListTile<FamilyHistory>(
                          title: Text('Yes', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          value: FamilyHistory.yes,
                          groupValue: familyHistory,
                          onChanged: (value) => setState(() => familyHistory = value),
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
                        child: RadioListTile<FamilyHistory>(
                          title: Text('No', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          value: FamilyHistory.no,
                          groupValue: familyHistory,
                          onChanged: (value) => setState(() => familyHistory = value),
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
                        child: RadioListTile<FamilyHistory>(
                          title: Text('Unsure', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          value: FamilyHistory.unsure,
                          groupValue: familyHistory,
                          onChanged: (value) => setState(() => familyHistory = value),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Smoking Status',
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
                        child: RadioListTile<SmokingStatus>(
                          title: Text('Never', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          value: SmokingStatus.never,
                          groupValue: smokingStatus,
                          onChanged: (value) => setState(() => smokingStatus = value),
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
                        child: RadioListTile<SmokingStatus>(
                          title: Text('Former', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          value: SmokingStatus.former,
                          groupValue: smokingStatus,
                          onChanged: (value) => setState(() => smokingStatus = value),
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
                        child: RadioListTile<SmokingStatus>(
                          title: Text('Current', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          value: SmokingStatus.current,
                          groupValue: smokingStatus,
                          onChanged: (value) => setState(() => smokingStatus = value),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Alcohol Consumption',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 9),
                      DropdownButtonFormField<AlcoholLevel>(
                        dropdownColor: Colors.grey[400],
                        iconEnabledColor: const Color(0xFF000000),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          filled: true,
                          fillColor: Colors.grey[400],
                          suffixIconColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB),  width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                        ),
                        hint: Text('Select Consumption Level', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                        initialValue: alcoholLevel,
                        items: [
                          DropdownMenuItem(
                            value: AlcoholLevel.none,
                            child: Text('None', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                          DropdownMenuItem(
                            value: AlcoholLevel.light,
                            child: Text('Light (1-3 Drinks / week)', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                          DropdownMenuItem(
                            value: AlcoholLevel.moderate,
                            child: Text('Moderate (4-14 Drinks / week)', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                          DropdownMenuItem(
                            value: AlcoholLevel.heavy,
                            child: Text('Heavy (15+ Drinks / week)', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                        ],
                        onChanged: (value) => setState(() => alcoholLevel = value),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
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
                                      Icon(
                                        Icons.arrow_back,
                                        size: 16,
                                        color: Colors.white,
                                      ),
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
                              onPressed: () => setState(() => currentStep++),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF000000),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                              ),
                              child: const Center(
                                child: Row(
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
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Health & Activity Information',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Existing Health Conditions',
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
                        child: CheckboxListTile(
                          title: Text('Diabetes', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          value: selectedConditions.contains(HealthCondition.diabetes),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                selectedConditions.add(HealthCondition.diabetes);
                              } else {
                                selectedConditions.remove(HealthCondition.diabetes);
                              }
                            });
                          },
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
                        child: CheckboxListTile(
                          title: Text('Heart Disease', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          value: selectedConditions.contains(HealthCondition.heartDisease),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                selectedConditions.add(HealthCondition.heartDisease);
                              } else {
                                selectedConditions.remove(HealthCondition.heartDisease);
                              }
                            });
                          },
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
                        child: CheckboxListTile(
                          title: Text('Obesity', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          value: selectedConditions.contains(HealthCondition.obesity),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                selectedConditions.add(HealthCondition.obesity);
                              } else {
                                selectedConditions.remove(HealthCondition.obesity);
                              }
                            });
                          },
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
                        child: CheckboxListTile(
                          title: Text('Hormonal Disorders', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          value: selectedConditions.contains(HealthCondition.hormonalDisorders),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                selectedConditions.add(HealthCondition.hormonalDisorders);
                              } else {
                                selectedConditions.remove(HealthCondition.hormonalDisorders);
                              }
                            });
                          },
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
                        child: CheckboxListTile(
                          title: Text('Inflammatory Diseases', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          value: selectedConditions.contains(HealthCondition.inflammatoryDiseases),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                selectedConditions.add(HealthCondition.inflammatoryDiseases);
                              } else {
                                selectedConditions.remove(HealthCondition.inflammatoryDiseases);
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Physical Activity Level',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12, height: 1.67),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 9),
                      DropdownButtonFormField<ActivityLevel>(
                        dropdownColor: Colors.grey[400],
                        iconEnabledColor: const Color(0xFF000000),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          filled: true,
                          fillColor: Colors.grey[400],
                          suffixIconColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB),  width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                        ),
                        hint: Text('Select Activity Level', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                        initialValue: activityLevel,
                        items: [
                          DropdownMenuItem(
                            value: ActivityLevel.sedentary,
                            child: Text('Sedentary (little / no exercise)', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                          DropdownMenuItem(
                            value: ActivityLevel.light,
                            child: Text('Light (1-3 days / week)', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                          DropdownMenuItem(
                            value: ActivityLevel.moderate,
                            child: Text('Moderate (3-5 days / week)', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                          DropdownMenuItem(
                            value: ActivityLevel.vigorous,
                            child: Text('Vigorous (6-7 days / week)', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16, height: 1.5)),
                          ),
                        ],
                        onChanged: (value) => setState(() => activityLevel = value),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
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
                                    Icon(
                                      Icons.arrow_back,
                                      size: 16,
                                      color: Colors.white,
                                    ),
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
                              onPressed: () => context.push('/risk/results'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[600],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                              ),
                              child: const Center(child: Text('Finish')),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
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

enum FamilyHistory { yes, no, unsure }

enum SmokingStatus { never, former, current }

enum AlcoholLevel { none, light, moderate, heavy }

enum HealthCondition { diabetes, heartDisease, obesity, hormonalDisorders, inflammatoryDiseases }

enum ActivityLevel { sedentary, light, moderate, vigorous }
