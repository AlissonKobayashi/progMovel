import 'dart:developer';

import 'package:atv1bim2/service/abstract_api.dart';
import 'package:flutter/material.dart';
import 'screens/formulario.dart';
import 'service/transacoes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro Bancário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 11, 136, 209)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Registro Bancário'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transacao> _transacoes = [];
  void _adicionarNovaTransacao() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  FormularioTransacao()),
      ),
    ).then((result) {
      if (result != null && result is Transacao) {
        setState(() {
          _transacoes.add(result);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Transações registradas:',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _transacoes.length,
                itemBuilder: (context, index) {
                  final transacao = _transacoes[index];
                  return ListTile(
                    title: Text(transacao.name),
                    subtitle: Text('valor: ${transacao.values}'),
                    onTap: () {
                      //falta fazer
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarNovaTransacao,
        tooltip: 'Nova Transação',
        child: const Icon(Icons.add),
      ),
    );
  }
}