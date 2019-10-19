import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ListHeader extends Header{

  /// Key
  final Key key;

  /// 方位
  final AlignmentGeometry alignment;

  /// 提示刷新文字
  final String refreshText;

  /// 准备刷新文字
  final String refreshReadyText;

  /// 正在刷新文字
  final String refreshingText;

  /// 刷新完成文字
  final String refreshedText;

  /// 刷新失败文字
  final String refreshFailedText;

  /// 没有更多文字
  final String noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showInfo;

  /// 更多信息
  final String infoText;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  /// 更多信息文字颜色
  final Color infoColor;
  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  ListHeader({
    extent: 100.0,
    triggerDistance: 100.0,
    float = false,
    completeDuration = const Duration(seconds: 1),
    enableInfiniteRefresh = false,
    enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.refreshText: "下拉刷新",
    this.refreshReadyText: "准备刷新",
    this.refreshingText: "正在刷新",
    this.refreshedText: "刷新完成",
    this.refreshFailedText: "Refresh failed",
    this.noMoreText: "No more",
    this.showInfo: true,
    this.infoText: "Updated at %T",
    this.bgColor: Colors.transparent,
    this.textColor: Colors.black,
    this.infoColor: Colors.teal,
  }) : super(
    extent: extent,
    triggerDistance: triggerDistance,
    float: float,
    completeDuration: float
        ? completeDuration == null
        ? Duration(
      milliseconds: 400,
    )
        : completeDuration +
        Duration(
          milliseconds: 400,
        )
        : completeDuration,
    enableInfiniteRefresh: enableInfiniteRefresh,
    enableHapticFeedback: enableHapticFeedback,
  );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return ListHeaderWidget(
      key: key,
      listHeader: this,
      refreshState: refreshState,
      pulledExtent: pulledExtent,
      refreshTriggerPullDistance: refreshTriggerPullDistance,
      refreshIndicatorExtent: refreshIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteRefresh: enableInfiniteRefresh,
      success: success,
      noMore: noMore,
      linkNotifier:linkNotifier
    );
  }
  
}

class ListHeaderWidget extends StatefulWidget {
  final ListHeader listHeader;
  final RefreshMode refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final AxisDirection axisDirection;
  final bool float;
  final Duration completeDuration;
  final bool enableInfiniteRefresh;
  final bool success;
  final bool noMore;
  final LinkHeaderNotifier linkNotifier;

  ListHeaderWidget(
      {Key key,
        this.refreshState,
        this.listHeader,
        this.pulledExtent,
        this.refreshTriggerPullDistance,
        this.refreshIndicatorExtent,
        this.axisDirection,
        this.float,
        this.completeDuration,
        this.enableInfiniteRefresh,
        this.success,
        this.noMore,
        this.linkNotifier
      })
      : super(key: key);

  @override
  _ListHeaderWidgetState createState() => new _ListHeaderWidgetState();
}

