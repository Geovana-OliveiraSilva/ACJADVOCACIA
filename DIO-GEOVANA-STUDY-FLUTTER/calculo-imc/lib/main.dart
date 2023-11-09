import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final txtPeso = TextEditingController();

  final txtAltura = TextEditingController();

  var imagem = 'images/obesidade2.jpg';

  double? imc;

  String? mensagem;

  void calculaImc() {
    var peso = double.tryParse(txtPeso.text) ?? 0;
    var altura = double.tryParse(txtAltura.text) ?? 0;

    setState(() => imc = peso / (altura * altura));

    if (imc! < 18.5)
      setState(() {
        imagem = 'images/abaixo.jpg';
        mensagem = 'Abaixo do peso.';
      });
    else if (imc! < 24.9)
      setState(() {
        imagem = 'images/ideal.jpg';
        mensagem = 'Peso Ideal.';
      });
    else if (imc! < 29.9)
      setState(() {
        imagem = 'images/excesso.jpg';
        mensagem = 'Excesso peso.';
      });
    else if (imc! < 39.9)
      setState(() {
        imagem = 'images/obesidade1.jpg';
        mensagem = 'Obesidade I.';
      });
    else
      setState(() {
        imagem = 'images/obesidade2.jpg';
        mensagem = 'Obesidade II';
      });
  }

  void limpaCampos() {
    setState(() {
      txtPeso.clear();
      txtAltura.clear();
      imc = null;
      mensagem = null;
      imagem = 'images/obesidade2.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Cálculo IMC"),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                // color: Colors.blue,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: txtPeso,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Peso",
                      ),
                    ),
                    TextField(
                      controller: txtAltura,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Altura",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: calculaImc,
                          child: Text("Calcular"),
                        ),
                        ElevatedButton(
                          onPressed: limpaCampos,
                          child: Text("Limpar"),
                        ),
                      ],
                    ),
                    if (imc != null)
                      Text(
                        "Seu IMC é ${imc!.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    if (mensagem != null)
                      Text(
                        mensagem!,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FittedBox(
                child: Container(
                  color: Colors.red,
                  margin: EdgeInsets.all(10),
                  child: Image.asset(imagem),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
