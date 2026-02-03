import 'package:flutter/material.dart';
import 'package:orm_risk_assessment/models/mission_details.dart';

class MissionDetailsForm extends StatefulWidget {
  final MissionDetails missionDetails;
  final Function(MissionDetails) onSave;

  const MissionDetailsForm({
    super.key,
    required this.missionDetails,
    required this.onSave,
  });

  @override
  State<MissionDetailsForm> createState() => _MissionDetailsFormState();
}

class _MissionDetailsFormState extends State<MissionDetailsForm> {
  late MissionDetails _currentDetails;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentDetails = widget.missionDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF4A6741)),
        borderRadius: BorderRadius.zero,
        gradient: const LinearGradient(
          colors: [Color(0xFF1C3D2C), Color(0xFF0F2419)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mission & Crew Information',
              style: TextStyle(
                color: Color(0xFFD4E8C8),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Pilot Information Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _currentDetails.pilotName,
                    decoration: const InputDecoration(
                      labelText: 'Pilot Name',
                      hintText: 'Pilot Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilot Name is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _currentDetails = _currentDetails.copyWith(pilotName: value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: _currentDetails.pilotCode,
                    decoration: const InputDecoration(
                      labelText: 'Pilot Code',
                      hintText: 'Pilot Code',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilot Code is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _currentDetails = _currentDetails.copyWith(pilotCode: value);
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            
            // Second Pilot Information Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _currentDetails.secondPilotName,
                    decoration: const InputDecoration(
                      labelText: 'Second Pilot Name',
                      hintText: 'Second Pilot Name',
                    ),
                    onChanged: (value) {
                      _currentDetails = _currentDetails.copyWith(secondPilotName: value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: _currentDetails.secondPilotCode,
                    decoration: const InputDecoration(
                      labelText: 'Second Pilot Code',
                      hintText: 'Second Pilot Code',
                    ),
                    onChanged: (value) {
                      _currentDetails = _currentDetails.copyWith(secondPilotCode: value);
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            
            // Mechanic Name
            TextFormField(
              initialValue: _currentDetails.mechanicName,
              decoration: const InputDecoration(
                labelText: 'Mechanic Name',
                hintText: 'Mechanic Name',
              ),
              onChanged: (value) {
                _currentDetails = _currentDetails.copyWith(mechanicName: value);
              },
            ),
            
            const SizedBox(height: 10),
            
            // Mission Details Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _currentDetails.missionTime,
                    decoration: const InputDecoration(
                      labelText: 'Mission Date',
                      hintText: 'YYYY-MM-DD',
                    ),
                    onChanged: (value) {
                      _currentDetails = _currentDetails.copyWith(missionTime: value);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    initialValue: _currentDetails.missionType,
                    decoration: const InputDecoration(
                      labelText: 'Mission Type',
                      hintText: 'Mission Type',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mission Type is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _currentDetails = _currentDetails.copyWith(missionType: value);
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Save Button
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSave(_currentDetails);
                    }
                  },
                  child: const Text('Save Mission Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}