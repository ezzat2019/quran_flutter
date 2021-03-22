import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quran_flutter/common/database/ayah_info_service.dart';
import 'package:quran_flutter/feature/home/bloc/home_page/home_page_bloc.dart';
import 'package:quran_flutter/feature/quran_page/bloc/quran_page_event.dart';
import 'package:quran_flutter/feature/quran_page/bloc/quran_page_state.dart';
import 'package:quran_flutter/feature/quran_page/model/quran_page.dart';

import 'package:rxdart/rxdart.dart';

class QuranPageBloc extends HydratedBloc<QuranPageEvent, QuranPageState> {
  final AyahInfoService ayahInfoService;

  final HomePageBloc homePageBloc;
  final QuranPage quranPage;

  QuranPage fetchQuranPage(int page) {
    return QuranPage(
        pageNumber: page, imageUrl: 'assets/images/quran/$page.png');
  }

  QuranPageBloc(
      { this.ayahInfoService,
       this.homePageBloc,
       this.quranPage})
      : super(QuranPageLoadedState(quranPage: quranPage)) {
    //add(JumpToPageEvent(pageNumber: quranPage.pageNumber));
  }

  @override
  QuranPageState fromJson(Map<String, dynamic> json) {
    try {
      final quranPage =
          QuranPage.fromJson(Map<String, dynamic>.from(json['value']));
      return QuranPageJumpedToState(quranPage: quranPage);
    } catch (exception) {
      return null;
    }
  }

  @override
  Stream<Transition<QuranPageEvent, QuranPageState>> transformEvents(
    Stream<QuranPageEvent> events,
    TransitionFunction<QuranPageEvent, QuranPageState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 2)),
      transitionFn,
    );
  }

  @override
  Stream<QuranPageState> mapEventToState(QuranPageEvent event) async* {
    if (event is JumpToPageEvent) {
      yield* _mapJumpToPage(event);
    }

    if (event is LoadPageEvent) {
      yield* _mapLoadPage(event);
    }
  }

  @override
  Map<String, Map<String, dynamic>> toJson(QuranPageState state) {
    try {
      if (state is QuranPageLoadedState) {
        return {'value': state.quranPage.toJson()};
      }
      if (state is QuranPageJumpedToState) {
        return {'value': state.quranPage.toJson()};
      } else {
        return null;
      }
    } catch (exception) {
      return null;
    }
  }

  Stream<QuranPageState> _mapJumpToPage(JumpToPageEvent event) async* {
    final _quranPage = fetchQuranPage(event.pageNumber);
    _quranPage.quranPageInfoList = await ayahInfoService.getQuranPageInfoList(
        pageNumber: _quranPage.pageNumber);
    homePageBloc.quranPage = _quranPage;
    yield QuranPageJumpedToState(quranPage: _quranPage);
  }

  Stream<QuranPageState> _mapLoadPage(LoadPageEvent event) async* {
    final _quranPage = fetchQuranPage(event.pageNumber);
    _quranPage.quranPageInfoList = await ayahInfoService.getQuranPageInfoList(
        pageNumber: _quranPage.pageNumber);
    homePageBloc.quranPage = _quranPage;
    yield QuranPageLoadedState(quranPage: _quranPage);
  }
}
