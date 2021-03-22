import 'package:meta/meta.dart';
import 'package:quran_flutter/feature/sura/model/sura.dart';


@immutable
abstract class NavigatorViewEvent {
  const NavigatorViewEvent();

  @override
  List<Object> get props => [];
}

class NavigatorViewCancelEvent extends NavigatorViewEvent {}

class NavigatorViewSelectSuraEvent extends NavigatorViewEvent {
  final Sura sura;

  NavigatorViewSelectSuraEvent({ this.sura});

  @override
  List<Object> get props => [sura];
}

class NavigatorViewSelectPageEvent extends NavigatorViewEvent {
  final int pageNumber;

  NavigatorViewSelectPageEvent({ this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class NavigatorViewSelectJuzzEvent extends NavigatorViewEvent {
  final int juzzNumber;

  NavigatorViewSelectJuzzEvent({ this.juzzNumber});

  @override
  List<Object> get props => [juzzNumber];
}

class NavigatorViewConfirmEvent extends NavigatorViewEvent {}
