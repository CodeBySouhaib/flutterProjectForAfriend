class MissionDetails {
  String pilotName;
  String pilotCode;
  String secondPilotName;
  String secondPilotCode;
  String mechanicName;
  String missionTime;
  String missionType;

  MissionDetails({
    required this.pilotName,
    required this.pilotCode,
    required this.secondPilotName,
    required this.secondPilotCode,
    required this.mechanicName,
    required this.missionTime,
    required this.missionType,
  });

  factory MissionDetails.fromJson(Map<String, dynamic> json) {
    return MissionDetails(
      pilotName: json['pilotName'] ?? '',
      pilotCode: json['pilotCode'] ?? '',
      secondPilotName: json['secondPilotName'] ?? '',
      secondPilotCode: json['secondPilotCode'] ?? '',
      mechanicName: json['mechanicName'] ?? '',
      missionTime: json['missionTime'] ?? '',
      missionType: json['missionType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pilotName': pilotName,
      'pilotCode': pilotCode,
      'secondPilotName': secondPilotName,
      'secondPilotCode': secondPilotCode,
      'mechanicName': mechanicName,
      'missionTime': missionTime,
      'missionType': missionType,
    };
  }

  MissionDetails copyWith({
    String? pilotName,
    String? pilotCode,
    String? secondPilotName,
    String? secondPilotCode,
    String? mechanicName,
    String? missionTime,
    String? missionType,
  }) {
    return MissionDetails(
      pilotName: pilotName ?? this.pilotName,
      pilotCode: pilotCode ?? this.pilotCode,
      secondPilotName: secondPilotName ?? this.secondPilotName,
      secondPilotCode: secondPilotCode ?? this.secondPilotCode,
      mechanicName: mechanicName ?? this.mechanicName,
      missionTime: missionTime ?? this.missionTime,
      missionType: missionType ?? this.missionType,
    );
  }
}