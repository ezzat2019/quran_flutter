import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:quran_flutter/common/database/ayah_info_service.dart';
import 'package:quran_flutter/feature/home/bloc/home_page/home_page_bloc.dart';
import 'package:quran_flutter/feature/home/bloc/home_page/home_page_event.dart';
import 'package:quran_flutter/feature/quran_page/bloc/quran_page_bloc.dart';
import 'package:quran_flutter/feature/quran_page/bloc/quran_page_event.dart';
import 'package:quran_flutter/feature/quran_page/model/quran_page.dart';


import 'navigator_view_event.dart';
import 'navigator_view_state.dart';

class NavigatorViewBloc extends Bloc<NavigatorViewEvent, NavigatorViewState> {
  final AyahInfoService ayahInfoService;
  final QuranPageBloc quranPageBloc;
  final HomePageBloc homePageBloc;

  NavigatorViewBloc(
      { this.ayahInfoService,
       this.quranPageBloc,
       this.homePageBloc})
      : super(InitialNavigatorViewState());

  @override
  Stream<NavigatorViewState> mapEventToState(NavigatorViewEvent event) async* {
    final NavigatorViewState currentState = state;

    if (event is NavigatorViewSelectSuraEvent) {
      yield SuraSelectNavigatorViewState(sura: event.sura);
    }

    if (event is NavigatorViewSelectPageEvent) {
      yield PageSelectNavigatorViewState(pageNumber: event.pageNumber);
    }

    if (event is NavigatorViewSelectJuzzEvent) {
      yield JuzzSelectNavigatorViewState(juzzNumber: event.juzzNumber);
    }

    if (event is NavigatorViewConfirmEvent) {
      QuranPage _quranPage;

      if (currentState is PageSelectNavigatorViewState) {
        _quranPage = QuranPage(pageNumber: currentState.pageNumber);
      }

      if (currentState is SuraSelectNavigatorViewState) {
        final _quranPageInfo = await ayahInfoService.getQuranPageInfo(
            suraNumber: currentState.sura.suraNumber);

        _quranPage = QuranPage(pageNumber: _quranPageInfo.pageNumber);
      }

      if (_quranPage != null) {
        homePageBloc.add(HomePageHideNavigatorTappedEvent());
        quranPageBloc.add(JumpToPageEvent(pageNumber: _quranPage.pageNumber));
        yield NavigatorViewConfirmState(pageNumber: _quranPage.pageNumber);
      }
    }
  }
}