class _ListHeaderWidgetState extends State<ListHeaderWidget>
    with TickerProviderStateMixin<ListHeaderWidget>{
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;
  RefreshMode get _refreshState => widget.linkNotifier.refreshState;
  double get _pulledExtent => widget.linkNotifier.pulledExtent;
  double get _indicatorExtent => widget.linkNotifier.refreshIndicatorExtent;
  bool get _noMore => widget.linkNotifier.noMore;

  bool get overTriggerDistance => _overTriggerDistance;

  set overTriggerDistance(bool over) {
    print(_overTriggerDistance != over);
    if (_overTriggerDistance != over) {
      _imageAnimationController.forward();
//      _overTriggerDistance
//          ? _readyController.forward()
//          : _restoreController.forward();
      _overTriggerDistance = over;
    }
  }

  // 是否刷新完成
  bool _refreshFinish = false;

  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish && widget.float) {
        Future.delayed(widget.completeDuration - Duration(milliseconds: 400),
                () {
              if (mounted) {
//                _floatBackController.forward();
              }
            });
        Future.delayed(widget.completeDuration, () {
          _floatBackDistance = null;
          _refreshFinish = false;
        });
      }
      _refreshFinish = finish;
    }
  }

  /// 动画
  // 图片动画
  AnimationController _imageAnimationController;
  Animation<double> _imageAnimation;
  // 图片高度
  double imgHeight = 0.0;
  // 是否回弹动画
  bool _showBackAnimation = false;
  set showBackAnimation(bool value) {
    if(value){
      // 开始动画
      _imageAnimationController.forward();
    }else{
      _imageAnimationController.stop();
    }
  }
  double _floatBackDistance;

  // 显示文字
  String get _showText {
    if (widget.noMore) return widget.listHeader.noMoreText;
    if (widget.enableInfiniteRefresh) {
      if (widget.refreshState == RefreshMode.refreshed ||
          widget.refreshState == RefreshMode.inactive ||
          widget.refreshState == RefreshMode.drag) {
        return widget.listHeader.refreshedText;
      } else {
        return widget.listHeader.refreshingText;
      }
    }
    switch (widget.refreshState) {
      case RefreshMode.refresh:
        return widget.listHeader.refreshingText;
      case RefreshMode.armed:
        return widget.listHeader.refreshingText;
      case RefreshMode.refreshed:
        return _finishedText;
      case RefreshMode.done:
        return _finishedText;
      default:
        if (overTriggerDistance) {
          return widget.listHeader.refreshReadyText;
        } else {
          return widget.listHeader.refreshText;
        }
    }
  }

  // 刷新结束文字
  String get _finishedText {
    if (!widget.success) return widget.listHeader.refreshFailedText;
    if (widget.noMore) return widget.listHeader.noMoreText;
    return widget.listHeader.refreshedText;
  }

  @override
  void initState() {
    super.initState();
    // 准备动画
    _imageAnimationController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _imageAnimation = new Tween(begin: 0.0, end: 1.0).animate(_imageAnimationController)
      ..addListener(() {
        setState(() {
          imgHeight = _pulledExtent;
        });
      });
    _imageAnimation.addStatusListener((status) {
      if(_pulledExtent==0.0){
        // 重置动画
        _imageAnimationController.reset();
      }
    });
    // 恢复动画
//    _restoreController = new AnimationController(
//        duration: const Duration(milliseconds: 2000), vsync: this);
//    _restoreAnimation =
//    new Tween(begin: 0.0, end: 1.0).animate(_restoreController)
//      ..addListener(() {
//        setState(() {
//          if (_restoreAnimation.status != AnimationStatus.dismissed) {
//            _iconRotationValue = _restoreAnimation.value;
//          }
//        });
//      });
//    _restoreAnimation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        _restoreController.stop();
//      }
//    });
    // float收起动画
//    _floatBackController = new AnimationController(
//        duration: const Duration(milliseconds: 300), vsync: this);
//    _floatBackAnimation =
//    new Tween(begin: widget.refreshIndicatorExtent, end: 0.0)
//        .animate(_floatBackController)
//      ..addListener(() {
//        setState(() {
//          if (_floatBackAnimation.status != AnimationStatus.dismissed) {
//            _floatBackDistance = _floatBackAnimation.value;
//          }
//        });
//      });
//    _floatBackAnimation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        _floatBackController.reset();
//      }
//    });
  }

  @override
  void dispose() {
    _imageAnimationController.dispose();
//    _restoreController.dispose();
//    _floatBackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否为垂直方向
    bool isVertical = widget.axisDirection == AxisDirection.down ||
        widget.axisDirection == AxisDirection.up;
    // 是否反向
    bool isReverse = widget.axisDirection == AxisDirection.up ||
        widget.axisDirection == AxisDirection.left;

    print(isVertical ? widget.refreshIndicatorExtent : double.infinity);
    // 是否到达触发刷新距离
    overTriggerDistance = widget.refreshState != RefreshMode.inactive &&
        widget.pulledExtent >= widget.refreshTriggerPullDistance;
    if (widget.refreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }

    if(!overTriggerDistance && _pulledExtent<_indicatorExtent){
      showBackAnimation = true;
    }else {
      showBackAnimation = false;
    }
    return Stack(
      children: <Widget>[
        Positioned(
          top: !isVertical
              ? 0.0
              : isReverse
              ? _floatBackDistance == null
              ? 0.0
              : (widget.refreshIndicatorExtent - _floatBackDistance)
              : null,
          bottom: !isVertical
              ? 0.0
              : !isReverse
              ? _floatBackDistance == null
              ? 0.0
              : (widget.refreshIndicatorExtent - _floatBackDistance)
              : null,
          left: isVertical
              ? 0.0
              : isReverse
              ? _floatBackDistance == null
              ? 0.0
              : (widget.refreshIndicatorExtent - _floatBackDistance)
              : null,
          right: isVertical
              ? 0.0
              : !isReverse
              ? _floatBackDistance == null
              ? 0.0
              : (widget.refreshIndicatorExtent - _floatBackDistance)
              : null,
          child: Container(
            alignment: widget.listHeader.alignment ?? isVertical
                ? isReverse ? Alignment.topCenter : Alignment.bottomCenter
                : !isReverse ? Alignment.centerRight : Alignment.centerLeft,
            width: _pulledExtent < _indicatorExtent
                ? _indicatorExtent
                : _pulledExtent,
            height: _pulledExtent < _indicatorExtent
                ? _indicatorExtent
                : _pulledExtent,
            color: widget.listHeader.bgColor,
            child: SizedBox(
              height:
              _pulledExtent < _indicatorExtent
                  ? _indicatorExtent
                  : _pulledExtent,
              width:
              _pulledExtent < _indicatorExtent
                  ? _indicatorExtent
                  : _pulledExtent,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    height: _pulledExtent < _indicatorExtent
                        ? _indicatorExtent-20
                        : _pulledExtent-20,
                    child: new Stack(
                      children: _buildImageContent(isVertical:isVertical),
                    ),
                  ),
                  new Container(
                    height: _pulledExtent < _indicatorExtent
                        ? _indicatorExtent-(_indicatorExtent-20>0?_indicatorExtent-20:0)
                        : _pulledExtent-(_pulledExtent-20>0?_pulledExtent-20:0),
                    child: new Stack(
                      children: _buildTextContent(isVertical: isVertical),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 构建显示内容
  List<Widget> _buildImageContent({@required isVertical, isReverse}) {
    return isVertical
        ? <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width:  _pulledExtent < _indicatorExtent
                  ? _indicatorExtent
                  : _pulledExtent,
              height: _pulledExtent < _indicatorExtent
                  ? _indicatorExtent/1.2
                  : _pulledExtent/1.2,
              child: Image.asset("assets/images/mall/fresh.png",fit: BoxFit.fitHeight),
            ),
          ),
    ]
        : <Widget>[
      Container()
    ];
  }
  // 构建显示内容
  List<Widget> _buildTextContent({@required isVertical, isReverse}) {
    return isVertical
        ? <Widget>[
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child:Container(
          padding: EdgeInsets.only(bottom: 10),
          child: _refreshState == RefreshMode.refresh ||
              _refreshState == RefreshMode.armed?
          new Center(
            child: new Text("refresh",style: TextStyle(fontSize: _pulledExtent < _indicatorExtent
                ? _indicatorExtent/10.5
                : _pulledExtent/10.5),),
          ) :
          _refreshState == RefreshMode.refreshed ||
              _refreshState == RefreshMode.done ||
              (widget.enableInfiniteRefresh &&
                  _refreshState != RefreshMode.refreshed) ||
              _noMore ?
          new Center(
            child: new Text(widget.listHeader.refreshedText,style: TextStyle(fontSize: _pulledExtent < _indicatorExtent
                ? _indicatorExtent/10.5
                : _pulledExtent/10.5)),
          ) :
          new Center(
            child: new Text(widget.listHeader.refreshText,style: TextStyle(fontSize: _pulledExtent < _indicatorExtent
                ? _indicatorExtent/10.5
                : _pulledExtent/10.5)),
          )
          ,
        ),
      )
    ]
        : <Widget>[
      Container()
    ];
  }
}