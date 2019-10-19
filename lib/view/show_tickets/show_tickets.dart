import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/show_tickets/show_tickets_provide.dart';
import 'package:provide/provide.dart';

class ShowTicketsPage extends PageProvideNode {
  final ShowTicketsProvide _provide = ShowTicketsProvide();
  ShowTicketsPage() {
    mProviders.provide(Provider<ShowTicketsProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return ShowTicketsContentPage(_provide);
  }
}

class ShowTicketsContentPage extends StatefulWidget {
  final ShowTicketsProvide provide;
  ShowTicketsContentPage(this.provide);
  @override
  _ShowTicketsContentPageState createState() => _ShowTicketsContentPageState();
}

class _ShowTicketsContentPageState extends State<ShowTicketsContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            '展会门票',
            style: TextStyle(
                color: AppConfig.fontPrimaryColor, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:Image.asset('assets/images/xiangxia.png', fit: BoxFit.none,width: ScreenAdapter.width(38),height: ScreenAdapter.width(38),)),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _showTicketsList(),
          ],
        ));
  }

  Provide<ShowTicketsProvide> _showTicketsList() {
    return Provide<ShowTicketsProvide>(
      builder:
          (BuildContext context, Widget child, ShowTicketsProvide provide) {
        var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;
        return Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: provide.showTickets.map((value) {
              return Container(
                width: itemWidth,
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Color.fromRGBO(233, 233, 233, 0.9),
                    //   width: 1,
                    // ),
                    ),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: Image.asset(
                          value['image'],
                          fit: BoxFit.fill,
                        )),
                        Padding(
                          padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '￥',style: TextStyle(
                                    color: Colors.red,
                                    fontSize: ScreenAdapter.size(25),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  value['Price'],style: TextStyle(
                                    color: Colors.red,
                                    fontSize: ScreenAdapter.size(35),
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                          child: Container( 
                            child: Text(value['describe'], style: TextStyle(
                              color: Color.fromRGBO(120, 120, 120, 1.0),
                            ),),
                          ),
                        )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
