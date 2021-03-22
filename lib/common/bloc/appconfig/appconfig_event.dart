import 'package:equatable/equatable.dart';

enum ThemeType { normal }

enum LanguageType { bangla, english }

abstract class AppConfigEvent extends Equatable {
  const AppConfigEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppConfigEvent {}

class ThemeChanged extends AppConfigEvent {
  const ThemeChanged({ this.themeType});

  final ThemeType themeType;

  @override
  List<Object> get props => <ThemeType>[themeType];
}

class LanguageChanged extends AppConfigEvent {
  const LanguageChanged({ this.languageType});

  final LanguageType languageType;

  @override
  List<Object> get props => <LanguageType>[languageType];
}
