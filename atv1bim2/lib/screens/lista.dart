import 'package:flutter/material.dart';
import 'package:atv1bim2/service/abstract_api.dart';
import 'package:atv1bim2/service/transacoes.dart';

class ListaTransacoes extends StatelessWidget {
  final ServiceTransacao service;

  ListaTransacoes({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações'),
      ),
      body: FutureBuilder<List<Transacao>>(
        future: service.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar transações'));
          }
          final transacoes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: transacoes.length,
            itemBuilder: (context, index) {
              final transacao = transacoes[index];
              return ListTile(
                title: Text(transacao.name),
                subtitle: Text('R\$ ${transacao.values.toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Lógica para editar
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        service.delete(transacao.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
