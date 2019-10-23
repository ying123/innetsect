import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/brand_model.dart';
import 'package:innetsect/view_model/brand/venues/b_venues_provide.dart';
import 'package:provide/provide.dart';

const INDEX_BAR_WORDS = [
  "↑",
  "☆",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];

class BVenuedPage extends PageProvideNode {
  final BVenuedProvide _provide = BVenuedProvide();
  BVenuedPage() {
    mProviders.provide(Provider<BVenuedProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BvenuedContentPage(_provide);
  }
}

class BvenuedContentPage extends StatefulWidget {
  final BVenuedProvide provide;
  BvenuedContentPage(this.provide);
  @override
  _BvenuedContentPageState createState() => _BvenuedContentPageState();
}

class _BvenuedContentPageState extends State<BvenuedContentPage> {
  ScrollController _scrollController;

  final List<BrandItem> _functionButtons = [];

  ///字母下索引的偏移
  final Map _letterPosMap = {INDEX_BAR_WORDS[0]: 0.0};

  @override
  void initState() {
    widget.provide.brands
      ..addAll(widget.provide.contacts);
      //..addAll(widget.provide.contacts)
     // ..addAll(widget.provide.contacts);
    print('brands->${widget.provide.brands}');
    widget.provide.brands.sort((Brand a, Brand b) {
      return a.nameIndex.compareTo(b.nameIndex);
    });
    _scrollController = new ScrollController();

    //计算用于IndexBar 进行定位的关键通信录列表项的位置
    var _totalPos = _functionButtons.length * BrandItem.height(false);
    for (var i = 0; i < widget.provide.brands.length; i++) {
      bool _hasGroupTitle = true;
      if (i > 0 &&
          widget.provide.brands[i].nameIndex
                  .compareTo(widget.provide.brands[i - 1].nameIndex) ==
              0) {
        _hasGroupTitle = false;
      }

      if (_hasGroupTitle) {
        _letterPosMap[widget.provide.brands[i].nameIndex] = _totalPos;
      }
      _totalPos += BrandItem.height(_hasGroupTitle);
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String getLetter(BuildContext context, double tileHeight, Offset globalPos) {
    RenderBox _box = context.findRenderObject();
    var local = _box.globalToLocal(globalPos);
    int index = (local.dy ~/ tileHeight).clamp(0, INDEX_BAR_WORDS.length - 1);
    return INDEX_BAR_WORDS[index];
  }

  void _jumpToIndex(String letter) {
    if (_letterPosMap.isNotEmpty) {
      final _pos = _letterPosMap[letter];
      if (_pos != null) {
        _scrollController.animateTo(_letterPosMap[letter],
            curve: Curves.easeInOut, duration: Duration(microseconds: 200));
      }
    }
  }

  Provide<BVenuedProvide> _buildIndexBar(
      BuildContext context, BoxConstraints constraints) {
    return Provide<BVenuedProvide>(
      builder: (BuildContext context, Widget child, BVenuedProvide provide) {
        final List<Widget> _letters = INDEX_BAR_WORDS.map((String word) {
          // print('word$word');
          return Expanded(child: Text(word));
        }).toList();

        final _totalHeight = constraints.biggest.height;
        print('_totalHeight总高度 $_totalHeight');
        final _tileHeight = _totalHeight / _letters.length;
        print('_tileHeight文字子高度$_tileHeight');
        return GestureDetector(
          ///垂直向下拖动
          onVerticalDragDown: (DragDownDetails details) {
            print('垂直按下');
            setState(() {
              provide.indexBarBgColor = Colors.black26;
              provide.currntLetter =
                  getLetter(context, _tileHeight, details.globalPosition);
              _jumpToIndex(widget.provide.currntLetter);
            });
          },
          //垂直阻力端
          onVerticalDragEnd: (DragEndDetails details) {
            print('垂直拖动取消');
            setState(() {
              provide.indexBarBgColor = Colors.transparent;
              provide.currntLetter = null;
            });
          },

          onVerticalDragCancel: () {
            print('垂直抬起');
            setState(() {
              provide.indexBarBgColor = Colors.transparent;
              provide.currntLetter = null;
            });
          },
          onVerticalDragUpdate: (DragUpdateDetails details) {
            print('垂直拖动更新');
            setState(() {
              // var _letter = getLetter(context, _tileHeight, details.globalPosition);
              provide.currntLetter =
                  getLetter(context, _tileHeight, details.globalPosition);
              _jumpToIndex(provide.currntLetter);
            });
          },
          child: Column(
            children: _letters,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _body = [
      ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index < _functionButtons.length) {
            return _functionButtons[index];
          }
          int _brandIndex = index - _functionButtons.length;
          bool _isGroupTitle = true;
          Brand _brand = widget.provide.brands[_brandIndex];

          if (_brandIndex >= 1 &&
              _brand.nameIndex ==
                  widget.provide.brands[_brandIndex - 1].nameIndex) {
            _isGroupTitle = false;
          }
          return BrandItem(
              avatar: _brand.avatar,
              title: _brand.name,
              groupTitle: _isGroupTitle ? _brand.nameIndex : null);
        },
        itemCount: widget.provide.brands.length + _functionButtons.length,
      ),
      Positioned(
        width: Constants.IndexBarWidth,
        right: 0.0,
        top: 0.0,
        bottom: 0.0,
        child: Container(
          color: widget.provide.indexBarBgColor,
          child: LayoutBuilder(
            builder: _buildIndexBar,
          ),
        ),
      )
    ];
    if (widget.provide.currntLetter != null &&
        widget.provide.currntLetter.isNotEmpty) {
      _body.add(Center(
          child: Container(
        width: Constants.IndexLetterBoxSize,
        height: Constants.IndexLetterBoxSize,
        decoration: BoxDecoration(
          color: AppColors.IndexLetterBoxBgColor,
          borderRadius:
              BorderRadius.all(Radius.circular(Constants.IndexLetterBoxRadius)),
        ),
        child: Center(
          child: Text(
            widget.provide.currntLetter,
            style: AppStyles.IndexLetterBoxTextStyle,
          ),
        ),
      )));
    }
    return Stack(
      children: _body,
    );
  }
}
