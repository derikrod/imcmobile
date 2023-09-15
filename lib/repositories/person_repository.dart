import 'package:imc/model/person.dart';

class PersonRepository{
   final List<Person> _persons = [];
   Future<void> setPerson(Person p) async{
    await Future.delayed(const Duration(seconds: 1));
    _persons.add(p);
   }
 Future<List<Person>>getPersons() async{
     await Future.delayed(const Duration(seconds: 1));
    return _persons;
   }
}