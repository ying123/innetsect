
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/personal_center/edit_email_page.dart';
import 'package:innetsect/view/personal_center/edit_nick_name_page.dart';
import 'package:innetsect/view/personal_center/edit_phone_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:innetsect/view_model/personal_center/personal_center_provide.dart';
import 'package:provide/provide.dart';
import 'package:image_picker/image_picker.dart';

/// 个人资料
class PersonalCenterPage extends PageProvideNode {
  final PersonalCenterProvide _provide = PersonalCenterProvide();
  final LoginProvide _loginProvide = LoginProvide.instance;
  PersonalCenterPage() {
    mProviders.provide(Provider.value(_provide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return PersonalCenterContentPage(_provide,_loginProvide);
  }
}

class PersonalCenterContentPage extends StatefulWidget {
  
   final PersonalCenterProvide provide ;
   final LoginProvide _loginProvide;
   PersonalCenterContentPage(this.provide,this._loginProvide);
  @override
  _PersonalCenterContentPageState createState() =>
      _PersonalCenterContentPageState();
}

class _PersonalCenterContentPageState extends State<PersonalCenterContentPage> {
  LoginProvide _loginProvide;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvide ??= widget._loginProvide;
  }

  @override
  Widget build(BuildContext context) {
    UserInfoModel userModel = _loginProvide.userInfoModel;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("个人中心"),elevation: 0.0),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          InkWell(
              onTap: () {
                print('用户头像被点击');
                _openBottomSheet();
              },
              child: _setupPersonalCenterHeadPortrait()),
          Container(
              width: double.infinity,
              height: ScreenAdapter.height(10),
              color: AppConfig.assistLineColor),
          CustomsWidget().listSlider(
            title: "昵称",rightTitle: true,
            rightDesc: userModel.nickName,
            titleFont: FontWeight.w800,
            titleFontSize: ScreenAdapter.size(28),titleColor: Colors.black,
            onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return EditNickNamePage();
                  }
                ));
            }
          ),
          Divider(color: AppConfig.assistLineColor,height: 10,indent: 10,endIndent: 10,),
          CustomsWidget().listSlider(
            title: "更换手机号",rightTitle: true,
            rightDesc: userModel.mobile,titleFont: FontWeight.w800,
            titleFontSize: ScreenAdapter.size(28),titleColor: Colors.black,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return EditPhonePage();
                  }
              ));
            }
          ),
          Divider(color: AppConfig.assistLineColor,height: 10,indent: 10,endIndent: 10,),
          CustomsWidget().listSlider(
            title: "换绑邮箱",rightTitle: true,
            rightDesc: userModel.email==null?"":userModel.email,titleFont: FontWeight.w800,
            titleFontSize: ScreenAdapter.size(28),titleColor: Colors.black,
            onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return EditEmailPage();
                  }
                ));
            }
          ),
          Divider(color: AppConfig.assistLineColor,height: 10,indent: 10,endIndent: 10,)
