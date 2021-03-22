import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_flutter/common/database/ayah_info_service.dart';
import 'package:quran_flutter/common/util/flutter_device_type.dart';
import 'package:quran_flutter/feature/home/bloc/home_page/home_page_bloc.dart';
import 'package:quran_flutter/feature/home/bloc/home_page/home_page_event.dart';
import 'package:quran_flutter/feature/home/bloc/home_page/home_page_state.dart';
import 'package:quran_flutter/feature/home/bloc/navigator/navigator_view_bloc.dart';
import 'package:quran_flutter/feature/home/bloc/navigator/navigator_widget.dart';
import 'package:quran_flutter/feature/quran_page/bloc/quran_page_bloc.dart';
import 'package:quran_flutter/feature/quran_page/model/quran_page.dart';
import 'package:quran_flutter/feature/quran_page/widget/quran_page_widget.dart';
import 'package:quran_flutter/generated/l10n.dart';

//import 'package:wakelock/wakelock.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  int _sliderValue = 1;

  @override
  void dispose() {
    if (Device.get().isIos || Device.get().isAndroid) {
      //Wakelock.disable();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Device.get().isIos || Device.get().isAndroid) {
      //Wakelock.enable();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(body: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
              if (state is HideNavigatorViewState) {
                return BlocProvider<QuranPageBloc>(
                  create: (context) {
                    return QuranPageBloc(
                        ayahInfoService:
                            RepositoryProvider.of<AyahInfoService>(context),
                        homePageBloc: BlocProvider.of<HomePageBloc>(context),
                        quranPage:
                            BlocProvider.of<HomePageBloc>(context).quranPage);
                  },
                  child: QuranPageWidget(),
                );
              } else {
                return _overlayView();
              }
            })),
          );
        });
  }

  //Action
  void _showNavigatorAction() {
    BlocProvider.of<HomePageBloc>(context)
        .add(HomePageShowNavigatorTappedEvent());
  }

  void _hideNavigatorAction() {
    BlocProvider.of<HomePageBloc>(context)
        .add(HomePageHideNavigatorTappedEvent());
  }

  //Widget
  Widget _showNavigatorButton() {
    return SizedBox(
        height: 18.0,
        width: 18.0,
        child: IconButton(
          icon: Icon(Icons.arrow_drop_up, color: Colors.black87),
          onPressed: () => {_showNavigatorAction()},
          padding: new EdgeInsets.all(0.0),
        ));
  }

  Widget _hideNavigatorButton() {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
            height: 18.0,
            width: 18.0,
            child: IconButton(
                icon: Icon(Icons.arrow_drop_down, color: Colors.black87),
                onPressed: () => {_hideNavigatorAction()},
                padding: new EdgeInsets.all(0.0))));
  }

  Widget _ayatInfo(QuranPage _quranPage) {
    return Text(
      "${_quranPage.quranPageInfoList.first.suraNumber}. (${_quranPage.quranPageInfoList.first.nameArabic}) ${_quranPage.quranPageInfoList.first.name} \n${S.of(context).page}: ${_quranPage.pageNumber}",
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  // Widget _bottomSlider() {
  //   return Container(
  //       decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
  //       child: Slider(
  //         divisions: constants.endQuranPageNumber,
  //         activeColor: Theme.of(context).primaryColorLight,
  //         inactiveColor: Theme.of(context).accentColor,
  //         min: constants.startQuranPageNumber.toDouble(),
  //         max: constants.endQuranPageNumber.toDouble(),
  //         onChanged: (newValue) {
  //           setState(() {
  //             _sliderValue = newValue.round();
  //           });
  //           BlocProvider.of<QuranPageBloc>(context)
  //             ..add(JumpToPageEvent(pageNumber: newValue.toInt()));
  //         },
  //         value: _quranPage.pageNumber.toDouble(),
  //         label: _quranPage.pageNumber.toString(),
  //       ));
  // }

  Widget _overlayView() {
    return Stack(
      children: <Widget>[
        Container(color: Theme.of(context).accentColor.withOpacity(.3)),
        BlocProvider<QuranPageBloc>(
          create: (context) {
            return QuranPageBloc(
                ayahInfoService:
                    RepositoryProvider.of<AyahInfoService>(context),
                homePageBloc: BlocProvider.of<HomePageBloc>(context),
                quranPage: BlocProvider.of<HomePageBloc>(context).quranPage);
          },
          child: QuranPageWidget(),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
              if (state is InitialHomeViewState) {
                return _initialNavigatorWidget();
              } else {
                return _fullNavigatorWidget();
              }
            })))
      ],
    );
  }

  Widget _initialNavigatorWidget() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).accentColor),
          child: Padding(
              padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 4),
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    _showNavigatorButton(),
                    _ayatInfo(
                        RepositoryProvider.of<HomePageBloc>(context).quranPage)
                  ])))),
      SizedBox(height: 10),
      //_bottomSlider()
    ]);
  }

  Widget _fullNavigatorWidget() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Theme.of(context).accentColor),
          child: Padding(
              padding: EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    BlocProvider<NavigatorViewBloc>(
                      create: (context) {
                        return NavigatorViewBloc(
                            ayahInfoService:
                                RepositoryProvider.of<AyahInfoService>(context),
                            quranPageBloc:
                                RepositoryProvider.of<QuranPageBloc>(context),
                            homePageBloc:
                                RepositoryProvider.of<HomePageBloc>(context));
                      },
                      child: NavigatorWidget(),
                    ),
                    SizedBox(height: 20),
                    _hideNavigatorButton(),
                  ])))),
      SizedBox(height: 50),
    ]);
  }
}
