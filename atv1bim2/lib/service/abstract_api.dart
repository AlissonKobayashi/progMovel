import 'dart:convert';

import 'package:http/http.dart' as http;
import 'transacoes.dart';
import 'service_api.dart';

class ServiceTransacao implements ServicoApi<Transacao> {
  final String apiUrl = 'http://localhost:3000/transações';
  final String _resource;
  ServiceTransacao(this._resource);

  @override
  Future<List<Transacao>> getAll() async {
    final resposta = await http.get(Uri.parse('$apiUrl/$_resource'));
    if (resposta.statusCode == 200) {
      List jsonResponse = json.decode(resposta.body);
      return jsonResponse.map((dados) => Transacao.fromJson(dados)).toList();
    } else {
      throw Exception('Falha ao carregar transações');
    }
  }

  @override
  Future<Transacao> getById(int id) async {
    final resposta = await http.get(Uri.parse('$apiUrl/$_resource/$id'));
    if (resposta.statusCode == 200) {
      return Transacao.fromJson(json.decode(resposta.body));
    } else {
      throw Exception('Falha ao carregar transação');
    }
  }

  @override
  Future<void> post(Transacao transacao) async {
    final resposta = await http.post(
      Uri.parse('$apiUrl/$_resource'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(transacao.toJson()),
    );
    if (resposta.statusCode != 201) {
      throw Exception('Falha ao criar transação');
    }
  }

  @override
  Future<void> patch(int id, Transacao transacao) async {
    final resposta = await http.put(
      Uri.parse('$apiUrl/$_resource/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(transacao.toJson()),
    );
    if (resposta.statusCode != 200) {
      throw Exception('Falha ao atualizar transação');
    }
  }

  @override
  Future<void> delete(int id) async {
    final resposta = await http.delete(Uri.parse('$apiUrl/$_resource/$id'));
    if (resposta.statusCode != 200) {
      throw Exception('Falha ao excluir transação');
    }
  }
}
