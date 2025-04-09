import 'package:avaliacao_flutter/models/person.dart';
import 'package:avaliacao_flutter/models/ui/addPersonPage.dart';
import 'package:flutter/material.dart';
import 'package:avaliacao_flutter/models/ui/ListPersonPage.dart';
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: HomePage()
      );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<Person> people = [];

  void _navigateToAddPerson() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPersonPage(
          onAddPerson: (newPerson) {
            setState(() {
              people.add(newPerson);
            });
          },
        ),
      ),
    );
  }

  void _goToListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListPeoplePage(people: people),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Inicial")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Text(
              "Por favor adicione um usuario", 
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToAddPerson,
              child: Text("Adicionar usuário"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _goToListPage,
              child: Text("Ver usuários"),
            ),
          ],
        ),
      ),
    );
  }
}
