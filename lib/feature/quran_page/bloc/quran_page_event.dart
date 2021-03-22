import 'package:equatable/equatable.dart';

abstract class QuranPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// class QuranPageStartEvent extends QuranPageEvent {}

class LoadPageEvent extends QuranPageEvent {
  final int pageNumber;

  LoadPageEvent({ this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}

class JumpToPageEvent extends QuranPageEvent {
  final int pageNumber;

  JumpToPageEvent({ this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}