//          InkWell(
//              onTap: () {
//                print('性别被点击');
//              },
//              child: _setupPersonalCenterGender()),
//          Container(
//            width: ScreenAdapter.width(750),
//            height: ScreenAdapter.height(2),
//            color: Color.fromRGBO(249, 249, 249, 1.0),
//          ),
//          InkWell(
//              onTap: () {
//                print('生日被点击');
//              },
//              child: _setupPersonalCenterBirthday()),
//          Container(
//            width: ScreenAdapter.width(750),
//            height: ScreenAdapter.height(2),
//            color: Color.fromRGBO(249, 249, 249, 1.0),
//          ),
        ],
      ),
    );
  }

  Future _openBottomSheet() async {
    final option = showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(210),
            child: Column(
              children: <Widget>[
                // Container(
                //   width: ScreenAdapter.width(750),
                //   height: ScreenAdapter.height(100),
                //   child: Center(
                //     child: Text(
                //       '拍摄',
                //       style: TextStyle(color: Colors.blue),
                //     ),
                //   ),
                // ),
                Container(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(3),
                    color: Colors.black12),
                InkWell(
                  onTap: () {
                    print('手机相册被点击');
                    _openGallery();
                  },
                  child: Container(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(100),
                    child: Center(
                      child: Text(
                        '从手机相册选择',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(3),
                    color: Colors.black12),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.white,
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(100),
                    child: Center(
                      child: Text(
                        '取消',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    print(option);
  }

  /// 相册选择头像
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    widget.provide.imagePath = image;
    // 更新头像
    Navigator.pop(context);
  }

  Provide<PersonalCenterProvide> _setupPersonalCenterNickname() {
    return Provide<PersonalCenterProvide>(
      builder:
          (BuildContext context, Widget child, PersonalCenterProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(118),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
              Text(
                '昵称',
                style: TextStyle(
                  fontSize: ScreenAdapter.size(30),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                provide.nickname,
                style: TextStyle(
                  fontSize: ScreenAdapter.size(28),
                  color: Color.fromRGBO(95, 95, 95, 1.0),
                ),
              ),
              SizedBox(
                width: ScreenAdapter.width(37),
              ),
              Image.asset(
                'assets/images/mall/arrow_right.png',
                width: ScreenAdapter.width(25),
                height: ScreenAdapter.width(25),
              ),
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
            ],
          ),
        );
      },
    );
  }

  ///TODO 废弃
  Provide<PersonalCenterProvide> _setupPersonalCenterGender() {
    return Provide<PersonalCenterProvide>(
      builder:
          (BuildContext context, Widget child, PersonalCenterProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(118),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
              Text(
                '性别',
                style: TextStyle(
                  fontSize: ScreenAdapter.size(30),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                provide.gender,
                style: TextStyle(
                  fontSize: ScreenAdapter.size(28),
                  color: Color.fromRGBO(95, 95, 95, 1.0),
                ),
              ),
              SizedBox(
                width: ScreenAdapter.width(37),
              ),
              Image.asset(
                'assets/images/mall/arrow_right.png',
                width: ScreenAdapter.width(25),
                height: ScreenAdapter.width(25),
              ),
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<PersonalCenterProvide> _setupPersonalCenterBirthday() {
    return Provide<PersonalCenterProvide>(
      builder:
          (BuildContext context, Widget child, PersonalCenterProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(118),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
              Text(
                '生日',
                style: TextStyle(
                  fontSize: ScreenAdapter.size(30),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                provide.birthday,
                style: TextStyle(
                  fontSize: ScreenAdapter.size(28),
                  color: Color.fromRGBO(95, 95, 95, 1.0),
                ),
              ),
              SizedBox(
                width: ScreenAdapter.width(37),
              ),
              Image.asset(
                'assets/images/mall/arrow_right.png',
                width: ScreenAdapter.width(25),
                height: ScreenAdapter.width(25),
              ),
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
            ],
          ),
        );
      },
    );
  }

  Provide<PersonalCenterProvide> _setupPersonalCenterHeadPortrait() {
    return Provide<PersonalCenterProvide>(
      builder:
          (BuildContext context, Widget child, PersonalCenterProvide provide) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(170),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
              Text(
                '头像',
                style: TextStyle(
                  fontSize: ScreenAdapter.size(28),
                  fontWeight: FontWeight.w800
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                width: ScreenAdapter.width(100),
                height: ScreenAdapter.width(100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenAdapter.width(50))),
                ),
                child: ClipOval(
                  child: provide.imagePath == null
                      ? Image.asset(
                          "assets/images/mall/hot_brand1.png",
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          provide.imagePath,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                width: ScreenAdapter.width(37),
              ),
              Image.asset(
                'assets/images/mall/arrow_right.png',
                width: ScreenAdapter.width(25),
                height: ScreenAdapter.width(25),
              ),
              SizedBox(
                width: ScreenAdapter.width(50),
              ),
            ],
          ),
        );
      },
    );
  }
}
