import 'package:money_formatter/money_formatter.dart';

extension AmountUtil on String {
  String get formatAmount {
    var amount = double.parse(this);
    var fmf = MoneyFormatter(
        amount: amount,
        settings: MoneyFormatterSettings(
          symbol: ' FCFA',
          thousandSeparator: ' ',
          symbolAndNumberSeparator: '',
          fractionDigits: 0
        )
    );
    return fmf.output.symbolOnRight;
  }
}