// lib/utils/helpers.dart
String getLanguageName(String code) {
  switch (code) {
    case 'tr':
      return 'Turkish';
    case 'en':
      return 'English';
    case 'de':
      return 'German';
    case 'fr':
      return 'French';
    default:
      return 'English';
  }
}
