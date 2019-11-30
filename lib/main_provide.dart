import 'dart:async';

import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/main/splash_model.dart';
import 'package:innetsect/model/main_repository.dart';
import 'package:rxdart/rxdart.dart';

///继承基础数据状态封装类，从而提供根页面的数据状态
class MainProvide extends BaseProvide {
  ///工厂模式
  factory MainProvide() => _getInstance();
  static MainProvide get instance => _getInstance();
  static MainProvide _instance;
  static MainProvide _getInstance() {
    if (_instance == null) {
      _instance = new MainProvide._internal();
    }
    return _instance;
  }

  MainProvide._internal() {
    print('MainProvide初始化');
    // 初始化
  }
//欢迎定时器在秒
  int WELCOME_TIMER_OUT_IN_SECS = 3;

  String _openImage="";
  String get openImage =>_openImage;
  set openImage(String openImage){
    _openImage = openImage;
    notifyListeners();
  }
  SplashModel _splashModel;
  SplashModel get splashModel => _splashModel;

  set splashModel(SplashModel model){
    _splashModel = model;
    notifyListeners();
  }

  ImageProvider img;
//倒计时
  int _countdown = 5;
  get countdown {
    return _countdown;
  }

  set countdown(int countdown) {
    _countdown = countdown;
    notifyListeners();
  }

  ///完成
  bool _isDone = false;
  get isDone {
    return _isDone;
  }

  set isDone(bool isDone) {
    _isDone = isDone;
    notifyListeners();
  }

  ///定时器倒计时
  Timer timerCountdown;
  Timer timerDone;

  // 启动countdown计时器
  void startTimerCountdown() {
    if (null != timerCountdown) timerCountdown.cancel();

    timerCountdown = Timer(Duration(seconds: 1), () {
      _countdown--;
      print('_countdown->$_countdown');
      notifyListeners();

      if (_countdown > 0) startTimerCountdown();
    });
  }

  final MainRepo _repo = MainRepo();

  /// 加载启动信息
  Observable getSplash() {
    return _repo.getSplash()
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  Observable getExhibition(int exhibitionID){
    return _repo.getExhibition(exhibitionID).doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}
