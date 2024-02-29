import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    late String cep;
     String? _resultado;
     TextEditingController _textController = TextEditingController();

  void _recuperarCep() async {
    cep = _textController.text58;
    String URL = "https://viacep.com.br/ws/${this.cep}/json/";
    http.Response response;
    response = await http.get(Uri.parse(URL));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];

    setState(() {
      _resultado =
          "Resposta:"
          "\n ------------------------------------------------------------"
          "\n Logradouro: ${logradouro} "
          "\n Complemento: ${complemento} "
          "\n Bairro: ${bairro}"
          "\n Localidade: ${localidade}"
          "\n UF: ${uf}";
    });
    // print("resposta: "+ response.statusCode.toString());
    // print("resposta: "+ response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço Web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _textController,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.account_balance),
                  hintText: 'Informa o CEP:',
              ),
            ),

            ElevatedButton(
              onPressed: _recuperarCep,
              child: Text("Consumo de Serviço Web"),
            ),
            Text(_resultado?? ""),
          ],
        ),
      ),
    );
  }
}
