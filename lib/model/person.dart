import 'package:flutter/material.dart';

class Person{
  final String _id = UniqueKey().toString();
  String _bodyweight = "";
  String _bodyheight = "";
  String _imcdate = "";
  String _imccalc = "";
  
  Person(this._bodyweight,this._bodyheight,this._imcdate){
    setimcalc();
  }
  //retorna o id da classe Person
  String getid(){
    return _id;
  }

  //retorna a altura da Pessoa
  String getbodyheight(){
    return _bodyheight;
  }

  //retorna o peso da Pessoa
  String getbodyweight(){
    return _bodyweight;
  }

  // retorna a data da pesagem
  String getimcdate(){
    return _imcdate;
  }
  // função que retorna o calculo IMC
  String getimccalc(){
    return _imccalc;
  }
  // função para calcular o IMC
  void setimcalc(){
    double w = double.parse(getbodyheight());
    double h = double.parse(getbodyheight());
    double imc = w/h;
    String report = "";
    if(imc > 0){
        if(imc < 16){
          report = 'Magreza grave';
        }else if(imc > 16 && imc < 17){
          report = 'Magreza moderada';
        }else if(imc >= 17 && imc < 18.5){
          report = 'Magreza leve';
        }else if(imc >= 18.5 && imc <=25){
          report = 'Saudável';
        }else if(imc >= 25 && imc < 30){
          report = 'Sobrepeso';
        }else if(imc >= 30 && imc < 35){
          report = 'Obesidade grau I';
        }else if(imc >= 35 && imc < 40){
          report = 'Obesidade grau II (Severa)';
        }else{
          report = 'Obesidade grau III (Mórbida)';
        }
      }else{
        report = 'Dados inválidos';  
      }
    _imccalc = "$imc $report";
  }
  //
  void setbodyheight(String bodyheight){
    _bodyheight = bodyheight;
  }

  
  void setbodyweight(String bodyweight){
    _bodyweight = bodyweight;
  }

  void setimcdate(String imcdate){
    _imcdate = imcdate;
  }


}