import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/team.dart';

class AddTeamScreen extends StatefulWidget {
  final VoidCallback onTeamAdded;

  const AddTeamScreen({Key? key, required this.onTeamAdded}) : super(key: key);

  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _foundationYearController = TextEditingController();
  final _lastChampionshipController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _foundationYearController.dispose();
    _lastChampionshipController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final team = Team(
        name: _nameController.text,
        foundationYear: int.parse(_foundationYearController.text),
        lastChampionship: _lastChampionshipController.text.isEmpty
           ? null
            : _lastChampionshipController.text,
      );
      await DatabaseHelper.instance.insertTeam(team);
      widget.onTeamAdded(); 
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Equipo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _foundationYearController,
                decoration: const InputDecoration(labelText: 'Año de fundación'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un año de fundación';
                  }
                  final year = int.tryParse(value);
                  if (year == null || year < 1900) {
                    return 'Por favor, ingrese un año de fundación válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastChampionshipController,
                decoration: const InputDecoration(labelText: 'Último campeonato'),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
