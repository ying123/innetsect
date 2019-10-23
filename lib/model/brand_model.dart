import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
///品牌
class Brand {
  const Brand({
    @required this.avatar,
    @required this.name,
    @required this.nameIndex,
  });

  final String avatar;
  final String name;
  final String nameIndex;

}


class BrandItem extends StatelessWidget {
  BrandItem({
    @required this.avatar,
    @required this.title,
    this.groupTitle,
    this.onPressed,
  });

  final String avatar;
  final String title;
  final String groupTitle;
  final VoidCallback onPressed;

  ///边缘垂直
  static const double MARGIN_VERTICAL = 10.0;

  ///组标题的高度
  static const double GROUP_TITLE_HEIGHT = 24.0;

  bool get _isAvatarFromNet {
    return this.avatar.startsWith('http') || this.avatar.startsWith("https");
  }

  static double height(bool hasGroupTitle) {
    final _buttonHeight = MARGIN_VERTICAL * 2 +
        Constants.ContactAvatarSize +
        Constants.DividerWidth;
    print('_buttonHeighr$_buttonHeight');
    if (hasGroupTitle) {
      return _buttonHeight + GROUP_TITLE_HEIGHT;
    } else {
      return _buttonHeight;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _avatarIcon;
    if (_isAvatarFromNet) {
      _avatarIcon = ClipOval(
        child: CachedNetworkImage(
          imageUrl: this.avatar,
          // placeholder: ()
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize,
          fit: BoxFit.cover,
        ),
      );
    } else {
      _avatarIcon = ClipOval(
        child: Image.asset(
          this.avatar,
          width: Constants.ContactAvatarSize,
          height: Constants.ContactAvatarSize,
          fit: BoxFit.cover,
        ),
      );
    }

    Widget _button = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: MARGIN_VERTICAL),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            width: Constants.DividerWidth,
            color: Color(AppColors.DividerColor)),
      )),
      child: Row(
        children: <Widget>[
          _avatarIcon,
          SizedBox(width: 10.0),
          Text(title),
        ],
      ),
    );

    //分组标签
    Widget _itemBody;
    if (this.groupTitle != null) {
      _itemBody = Column(
        children: <Widget>[
          Container(
            height: GROUP_TITLE_HEIGHT,
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            color: const Color(AppColors.ContactGroupTitleBgColor),
            alignment: Alignment.centerLeft,
            child:
                Text(this.groupTitle, style: AppStyles.GroupTitleItemTextStyle),
          ),
          _button,
        ],
      );
    } else {
      _itemBody = _button;
    }

    return _itemBody;
  }
}

 
