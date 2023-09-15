import 'package:flutter/material.dart';
import 'package:imc/model/person.dart';
import 'package:imc/pages/list_page.dart';
import 'package:imc/repositories/person_repository.dart';
import 'package:imc/shared/widgets/main_drawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //chamando repository
  PersonRepository personRepository = PersonRepository();

  //variaveis do formulário
  TextEditingController weightController = TextEditingController(text: "");
  TextEditingController heightController = TextEditingController(text: "");
  TextEditingController dateController = TextEditingController(text: "");
  bool saving = false;
  DateTime? calcDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title:  const Text("Calculadora IMC"),
      ),
      body: SingleChildScrollView(
        
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child:saving? const Center(child:CircularProgressIndicator()) : Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const SizedBox( height: 40,),
               //imagem
               Row(
                 children: [
                   Expanded(flex: 1, child: Container()),
                   Expanded(flex: 2, child: Image.asset('lib/images/imc.png')),
                   Expanded(flex: 1, child: Container()),
                 ],
               ),
                const SizedBox( height: 40,),
               //campo para colocar o peso
               SizedBox( 
                  width: double.infinity,
                  height: 30,
                  child: TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.punch_clock_outlined),
                      hintText: 'Peso (Kg)'
                    ),
                  ),
                ),
                const SizedBox( height: 40,),
               //campo para colocar altura
               SizedBox(              
                  width: double.infinity,
                  height: 30,
                  child: TextField(
                    controller: heightController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.punch_clock_outlined),
                      hintText: 'Altura (M)'
                    ),
                  ),
                ),
                const SizedBox( height: 40,),
                //campo para colocar data da pesagem
                SizedBox(              
                  width: double.infinity,
                  height: 30,
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () async{
                      var data = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021,1,1), lastDate: DateTime(2050,1,1));
                      if(data != null){
                        dateController.text = data.toString();
                        calcDate = data;
                      }
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.date_range),
                      hintText: 'Data da pesagem'
                    ),
                  ),
                ),
                 const SizedBox( height: 80,),
                //botão de calcular
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async{
                      setState(() {
                        saving = false;
                      });
                      if(weightController.text.trim().isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preencha o seu peso")));
                      } else if(heightController.text.trim().isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preencha a sua altura")));
                      }else if(dateController.text.trim().isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Preencha a data da pesagem")));
                      }else{
                        Future.delayed(const Duration(seconds: 3),(){
                          setState(() {
                            saving = false;
                          });
                        });
                        
                        await personRepository.setPerson(Person(weightController.text, heightController.text, dateController.text));
                        if (!context.mounted) return;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ListPage()));
                        
                      }
                      
                    },
                    style:  ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ), 
                    child: const Text('CALCULAR',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),)
                  ),
                ),
              
            ]),
          ),
        ),
      )
    );
  }
}