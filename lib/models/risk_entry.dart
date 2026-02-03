class RiskEntry {
  final String id;
  String category;
  String title;
  String description;
  int likelihood;
  int severity;
  double deduction;
  double riskValue;
  double finalRiskValue;

  RiskEntry({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.likelihood,
    required this.severity,
    required this.deduction,
    required this.riskValue,
    required this.finalRiskValue,
  });

  factory RiskEntry.fromJson(Map<String, dynamic> json) {
    return RiskEntry(
      id: json['id'] ?? '',
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      likelihood: json['likelihood'] ?? 1,
      severity: json['severity'] ?? 1,
      deduction: (json['deduction'] ?? 0.0).toDouble(),
      riskValue: (json['riskValue'] ?? 1.0).toDouble(),
      finalRiskValue: (json['finalRiskValue'] ?? 1.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'likelihood': likelihood,
      'severity': severity,
      'deduction': deduction,
      'riskValue': riskValue,
      'finalRiskValue': finalRiskValue,
    };
  }

  RiskEntry copyWith({
    String? id,
    String? category,
    String? title,
    String? description,
    int? likelihood,
    int? severity,
    double? deduction,
    double? riskValue,
    double? finalRiskValue,
  }) {
    return RiskEntry(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      likelihood: likelihood ?? this.likelihood,
      severity: severity ?? this.severity,
      deduction: deduction ?? this.deduction,
      riskValue: riskValue ?? this.riskValue,
      finalRiskValue: finalRiskValue ?? this.finalRiskValue,
    );
  }
}