import 'package:flutter/material.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/web_view_widget.dart';
import 'package:url_launcher/url_launcher.dart';
class QimoPage extends StatelessWidget {
  final String url;
  QimoPage({this.url}):assert(url!=null);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: CustomsWidget().customNav(context: context,leading: true,
            widget: Text('客服'),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: ()async{
                  await launch("tel:4001686368");
                },
                child: Icon(Icons.phone,size: 20,),
              ),
            )

          ]
        ),
        body: WebViewWidget(url: this.url,)
    );
  }
}