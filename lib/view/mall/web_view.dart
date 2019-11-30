import 'package:flutter/material.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/entrance_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/web_view_widget.dart';

class WebView extends StatelessWidget {
  final String url;
  final String pages;
  final bool attended;
  final AppNavigationBarProvide appProvide;
  WebView({this.url,this.pages,this.attended,
    this.appProvide
  }):assert(url!=null);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: Text(''),onTap: (){
            if(this.pages=="main"){
              if(this.attended){
               Navigator.pushReplacement(context, MaterialPageRoute(
                 builder: (context){
                   this.appProvide.currentIndex = 2;
                   return AppNavigationBar();
                 }
               ));
              }else{
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context){
                      return EntrancePage();
                    }
                ));
              }
            }
          }),
      body: WebViewWidget(url: this.url,)
    );
  }
}