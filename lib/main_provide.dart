import 'dart:async';

import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';

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
}
