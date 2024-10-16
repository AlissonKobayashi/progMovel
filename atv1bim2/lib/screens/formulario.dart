import 'package:atv1bim2/service/transacoes.dart';
import 'package:flutter/material.dart';
import 'package:atv1bim2/service/abstract_api.dart';

class FormularioTransacao extends StatefulWidget {
final ServiceTransacao service;
  FormularioTransacao({required this.service});

  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _values = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transação'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome: '),
                onSaved: (valor) => _name = valor ?? '',
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor:'),
                keyboardType: TextInputType.number,
                onSaved: (valor) => _values = double.parse(valor ?? '0'),
                validator: (valor) {
                  if (valor == null || double.tryParse(valor) == null) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    widget.service.post(Transacao(id: 0, name: _name, values: _values));
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
