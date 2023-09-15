import 'package:flutter/material.dart';
import 'package:imc/model/person.dart';
import 'package:imc/repositories/person_repository.dart';
import 'package:imc/shared/widgets/main_drawer.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //chamando o repository e criando lista de tarefas
  PersonRepository personRepository = PersonRepository();
  List<Person> _persons = [];
  @override
  void initState() {
    getRepository();
    super.initState();
  }

  void getRepository() async{
     _persons = await personRepository.getPersons(); 
     setState(() {     
     });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(title: const Text('Lista IMC'),),
      body: ListView.builder(
        itemCount: _persons.length,
        itemBuilder: (BuildContext bc, int index){
        return const Text("imcdata");
      }),
    );
  }
}