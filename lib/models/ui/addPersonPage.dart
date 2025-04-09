import 'dart:io';
import 'package:avaliacao_flutter/models/person.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPersonPage extends StatefulWidget {
  final Function(Person) onAddPerson;

  AddPersonPage({required this.onAddPerson});

  @override
  _AddPersonPageState createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _numberController = TextEditingController();
  final _cpfController = TextEditingController();
  DateTime? _selectedBirthday;
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthday = pickedDate;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedBirthday != null) {
      final person = Person(
        imagePath: _imageFile?.path ?? '',
        id: DateTime.now().toIso8601String(),
        name: _nameController.text,
        lastName: _lastNameController.text,
        number: _numberController.text,
        cpf: _cpfController.text,
        birthday: _selectedBirthday!,
        registeredAt: DateTime.now(),
      );

      widget.onAddPerson(person);
      Navigator.pop(context);
    } else if (_selectedBirthday == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione a data de nascimento')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Pessoa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_imageFile != null)
                Image.file(_imageFile!, height: 150)
              else
                Placeholder(fallbackHeight: 150),
              TextButton(
                onPressed: _pickImage,
                child: Text("Selecionar imagem"),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Sobrenome'),
              ),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: _cpfController,
                decoration: InputDecoration(labelText: 'CPF'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(_selectedBirthday != null
                      ? 'Nascimento: ${_selectedBirthday!.toLocal().toString().split(" ")[0]}'
                      : 'Nenhuma data selecionada'),
                  Spacer(),
                  TextButton(
                    onPressed: _pickBirthday,
                    child: Text('Selecionar Data'),
                  )
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
