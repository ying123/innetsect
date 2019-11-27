import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/feedback/feedback_provide.dart';
import 'package:provide/provide.dart';

class FeedBackPage extends PageProvideNode{
  final FeedbackProvide _feedbackProvide = FeedbackProvide();

  FeedBackPage(){
    mProviders.provide(Provider<FeedbackProvide>.value(_feedbackProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return FeedBackContent(_feedbackProvide);
  }
}

class FeedBackContent extends StatefulWidget {
  final FeedbackProvide _feedbackProvide;
  FeedBackContent(this._feedbackProvide);
  @override
  _FeedBackContentState createState() => new _FeedBackContentState();
}

class _FeedBackContentState extends State<FeedBackContent> {
  FeedbackProvide _feedbackProvide;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("咨询",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),
      ),
      body: Container(
        width: ScreenAdapter.width(750),
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(left: 20,right: 20,top: 10),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _headerWidget(),
                  _descTextWidget(),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 40,left: 10,bottom: 20),
                    child: Text('联系方式(非必填)',style: TextStyle(color: Colors.black,
                        fontSize: ScreenAdapter.size(24),fontWeight: FontWeight.w600),),
                  ),
                  _phoneTextWidget(),
                  Divider(height: 10,color: AppConfig.assistLineColor,)
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: (){
                    // 意见请求
                    if(_feedbackProvide.content==null){
                      CustomsWidget().showToast(title: "请填写描述");
                    }else{
                      _feedbackProvide.requestQNA().doOnListen(() {
                        print('doOnListen');
                      })
                          .doOnCancel(() {})
                          .listen((item) {
                        ///加载数据
                        print('listen data->$item');
                        if(item!=null&&item.data!=null){
                          CustomsWidget().showToast(title: "提交成功");
                          Navigator.pop(context);
                        }
                      }, onError: (e) {});
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('提交',style: TextStyle(fontWeight: FontWeight.w600,
                      fontSize: ScreenAdapter.size(24)),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feedbackProvide ??= widget._feedbackProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /// 顶部
  Widget _headerWidget(){
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.record_voice_over)
        ),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text('HI,有什么需要反馈?',style: TextStyle(
            color: Colors.black,fontWeight: FontWeight.w800,
            fontSize: ScreenAdapter.size(28)
          ),),
        )
      ],
    );
  }

  /// 描述
  Widget _descTextWidget(){
    return Container(
      padding: EdgeInsets.only(top: 20,left: 10,right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: TextField(
        maxLines: 8,
        decoration: InputDecoration(
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.white60)
            ),
            hintText: "请详细描述您遇到的问题(必填)",
            hintStyle: TextStyle(fontSize: ScreenAdapter.size(24)),
            filled: true,
            contentPadding: EdgeInsets.only(left: 10,right: 10,top: 5,)
        ),
        controller: TextEditingController.fromValue(
            TextEditingValue(
                text: _feedbackProvide.content==null?'':_feedbackProvide.content,
                selection: TextSelection.fromPosition(TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: _feedbackProvide.content==null?''.length:_feedbackProvide.content.length
                ))
            )),
        onChanged: (val){
          setState(() {
            _feedbackProvide.content = val;
          });
        },
      ),
    );
  }

  Widget _phoneTextWidget(){
    return Container(
      padding: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: "请输入手机号码",
            hintStyle: TextStyle(fontSize: ScreenAdapter.size(24)),
            filled: true,
            contentPadding: EdgeInsets.only(left: 10,right: 10,top: 5,)
        ),
        controller: TextEditingController.fromValue(
            TextEditingValue(
                text: _feedbackProvide.phone==null?'':_feedbackProvide.phone,
                selection: TextSelection.fromPosition(TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: _feedbackProvide.phone==null?''.length:_feedbackProvide.phone.length
                ))
            )),
        onChanged: (val){
          setState(() {
            _feedbackProvide.phone = val;
          });
        },
      ),
    );
  }

}