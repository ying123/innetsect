import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

/// 申请原因选择
class RmareasonPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;

  RmareasonPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return RmareasonContent(_afterServiceProvide);
  }
}

class RmareasonContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  RmareasonContent(this._afterServiceProvide);
  @override
  _RmareasonContentState createState() => _RmareasonContentState();
}

class _RmareasonContentState extends State<RmareasonContent> {
  AfterServiceProvide _afterServiceProvide;

  @override
  Widget build(BuildContext context) {
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context, Widget widget, AfterServiceProvide provide){
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: provide.rmareasonsModelList.asMap().keys.map((keys){
              return new IntrinsicHeight(
                child: InkWell(
                  onTap: (){
                    provide.onSelectedRmareason(keys);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: new Row(
                      children: <Widget>[
                        new Text(provide.rmareasonsModelList[keys].reasonName),
                        new Container(
                          child: provide.rmareasonsModelList[keys].isSelected? new Icon(
                            Icons.check_circle,
                            size: 20.0,
                            color: AppConfig.fontBackColor,
                          ) : new Icon(Icons.panorama_fish_eye,
                            size: 20.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;
  }
}
