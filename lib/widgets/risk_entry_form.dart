import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:orm_risk_assessment/models/risk_entry.dart';
import 'package:orm_risk_assessment/utils/risk_calculator.dart';

class RiskEntryForm extends StatefulWidget {
  final RiskEntry riskEntry;
  final Function(RiskEntry) onUpdate;
  final VoidCallback onRemove;

  const RiskEntryForm({
    super.key,
    required this.riskEntry,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  State<RiskEntryForm> createState() => _RiskEntryFormState();
}

class _RiskEntryFormState extends State<RiskEntryForm> {
  late RiskEntry _currentEntry;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _deductionController;

  @override
  void initState() {
    super.initState();
    _currentEntry = widget.riskEntry;
    _titleController = TextEditingController(text: _currentEntry.title);
    _descriptionController = TextEditingController(text: _currentEntry.description);
    _deductionController = TextEditingController(text: _currentEntry.deduction.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deductionController.dispose();
    super.dispose();
  }

  void _updateRiskEntry() {
    final riskValue = _currentEntry.likelihood * _currentEntry.severity;
    final finalRiskValue = riskValue - _currentEntry.deduction;
    
    _currentEntry = _currentEntry.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
      riskValue: riskValue.toDouble(),
      finalRiskValue: finalRiskValue.toDouble(),
    );
    
    widget.onUpdate(_currentEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => widget.onRemove(),
            backgroundColor: const Color(0xFF8B1010),
            foregroundColor: const Color(0xFFFFCCCC),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4A6741)),
          borderRadius: BorderRadius.zero,
          color: const Color(0xFF1A1A1A),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Risk Title
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Risk Title',
                hintText: 'Risk Title',
              ),
              onChanged: (value) {
                _currentEntry = _currentEntry.copyWith(title: value);
                _updateRiskEntry();
              },
            ),
            
            const SizedBox(height: 8),
            
            // Category and Risk Values Row
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _currentEntry.category,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    items: RiskCalculator.getCategories().map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _currentEntry = _currentEntry.copyWith(category: value);
                        _updateRiskEntry();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _currentEntry.likelihood,
                    decoration: const InputDecoration(
                      labelText: 'Likelihood',
                    ),
                    items: RiskCalculator.getLikelihoodOptions().map((option) {
                      return DropdownMenuItem(
                        value: option['value'] as int,
                        child: Text('${option['value']} - ${option['label']}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _currentEntry = _currentEntry.copyWith(likelihood: value);
                        _updateRiskEntry();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _currentEntry.severity,
                    decoration: const InputDecoration(
                      labelText: 'Severity',
                    ),
                    items: RiskCalculator.getSeverityOptions().map((option) {
                      return DropdownMenuItem(
                        value: option['value'] as int,
                        child: Text('${option['value']} - ${option['label']}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        _currentEntry = _currentEntry.copyWith(severity: value);
                        _updateRiskEntry();
                      }
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Description and Deduction Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Description',
                    ),
                    onChanged: (value) {
                      _currentEntry = _currentEntry.copyWith(description: value);
                      _updateRiskEntry();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _deductionController,
                    decoration: const InputDecoration(
                      labelText: 'Deduction',
                      hintText: 'Deduction',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      double deduction = 0;
                      try {
                        deduction = double.parse(value);
                      } catch (e) {
                        deduction = 0;
                      }
                      _currentEntry = _currentEntry.copyWith(deduction: deduction);
                      _deductionController.text = deduction.toString();
                      _updateRiskEntry();
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Risk Values Display
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF4A6741)),
                      borderRadius: BorderRadius.zero,
                      color: const Color(0xFF2D5016),
                    ),
                    child: Text(
                      'Risk Value: ${_currentEntry.riskValue}',
                      style: const TextStyle(
                        color: Color(0xFFD4E8C8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF4A6741)),
                      borderRadius: BorderRadius.zero,
                      color: _getRiskColor(_currentEntry.finalRiskValue),
                    ),
                    child: Text(
                      'Residual Risk Value: ${_currentEntry.finalRiskValue}',
                      style: TextStyle(
                        color: _getRiskTextColor(_currentEntry.finalRiskValue),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRiskColor(double finalRiskValue) {
    if (finalRiskValue >= 21 && finalRiskValue <= 25) return const Color(0xFF000000);
    if (finalRiskValue >= 15 && finalRiskValue <= 20) return const Color(0xFF8B1010);
    if (finalRiskValue >= 10 && finalRiskValue <= 14) return const Color(0xFF8B4500);
    if (finalRiskValue >= 5 && finalRiskValue <= 9) return const Color(0xFF8B5A00);
    return const Color(0xFF2D5016);
  }

  Color _getRiskTextColor(double finalRiskValue) {
    if (finalRiskValue >= 21 && finalRiskValue <= 25) return const Color(0xFFFF6B6B);
    if (finalRiskValue >= 15 && finalRiskValue <= 20) return const Color(0xFFFFCCCC);
    if (finalRiskValue >= 10 && finalRiskValue <= 14) return const Color(0xFFFFE8C8);
    if (finalRiskValue >= 5 && finalRiskValue <= 9) return const Color(0xFFFFE8C8);
    return const Color(0xFFD4E8C8);
  }
}