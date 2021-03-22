import 'package:meta/meta.dart';
import 'package:quran_flutter/feature/sura/model/sura.dart';


@immutable
abstract class NavigatorViewState {
  const NavigatorViewState();

  @override
  List<Object> get props => [];
}

class InitialNavigatorViewState extends NavigatorViewState {}

class ShowSuraListNavigatorViewState extends NavigatorViewState {
  final List<Sura> suraList;

  ShowSuraListNavigatorViewState({ this.suraList});

  @override
  List<Object> get props => [suraList];
}

class SuraSelectNavigatorViewState extends NavigatorViewState {
  final Sura sura;

  SuraSelectNavigatorViewState({ this.sura});

  @override
  List<Object> get props => [sura];
}

class PageSelectNavigatorViewState extends NavigatorViewState {
  final int pageNumber;

  PageSelectNavigatorViewState({ this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class JuzzSelectNavigatorViewState extends NavigatorViewState {
  final int juzzNumber;

  JuzzSelectNavigatorViewState({ this.juzzNumber});

  @override
  List<Object> get props => [juzzNumber];
}

class NavigatorViewConfirmState extends NavigatorViewState {
  final int pageNumber;

  NavigatorViewConfirmState({ this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}
