import 'package:flutter/material.dart';

class HazardExamplesManager extends StatefulWidget {
  final Map<String, dynamic> customHazardExamples;
  final Function(Map<String, dynamic>) onUpdate;

  const HazardExamplesManager({
    super.key,
    required this.customHazardExamples,
    required this.onUpdate,
  });

  @override
  State<HazardExamplesManager> createState() => _HazardExamplesManagerState();
}

class _HazardExamplesManagerState extends State<HazardExamplesManager> {
  late Map<String, dynamic> _examples;
  String _selectedCategory = '';
  String _newHazardName = '';
  List<String> _newHazardChoices = [];
  String _selectedHazardToRemove = '';
  String _selectedHazardToEdit = '';
  List<String> _editingChoices = [];

  @override
  void initState() {
    super.initState();
    _examples = Map.from(widget.customHazardExamples);
    if (_examples.isNotEmpty) {
      _selectedCategory = _examples.keys.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF4A6741)),
        borderRadius: BorderRadius.zero,
        color: const Color(0xFF1A1A1A),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hazard Examples',
            style: TextStyle(
              color: Color(0xFFB8D4A8),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Category Selection
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Select Category',
            ),
            items: _examples.keys.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
                _selectedHazardToRemove = '';
                _selectedHazardToEdit = '';
                _editingChoices.clear();
              });
            },
          ),
          
          const SizedBox(height: 12),
          
          // Actions Row
          Row(
            children: [
              ElevatedButton(
                onPressed: _showAddHazardDialog,
                child: const Text('+ Add Hazard'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _showRemoveHazardDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B1010),
                  foregroundColor: const Color(0xFFFFCCCC),
                ),
                child: const Text('Remove Hazard'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _showEditHazardDialog,
                child: const Text('Edit Hazard'),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Examples List
          _buildExamplesList(),
        ],
      ),
    );
  }

  Widget _buildExamplesList() {
    if (_selectedCategory.isEmpty || !_examples.containsKey(_selectedCategory)) {
      return const Text(
        'No category selected',
        style: TextStyle(color: Color(0xFF888888)),
      );
    }

    final examples = _examples[_selectedCategory] as List<dynamic>;
    
    if (examples.isEmpty) {
      return const Text(
        'No examples in this category',
        style: TextStyle(color: Color(0xFF888888)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: examples.length,
      itemBuilder: (context, index) {
        final example = examples[index];
        final name = example['name'] ?? '';
        final choices = example['choices'] ?? [];
        
        return Card(
          color: const Color(0xFF2A2A2A),
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(
              name,
              style: const TextStyle(color: Color(0xFFE0E0E0)),
            ),
            subtitle: choices.isNotEmpty
                ? Text(
                    'Choices: ${choices.join(', ')}',
                    style: const TextStyle(color: Color(0xFFB8D4A8)),
                  )
                : const Text(
                    'No choices',
                    style: TextStyle(color: Color(0xFF888888)),
                  ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFFB8D4A8)),
                  onPressed: () => _editHazard(name, choices),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFF8B1010)),
                  onPressed: () => _removeHazard(name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddHazardDialog() {
    _newHazardName = '';
    _newHazardChoices.clear();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Hazard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Enter hazard name'),
              onChanged: (value) => _newHazardName = value,
            ),
            const SizedBox(height: 10),
            _buildChoicesInput(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addHazard,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showRemoveHazardDialog() {
    if (_selectedCategory.isEmpty) return;
    
    final examples = _examples[_selectedCategory] as List<dynamic>;
    final hazardNames = examples.map((e) => e['name'] ?? '').toList();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Hazard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedHazardToRemove,
              decoration: const InputDecoration(labelText: 'Select hazard to remove'),
            items: hazardNames.map((name) {
              return DropdownMenuItem<String>(
                value: name,
                child: Text(name),
              );
            }).toList(),
              onChanged: (value) => _selectedHazardToRemove = value ?? '',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _removeHazard,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B1010),
              foregroundColor: const Color(0xFFFFCCCC),
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showEditHazardDialog() {
    if (_selectedCategory.isEmpty) return;
    
    final examples = _examples[_selectedCategory] as List<dynamic>;
    final hazardNames = examples.map((e) => e['name'] ?? '').toList();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Hazard'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedHazardToEdit,
              decoration: const InputDecoration(labelText: 'Select hazard to edit'),
            items: hazardNames.map((name) {
              return DropdownMenuItem<String>(
                value: name,
                child: Text(name),
              );
            }).toList(),
              onChanged: (value) {
                _selectedHazardToEdit = value ?? '';
                final example = examples.firstWhere((e) => e['name'] == value, orElse: () => {});
                _editingChoices = List.from(example['choices'] ?? []);
              },
            ),
            const SizedBox(height: 10),
            _buildChoicesInput(choices: _editingChoices),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _saveHazard,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildChoicesInput({List<String>? choices}) {
    final list = choices ?? _newHazardChoices;
    
    return Column(
      children: [
        const Text('Choices (optional):'),
        const SizedBox(height: 5),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index < list.length) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Choice ${index + 1}'),
                      controller: TextEditingController(text: list[index]),
                      onChanged: (value) => list[index] = value,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color(0xFF8B1010)),
                    onPressed: () {
                      setState(() {
                        list.removeAt(index);
                      });
                    },
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(hintText: 'Add new choice'),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            list.add(value);
                          });
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFFB8D4A8)),
                    onPressed: () {
                      final text = (list.length > 0) ? '' : '';
                      if (text.isNotEmpty) {
                        setState(() {
                          list.add(text);
                        });
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  void _addHazard() {
    if (_newHazardName.isNotEmpty && _selectedCategory.isNotEmpty) {
      final newHazard = {
        'name': _newHazardName,
        'choices': _newHazardChoices,
      };
      
      setState(() {
        _examples[_selectedCategory] = [
          ...(_examples[_selectedCategory] as List<dynamic>),
          newHazard,
        ];
      });
      
      widget.onUpdate(_examples);
      Navigator.pop(context);
    }
  }

  void _removeHazard([String? name]) {
    final hazardName = name ?? _selectedHazardToRemove;
    if (hazardName.isNotEmpty && _selectedCategory.isNotEmpty) {
      setState(() {
        _examples[_selectedCategory] = (_examples[_selectedCategory] as List<dynamic>)
            .where((e) => e['name'] != hazardName)
            .toList();
      });
      
      widget.onUpdate(_examples);
      Navigator.pop(context);
    }
  }

  void _editHazard(String name, List<dynamic> choices) {
    _selectedHazardToEdit = name;
    _editingChoices = List.from(choices);
    _showEditHazardDialog();
  }

  void _saveHazard() {
    if (_selectedHazardToEdit.isNotEmpty && _selectedCategory.isNotEmpty) {
      setState(() {
        final index = (_examples[_selectedCategory] as List<dynamic>)
            .indexWhere((e) => e['name'] == _selectedHazardToEdit);
        if (index != -1) {
          (_examples[_selectedCategory] as List<dynamic>)[index] = {
            'name': _selectedHazardToEdit,
            'choices': _editingChoices,
          };
        }
      });
      
      widget.onUpdate(_examples);
      Navigator.pop(context);
    }
  }
}