import 'package:intl/intl.dart';

class CurrencyFormatter {
  int decimalPoints;
  bool withSymbol;
  CurrencyFormatter({this.decimalPoints = 0, this.withSymbol = true});
  //Korean currency formatter
  NumberFormat get krCurrency => NumberFormat.currency(
      locale: "ko_KR",
      decimalDigits: decimalPoints,
      customPattern: '#,##0\u00A0${withSymbol ? "원" : ""}');

  //Russian currency formatter
  NumberFormat get ruCurrency => NumberFormat.currency(
      locale: "ru_RU",
      decimalDigits: decimalPoints,
      symbol: withSymbol ? '₽' : '');

  //Kazakh currency formatter
  NumberFormat get kzCurrency => NumberFormat.currency(
      locale: "kk_KZ",
      decimalDigits: decimalPoints,
      symbol: withSymbol ? '\u20B8' : '');

  //USD currency formatter
  NumberFormat get enCurrency =>
      NumberFormat.currency(locale: "en_US", decimalDigits: decimalPoints);

  static NumberFormat simpleCurrency =
      NumberFormat.simpleCurrency(locale: "kk_KZ");
  static NumberFormat noSymbolCurrency =
      NumberFormat.currency(locale: "ko_KR", symbol: '');
  static NumberFormat get(int minimumFractionDigits,
      [String locale = "ko_KR"]) {
    simpleCurrency = NumberFormat.simpleCurrency(
        locale: "ko_KR", name: "", decimalDigits: minimumFractionDigits);
    return simpleCurrency;
  }
}

String currencyFormatter(num number,
    {CurrencyLocale locale = CurrencyLocale.KZ,
    int decimalPoints = 0,
    bool withSymbol = true}) {
  switch (locale) {
    case CurrencyLocale.KZ:
      return CurrencyFormatter(
              decimalPoints: decimalPoints, withSymbol: withSymbol)
          .kzCurrency
          .format(number)
          .toString();
    case CurrencyLocale.RU:
      return CurrencyFormatter(
              decimalPoints: decimalPoints, withSymbol: withSymbol)
          .ruCurrency
          .format(number)
          .toString();
    case CurrencyLocale.KR:
      return CurrencyFormatter(
              decimalPoints: decimalPoints, withSymbol: withSymbol)
          .krCurrency
          .format(number)
          .toString();
    case CurrencyLocale.EN:
      return CurrencyFormatter(
              decimalPoints: decimalPoints, withSymbol: withSymbol)
          .enCurrency
          .format(number)
          .toString();
  }
}

calcToPercent(double percent, double price) {
  final value = percent;
  final orgPrice = price;
  double totalPercent = 0.0;
  totalPercent = (value / orgPrice) * 100;
  return totalPercent;
}

calcToPrice(double percent, double price) {
  final percent1 = percent;
  final orgPrice = price;
  double totalPrice = 0.0;
  totalPrice = (percent1 / 100) * orgPrice;
  return totalPrice;
}

enum CurrencyLocale { KZ, RU, KR, EN }
