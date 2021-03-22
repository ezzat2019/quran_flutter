import 'package:quran_flutter/feature/quran_page/model/quran_page.dart';


abstract class QuranPageState {
  const QuranPageState();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'QuranPageLoaded }';
}

class InitialQuranPageState extends QuranPageState {
  const InitialQuranPageState() : super();

  @override
  List<Object> get props => [];
}

class QuranPageLoadedState extends QuranPageState {
  final QuranPage quranPage;

  const QuranPageLoadedState({ this.quranPage}) : super();

  QuranPageLoadedState copyWith({QuranPage quranPage}) {
    return QuranPageLoadedState(quranPage:  this.quranPage);
  }

  @override
  List<Object> get props => [quranPage];

  @override
  String toString() => 'QuranPageLoaded { page: ${quranPage.pageNumber} }';
}

class QuranPageJumpedToState extends QuranPageState {
  final QuranPage quranPage;

  const QuranPageJumpedToState({ this.quranPage}) : super();

  QuranPageJumpedToState copyWith({QuranPage quranPage}) {
    return QuranPageJumpedToState(quranPage:  this.quranPage);
  }

  @override
  List<Object> get props => [quranPage];

  @override
  String toString() => 'QuranPageJumpedTo { page: ${quranPage.pageNumber} }';
}
