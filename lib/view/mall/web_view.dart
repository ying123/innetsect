import 'package:flutter/material.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/view/mall/mall_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/web_view_widget.dart';

class WebView extends StatelessWidget {
  final String url;
  final String pages;
  final bool attended;
  final int exID;
  WebView({this.url,this.pages,this.attended,this.exID
  }):assert(url!=null);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,leading: true,
        widget: Text(''),onTap: (){
            if(this.attended!=null){
              if(this.exID==null){
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context){
                      return MallPage();
                    }
                ));
              }else{
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context){
                      return AppNavigationBar();
                    }
                ));
              }
            }else{
              Navigator.pop(context);
            }
          }),
      body: WebViewWidget(url: this.url,)
    );
  }
}