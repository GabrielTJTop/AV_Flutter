import 'package:avaliacao_flutter/models/person.dart';
import 'package:flutter/material.dart';

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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final person = Person(
        imagePath: '', // pode ser modificado para selecionar uma imagem depois
        id: DateTime.now().toString(),
        name: _nameController.text,
        lastName: _lastNameController.text,
        number: _numberController.text,
        cpf: _cpfController.text,
        birthday: DateTime(2000, 1, 1), // você pode usar um DatePicker aqui depois
        registeredAt: DateTime.now(),
      );

      widget.onAddPerson(person);
      Navigator.pop(context);
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
