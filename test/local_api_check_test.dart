import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_pay/core/storage/local_preferences.dart';
import 'package:split_pay/data/datasources/remote/frankfurter_api_service.dart';

void main() {
  test('1. Preferencias locales guardan y leen tema y moneda', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = LocalPreferences();

    await prefs.setDarkMode(true);
    await prefs.setPreferredCurrency('USD');

    expect(await prefs.getDarkMode(), true);
    expect(await prefs.getPreferredCurrency(), 'USD');
  });

  test('2. API Frankfurter trae tasa de cambio real desde internet', () async {
    final api = FrankfurterApiService();
    final rateModel = await api.getExchangeRate(from: 'USD', to: 'EUR');

    print('Tasa real USD -> EUR (${rateModel.date}): ${rateModel.rate}');
    expect(rateModel.rate, greaterThan(0));
  });
}