class PredictionResponse {
  final bool success;
  final String? timestamp;
  final PredictionData? prediction;
  final RecommendationData? recommendations;

  PredictionResponse({
    required this.success,
    this.timestamp,
    this.prediction,
    this.recommendations,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      success: json['success'] ?? false,
      timestamp: json['timestamp'],
      prediction: json['prediction'] != null
          ? PredictionData.fromJson(json['prediction'])
          : null,
      recommendations: json['recommendations'] != null
          ? RecommendationData.fromJson(json['recommendations'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'timestamp': timestamp,
      'prediction': prediction?.toJson(),
      'recommendations': recommendations?.toJson(),
    };
  }
}

class PredictionData {
  final double? bmiCalculated;
  final double? confidence;
  final int? obesityScore;
  final String? predictedCancerType;
  final Map<String, double>? probabilities;
  final String? riskLevel;

  PredictionData({
    this.bmiCalculated,
    this.confidence,
    this.obesityScore,
    this.predictedCancerType,
    this.probabilities,
    this.riskLevel,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    return PredictionData(
      bmiCalculated: (json['bmi_calculated'] ?? 0.0).toDouble(),
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      obesityScore: json['obesity_score'],
      predictedCancerType: json['predicted_cancer_type'],
      probabilities: json['probabilities'] != null
          ? Map<String, double>.from(
              (json['probabilities'] as Map).map(
                (key, value) => MapEntry(key, (value as num).toDouble()),
              ),
            )
          : null,
      riskLevel: json['risk_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bmi_calculated': bmiCalculated,
      'confidence': confidence,
      'obesity_score': obesityScore,
      'predicted_cancer_type': predictedCancerType,
      'probabilities': probabilities,
      'risk_level': riskLevel,
    };
  }
}

class RecommendationData {
  final String? cancerType;
  final double? confidence;
  final String? dietPlan;
  final List<String>? foodsToAvoid;
  final List<String>? lifestyleTips;
  final List<String>? recommendedFoods;
  final String? riskLevel;
  final List<String>? supplements;

  RecommendationData({
    this.cancerType,
    this.confidence,
    this.dietPlan,
    this.foodsToAvoid,
    this.lifestyleTips,
    this.recommendedFoods,
    this.riskLevel,
    this.supplements,
  });

  factory RecommendationData.fromJson(Map<String, dynamic> json) {
    return RecommendationData(
      cancerType: json['cancer_type'],
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      dietPlan: json['diet_plan'],
      foodsToAvoid: json['foods_to_avoid'] != null
          ? List<String>.from(json['foods_to_avoid'])
          : null,
      lifestyleTips: json['lifestyle_tips'] != null
          ? List<String>.from(json['lifestyle_tips'])
          : null,
      recommendedFoods: json['recommended_foods'] != null
          ? List<String>.from(json['recommended_foods'])
          : null,
      riskLevel: json['risk_level'],
      supplements: json['supplements'] != null
          ? List<String>.from(json['supplements'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cancer_type': cancerType,
      'confidence': confidence,
      'diet_plan': dietPlan,
      'foods_to_avoid': foodsToAvoid,
      'lifestyle_tips': lifestyleTips,
      'recommended_foods': recommendedFoods,
      'risk_level': riskLevel,
      'supplements': supplements,
    };
  }
}
