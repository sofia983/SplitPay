import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyRateModel {
  final String baseCurrency;
  final String targetCurrency;
  final double rate;
  final String date;

  CurrencyRateModel({
    required this.baseCurrency,
    required this.targetCurrency,
    required this.rate,
    required this.date,
  });

  factory CurrencyRateModel.fromJson(
    Map<String, dynamic> json,
    String targetCurrency,
  ) {
    final rates = json['rates'] as Map<String, dynamic>;
    return CurrencyRateModel(
      baseCurrency: json['base'] as String,
      targetCurrency: targetCurrency,
      rate: (rates[targetCurrency] as num).toDouble(),
      date: json['date'] as String,
    );
  }
}

class FrankfurterApiService {
  final http.Client _client;
  final String _baseUrl;

  FrankfurterApiService({
    http.Client? client,
    String baseUrl = 'https://api.frankfurter.app',
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl;

  Future<CurrencyRateModel> getExchangeRate({
    required String from,
    required String to,
    int maxRetries = 2,
  }) async {
    if (from == to) {
      return CurrencyRateModel(
        baseCurrency: from,
        targetCurrency: to,
        rate: 1.0,
        date: DateTime.now().toIso8601String().split('T').first,
      );
    }

    int attempt = 0;
    while (true) {
      attempt++;
      try {
        final uri = Uri.parse('$_baseUrl/latest?from=$from&to=$to');
        final response = await _client
            .get(uri)
            .timeout(const Duration(seconds: 6));

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          return CurrencyRateModel.fromJson(data, to);
        } else {
          throw Exception('Error del servidor HTTP ${response.statusCode}');
        }
      } on TimeoutException {
        if (attempt > maxRetries) {
          throw Exception('Tiempo de espera agotado al consultar divisas.');
        }
      } catch (e) {
        if (attempt > maxRetries) {
          throw Exception('No se pudo obtener la tasa de cambio: $e');
        }
      }
      await Future.delayed(const Duration(milliseconds: 600));
    }
  }
}