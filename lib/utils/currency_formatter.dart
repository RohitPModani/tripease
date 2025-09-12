import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatAmount(double amount, String currency) {
    final formatter = NumberFormat.currency(
      locale: _getLocaleForCurrency(currency),
      symbol: getCurrencySymbol(currency),
      decimalDigits: 2,
    );
    
    final formatted = formatter.format(amount);
    // Add space between symbol and amount if not already present
    final symbol = getCurrencySymbol(currency);
    if (formatted.startsWith(symbol) && !formatted.startsWith('$symbol ')) {
      return formatted.replaceFirst(symbol, '$symbol ');
    }
    return formatted;
  }
  
  static String _getLocaleForCurrency(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return 'en_US';
      case 'EUR':
        return 'de_DE'; // German locale uses 1.000.000,00 format
      case 'GBP':
        return 'en_GB';
      case 'JPY':
        return 'ja_JP';
      case 'INR':
        return 'en_IN'; // Indian locale uses 10,00,000.00 format
      case 'CAD':
        return 'en_CA';
      case 'AUD':
        return 'en_AU';
      case 'CHF':
        return 'de_CH';
      case 'CNY':
        return 'zh_CN';
      case 'KRW':
        return 'ko_KR';
      case 'BRL':
        return 'pt_BR';
      case 'MXN':
        return 'es_MX';
      case 'RUB':
        return 'ru_RU';
      case 'ZAR':
        return 'en_ZA';
      case 'SEK':
        return 'sv_SE';
      case 'NOK':
        return 'nb_NO';
      case 'DKK':
        return 'da_DK';
      case 'PLN':
        return 'pl_PL';
      case 'CZK':
        return 'cs_CZ';
      case 'HUF':
        return 'hu_HU';
      case 'TRY':
        return 'tr_TR';
      case 'ILS':
        return 'he_IL';
      case 'AED':
        return 'ar_AE';
      case 'SAR':
        return 'ar_SA';
      case 'THB':
        return 'th_TH';
      case 'SGD':
        return 'en_SG';
      case 'HKD':
        return 'en_HK';
      case 'NZD':
        return 'en_NZ';
      default:
        return 'en_US'; // Default to US format
    }
  }
  
  static String getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'INR':
        return '₹';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'CHF':
        return 'CHF';
      case 'CNY':
        return '¥';
      case 'KRW':
        return '₩';
      case 'BRL':
        return 'R\$';
      case 'MXN':
        return '\$';
      case 'RUB':
        return '₽';
      case 'ZAR':
        return 'R';
      case 'SEK':
        return 'kr';
      case 'NOK':
        return 'kr';
      case 'DKK':
        return 'kr';
      case 'PLN':
        return 'zł';
      case 'CZK':
        return 'Kč';
      case 'HUF':
        return 'Ft';
      case 'TRY':
        return '₺';
      case 'ILS':
        return '₪';
      case 'AED':
        return 'د.إ';
      case 'SAR':
        return 'ر.س';
      case 'THB':
        return '฿';
      case 'SGD':
        return 'S\$';
      case 'HKD':
        return 'HK\$';
      case 'NZD':
        return 'NZ\$';
      default:
        return currency; // Return the currency code if no symbol found
    }
  }
  
  // Helper method to format amount without currency symbol (useful for input fields)
  static String formatAmountOnly(double amount, String currency) {
    final locale = _getLocaleForCurrency(currency);
    final formatter = NumberFormat.decimalPattern(locale);
    return formatter.format(amount);
  }
  
  // Helper method to parse formatted amount back to double
  static double parseAmount(String formattedAmount, String currency) {
    final locale = _getLocaleForCurrency(currency);
    final formatter = NumberFormat.decimalPattern(locale);
    return formatter.parse(formattedAmount).toDouble();
  }
  
  // Get all supported currencies
  static List<String> getAllSupportedCurrencies() {
    return [
      'USD', 'EUR', 'GBP', 'JPY', 'INR', 'CAD', 'AUD', 'CHF', 'CNY', 'KRW',
      'BRL', 'MXN', 'RUB', 'ZAR', 'SEK', 'NOK', 'DKK', 'PLN', 'CZK', 'HUF',
      'TRY', 'ILS', 'AED', 'SAR', 'THB', 'SGD', 'HKD', 'NZD'
    ];
  }
  
  // Get currency display name with symbol
  static String getCurrencyDisplayName(String currency) {
    final symbol = getCurrencySymbol(currency);
    return '$currency ($symbol)';
  }
}
