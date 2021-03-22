import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'quran_page_info.dart';

part 'quran_page.g.dart';

class QuranPage extends Equatable {
  int pageNumber;
  final String imageUrl;
  List<QuranPageInfo> quranPageInfoList;

  @required
  QuranPage({ this.pageNumber, this.imageUrl, this.quranPageInfoList});

  //Equatable
  @override
  List<Object> get props => [pageNumber, imageUrl, quranPageInfoList];

  //json encoding decoding
  factory QuranPage.fromJson(Map<String, dynamic> json) =>
      _$QuranPageFromJson(json);

  Map<String, dynamic> toJson() => _$QuranPageToJson(this);
}
