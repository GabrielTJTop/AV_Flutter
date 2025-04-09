import 'package:avaliacao_flutter/models/person.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class ListPeoplePage extends StatelessWidget {
  final List<Person> people;

  ListPeoplePage({required this.people});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Pessoas')),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            leading: person.imagePath.isNotEmpty
                ? Image.file(File(person.imagePath), width: 50, height: 50, fit: BoxFit.cover)
                : Icon(Icons.person),
            title: Text('${person.name} ${person.lastName}'),
            subtitle: Text(
              'Nascimento: ${person.birthday.toLocal().toString().split(" ")[0]}\n'
              'CPF: ${person.cpf} - Telefone: ${person.number}',
            ),
          );
        },
      ),
    );
  }
}
