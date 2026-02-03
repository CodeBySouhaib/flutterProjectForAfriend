import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:orm_risk_assessment/models/risk_entry.dart';
import 'package:orm_risk_assessment/models/mission_details.dart';

class DataService {
  static const String _missionDetailsKey = 'missionDetails';
  static const String _riskEntriesKey = 'riskEntries';
  static const String _customHazardExamplesKey = 'customHazardExamples';

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<MissionDetails> getMissionDetails() async {
    final prefs = await _getPrefs();
    final json = prefs.getString(_missionDetailsKey);
    
    if (json != null) {
      return MissionDetails.fromJson(jsonDecode(json));
    }
    
    // Return default mission details
    return MissionDetails(
      pilotName: '',
      pilotCode: '',
      secondPilotName: '',
      secondPilotCode: '',
      mechanicName: '',
      missionTime: '',
      missionType: '',
    );
  }

  Future<void> saveMissionDetails(MissionDetails details) async {
    final prefs = await _getPrefs();
    final json = jsonEncode(details.toJson());
    await prefs.setString(_missionDetailsKey, json);
  }

  Future<List<RiskEntry>> getRiskEntries() async {
    final prefs = await _getPrefs();
    final json = prefs.getString(_riskEntriesKey);
    
    if (json != null) {
      final List<dynamic> list = jsonDecode(json);
      return list.map((item) => RiskEntry.fromJson(item)).toList();
    }
    
    return [];
  }

  Future<void> saveRiskEntries(List<RiskEntry> entries) async {
    final prefs = await _getPrefs();
    final json = jsonEncode(entries.map((entry) => entry.toJson()).toList());
    await prefs.setString(_riskEntriesKey, json);
  }

  Future<Map<String, dynamic>> getCustomHazardExamples() async {
    final prefs = await _getPrefs();
    final json = prefs.getString(_customHazardExamplesKey);
    
    if (json != null) {
      return jsonDecode(json);
    }
    
    // Return default examples
    return {
      "PLANNING": [
        {"name": "Time is enough", "choices": []},
        {"name": "Lack of detailed information / instructions / adequate briefing / aids pictures", "choices": []},
        {"name": "No adequate aviation threat assessment", "choices": []},
        {"name": "Unfamiliar with briefing material / RFM / checklists", "choices": []},
        {"name": "Discrepancies between briefing material / RFM / checklists", "choices": []},
        {"name": "Landing area unsuitable for an EOL", "choices": []},
        {"name": "Aircraft Handling", "choices": []}
      ],
      "EVENT/MISSION": [
        {"name": "SOP / policy related", "choices": []},
        {"name": "Mission specification", "choices": []},
        {"name": "New airport/landing strip", "choices": []},
        {"name": "Last minute changes", "choices": []},
        {"name": "Speed/rotor RPM deviations", "choices": []},
        {"name": "Intellectual abilities alteration", "choices": []},
        {"name": "Other aircraft in the intended flight path", "choices": []},
        {"name": "Failure to execute engine power recovery when necessary", "choices": []},
        {"name": "Wind / air / temperature", "choices": []}
      ],
      "ASSET/RESOURCES": [
        {"name": "Equipment stability", "choices": []},
        {"name": "Main and substitute aircraft available", "choices": []},
        {"name": "Crew/team lack of time", "choices": []},
        {"name": "Unfamiliar with the area", "choices": []},
        {"name": "Fatigue", "choices": []},
        {"name": "Rest", "choices": []},
        {"name": "Asset suitability", "choices": []},
        {"name": "Status of the equipment on board - ground", "choices": []},
        {"name": "Aircraft Handling", "choices": []},
        {"name": "Intellectual abilities alteration", "choices": []},
        {"name": "Crew miscommunication", "choices": []},
        {
          "name": "Instructor pilot experience",
          "choices": [
            "less than 1000 total flight hours",
            "between 1000 and 2000 total flight hours",
            "more than 2000 total flight hours"
          ]
        },
        {
          "name": "Qualifications",
          "choices": [
            "less than 12 flight hours last 45 days",
            "between 12 and 24 flight hours last 45 days",
            "more than 24 flight hours last 45 days"
          ]
        }
      ],
      "COMMS/SUPERVISION": [
        {"name": "No point of contact at destination", "choices": []},
        {"name": "Comms available range", "choices": []},
        {"name": "Comms available range due to obstacles", "choices": []},
        {"name": "No adequate equipment", "choices": []},
        {"name": "No ground staff", "choices": []},
        {"name": "Non-essential conversation at inappropriate times", "choices": []}
      ],
      "ENVIRONMENT/GROUND FACILITIES": [
        {"name": "Handling services available", "choices": []},
        {"name": "Weather", "choices": []},
        {"name": "Night illumination", "choices": []},
        {"name": "Cockpit temperature", "choices": []},
        {"name": "Obstruction", "choices": []},
        {"name": "Security threat", "choices": []},
        {"name": "Facilities / support at destination", "choices": []},
        {"name": "Terrain assessment", "choices": []}
      ]
    };
  }

  Future<void> saveCustomHazardExamples(Map<String, dynamic> examples) async {
    final prefs = await _getPrefs();
    final json = jsonEncode(examples);
    await prefs.setString(_customHazardExamplesKey, json);
  }
}