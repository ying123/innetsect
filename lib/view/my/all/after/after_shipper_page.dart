import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

class AfterShipperPage extends PageProvideNode{
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;

  AfterShipperPage(){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterShipperContent(_afterServiceProvide);
  }
}

class AfterShipperContent extends StatefulWidget {
  final AfterServiceProvide _afterServiceProvide;
  AfterShipperContent(this._afterServiceProvide);

  @override
  _AfterShipperContentState createState() => new _AfterShipperContentState();
}

class _AfterShipperContentState extends State<AfterShipperContent> {
  AfterServiceProvide _afterServiceProvide;

  @override
  Widget build(BuildContext context) {
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context, Widget widget, AfterServiceProvide provide){
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: provide.shipperModelList.asMap().keys.map((keys){
              return new IntrinsicHeight(
                child: InkWell(
                  onTap: (){
                    provide.onSelectedShipper(keys);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: new Row(
                      children: <Widget>[
                        new Text(provide.shipperModelList[keys].shipperName),
                        new Container(
                          padding: EdgeInsets.only(left: 10),
                          child: provide.shipperModelList[keys].isSelected? new Icon(
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