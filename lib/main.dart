//Aluno: Patrick Viegas Rodrigues

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _idade;
  double _altura;
  double _peso;
  int _sexoRadio;
  String _nome;
  bool _fumante;
  bool _cardiaco;
  bool _asmatico;



  final _chaveForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _sexoRadio = 1;
    _fumante = false;
    _cardiaco = false;
    _asmatico = false;

  }

  setSelectedRadio(int value){
    setState(() {
      _sexoRadio = value;
    });
  }

  setCheckBoxFumante(){
    setState(() {
      if(_fumante == false) {
        _fumante = true;
      }else {
        _fumante = false;
      }
    });
  }
  setCheckBoxCardiaco(){
    setState(() {
      if(_cardiaco == false) {
        _cardiaco = true;
      }else {
        _cardiaco = false;
      }
    });
  }

  setCheckBoxAsmatico(){
    setState(() {
      if(_asmatico == false) {
        _asmatico = true;
      }else {
        _asmatico = false;
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: <Widget>[
          Form(
            key: _chaveForm,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Nome', hintText: 'Informe o seu nome'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, informe o seu nome';
                    }
                  },
                  onSaved: (value) {
                    _nome = value;
                  },
                ),
                Row(
                  children: <Widget>[
                    Text("Homem"),
                    Radio(
                      groupValue: _sexoRadio,
                      value: 1,
                      onChanged: (value){
                        print("Radio $value");
                        setSelectedRadio(value);
                      },
                    ),
                    Text("Mulher"),
                    Radio(
                      groupValue: _sexoRadio,
                      value: 2,
                      onChanged: (value){
                        print("Radio $value");
                        setSelectedRadio(value);
                      },
                    ),
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Idade', hintText: 'Informe a sua idade'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, informe a idade';
                    }
                  },
                  onSaved: (value) {
                    _idade = int.parse(value);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura', hintText: 'Informe a sua altura'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor, informe a altura';
                    }
                  },
                  onSaved: (value) {
                    _altura = double.parse(value);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                      labelText: 'Peso',
                      hintText: 'Informe o seu peso'
                  ),
                  validator: (value){
                    if (value.isEmpty){
                      return 'Por favor, informe o peso';
                    }
                  },
                  onSaved: (value){
                    _peso = double.parse(value);
                  },
                ),
                Row(
                  children: <Widget>[
                    Text("Fumante"),
                    Checkbox(
                      value: _fumante,
                      onChanged: (value){
                        setCheckBoxFumante();
                      },
                    ),
                    Text("Cardiaco"),
                    Checkbox(
                      value: _cardiaco,
                      onChanged: (value){
                        setCheckBoxCardiaco();
                      },
                    ),
                    Text("Asmático"),
                    Checkbox(
                      value: _asmatico,
                      onChanged: (value){
                        setCheckBoxAsmatico();
                      },
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text("Calcular"),
                  onPressed: (){
                    if(_chaveForm.currentState.validate()){
                      _chaveForm.currentState.save();
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>CalcularImc(this._nome, this._idade,
                              this._altura,this._peso,this._sexoRadio,
                              this._fumante,this._cardiaco,this._asmatico)));
                    }
                  },
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}

class CalcularImc extends StatelessWidget {

  String _nome;
  int _idade;
  double _altura;
  double _peso;
  int _sexoRadio;
  bool _fumante;
  bool _cardiaco;
  bool _asmatico;

  TextStyle estilo = TextStyle(fontSize: 25 );

  CalcularImc(this._nome, this._idade, this._altura, this._peso, this._sexoRadio,this._fumante,this._cardiaco,this._asmatico);

  String calcular(double altura, double peso){
    return (peso / (altura * altura)).toStringAsPrecision(4);
  }

  String isFumante(){
    if(_fumante == true){
      return "Fumante";
    }else {
      return "Não Fumante";
    }
  }

  String isCardiaco(){
    if(_cardiaco == true){
      return "Cardiaco";
    }else {
      return "Não Cardiaco";
    }
  }

  String isAsmatico(){
    if(_asmatico == true){
      return "Asmático";
    }else {
      return "Não Asmático";
    }
  }


  String definirSexo(int sexo){
    if(sexo == 2){
      return "Feminino";
    }else{
      return "Masculino";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Ficha"),

      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Nome: $_nome" ,style: estilo,),
              Divider(),
              Text("Sexo: "+definirSexo(_sexoRadio), style: estilo,),
              Divider(),
              Text("Idade: $_idade", style: estilo,),
              Divider(),
              Text("IMC: "+calcular(_altura, _peso), style: estilo,),
              Divider(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("Informações Adicionais: ", style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold
                ),),
              ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[

                      Text(isFumante()+", ", style: TextStyle(
                        color: Colors.red, fontSize: 18
                      ),),
                      Text(isCardiaco()+", ", style: TextStyle(
                        color: Colors.red, fontSize: 18
                        )),
                      Text(isAsmatico()+".", style: TextStyle(
                        color: Colors.red, fontSize: 18
                      ),)
                    ],
                  ) ,
                )



            ],
          )
        ],
      ),
    );
  }
}

