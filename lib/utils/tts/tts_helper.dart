
import 'package:tts/tts.dart';

import 'dart:async';
import 'dart:io';

/// Singleton tool class for tts

/// Use TtsHelper step:
///
/// Method : #isLanguageAvailable judge language, here language is _languageMap's values like "en-US",instead of the type of 'en' etc..
///
/// Method : #getTtsLanguage  help you convert "en" to "en-US".
///
/// Method : #setLanguage help you set Language , but "en-US" is default value
///
/// use example:
/// TtsHelper.instance.speak("speech content");
/// or
/// TtsHelper.instance.setLanguageAndSpeak("speech content", "en-US");
/// ...
class TtsHelper {

  // Locale to tss language map
  static final Map<String, String> _languageMap = {
    'en': "en-US",
    'zh': "zh-CN",
    "ar": "ar-SA",
    "cs": "cs-CZ",
    "da": "da-DK",
    "de": "de-DE",
    "el": "el-GR",
    "es": "es-ES",
    "fi": "fi-FI",
    "fr": "fr-CA",
    "he": "he-IL",
    "hi": "hi-IN",
    "hu": "hu-HU",
    "id": "id-ID",
    "it": "it-IT",
    "ja": "ja-JP",
    "ko": "ko-KR",
    "nl": "nl-BE",
    "no": "no-NO",
    "pl": "pl-PL",
    "pt": "pt-BR",
    "ro": "ro-RO",
    "ru": "ru-RU",
    "sk": "sk-SK",
    "sv": "sv-SE",
    "th": "th-TH",
    "tr": "tr-TR",
    'en-US': "en-US",
    'zh-CN': "zh-CN",
    "ar-SA": "ar-SA",
    "cs-CZ": "cs-CZ",
    "da-DK": "da-DK",
    "de-DE": "de-DE",
    "el-GR": "el-GR",
    "es-ES": "es-ES",
    "fi-FI": "fi-FI",
    "fr-CA": "fr-CA",
    "he-IL": "he-IL",
    "hi-IN": "hi-IN",
    "hu-HU": "hu-HU",
    "id-ID": "id-ID",
    "it-IT": "it-IT",
    "ja-JP": "ja-JP",
    "ko-KR": "ko-KR",
    "nl-BE": "nl-BE",
    "no-NO": "no-NO",
    "pl-PL": "pl-PL",
    "pt-BR": "pt-BR",
    "ro-RO": "ro-RO",
    "ru-RU": "ru-RU",
    "sk-SK": "sk-SK",
    "sv-SE": "sv-SE",
    "th-TH": "th-TH",
    "tr-TR": "tr-TR",
  };

  static final String _defaultL = "en-US";
  List<String> _languages;
  static TtsHelper _instance;
  static TtsHelper get instance => _getInstance();

  factory TtsHelper() =>_getInstance();

  static TtsHelper _getInstance() {
    if (_instance == null) {
      _instance = new TtsHelper._internal();
    }
    return _instance;
  }

  TtsHelper._internal() {
    // Initialize
    _initPlatformState();
  }

  _initPlatformState() async {
    _languages = await Tts.getAvailableLanguages();

    // If getAvailableLanguages is null, add "en-US" to _languages.
    if (_languages == null) {
      _languages = [_defaultL];
    }
    // Default set en-US language
    _setLanguage(_defaultL);
  }

  String _getTtsLanguage(String localeStr) {
    if(localeStr == null || localeStr.isEmpty ||
        !_languageMap.containsKey(localeStr)) {
      return _defaultL;
    }
    return _languageMap[localeStr];
  }

  // Return whether the result if set language is successful
  Future<bool> _setLanguage (String lang) async {
    String language = _getTtsLanguage(lang);
    if (language == null || language.isEmpty) {
      language = _defaultL;
    }
    if(Platform.isIOS && !_languages.contains(language)) {
      return false;
    }
    final bool isSet = await Tts.setLanguage(language);
    return isSet;
  }

  // Returns whether the supported language is supported
  Future<bool> _isLanguageAvailable (String language) async {
    final bool isSupport = await Tts.isLanguageAvailable(language);
    return isSupport;
  }

  void speak (String text) async {
    if (text == null || text.isEmpty) { return;}
    Tts.speak(text);
  }

  void setLanguageAndSpeak(String text, String language) async {
    String ttsL = _getTtsLanguage(language);
    var setResult = await _setLanguage(ttsL);
    if(setResult != null) {
      var available = await _isLanguageAvailable(ttsL);
      if(available != null) {
        speak(text);
      }
    }
  }

}