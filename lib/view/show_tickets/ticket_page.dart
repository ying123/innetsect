import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/show_tickets/ticket_provide.dart';
import 'package:provide/provide.dart';

class TicketPage extends PageProvideNode {
  final TicketProvide _provide = TicketProvide();
  final Map selectedTicketValue;
  TicketPage(this.selectedTicketValue) {
    mProviders.provide(Provider<TicketProvide>.value(_provide));
    _provide.currentTicketData = selectedTicketValue;
  }
  @override
  Widget buildContent(BuildContext context) {
    return TicketContentPage(_provide);
  }
}

class TicketContentPage extends StatefulWidget {
  final TicketProvide provide;

  TicketContentPage(this.provide);
  @override
  _TicketContentPageState createState() => _TicketContentPageState();
}

class _TicketContentPageState extends State<TicketContentPage> {
  @override
  void initState() {
    super.initState();
    print('value;;->${widget.provide.currentTicketData}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '购票',
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/xiangxia.png',
              fit: BoxFit.none,
              width: ScreenAdapter.width(38),
              height: ScreenAdapter.width(38),
            )),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(750),
            child: Image.asset(
              widget.provide.currentTicketData['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(80),
            child: Center(
              child: Text(
                widget.provide.currentTicketData['describe'],
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenAdapter.size(30)),
              ),
            ),
          ),
          Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(100),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: ScreenAdapter.width(20),
                ),
                Text(
                  '￥ ' + widget.provide.currentTicketData['Price'],
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: ScreenAdapter.width(150),
                  height: ScreenAdapter.height(100),
                  //color: Colors.yellow,
                  child: Container(
                    width: ScreenAdapter.width(154),
                    height: ScreenAdapter.height(50),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            print('减号被点击');
                            if (widget.provide.countVotes == 0) {
                              return;
                            }else{
                              setState(() {
                              widget.provide.countVotes--;
                            });
                            }
                          },
                          child: Container(
                            width: ScreenAdapter.width(49),
                            height: ScreenAdapter.height(49),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(242, 243, 245, 1.0),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: ScreenAdapter.size(30),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(1),
                        ),
                        Container(
                            width: ScreenAdapter.width(49),
                            height: ScreenAdapter.height(49),
                            color: Color.fromRGBO(242, 243, 245, 1.0),
                            child: Center(
                              child: Text(widget.provide.countVotes.toString()),
                            )),
                        SizedBox(
                          width: ScreenAdapter.width(1),
                        ),
                        GestureDetector(
                          onTap: (){
                            print('加号被点击');
                           setState(() {
                              widget.provide.countVotes++;
                           });
                          },
                          child: Container(
                              width: ScreenAdapter.width(49),
                              height: ScreenAdapter.height(49),
                              color: Color.fromRGBO(242, 243, 245, 1.0),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: ScreenAdapter.size(30),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenAdapter.width(20),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenAdapter.width(20), right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(2),
            color: Color.fromRGBO(242, 243, 245, 1.0),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                left: ScreenAdapter.width(20), right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(70),
            child: Text(
              widget.provide.currentTicketData['describe'],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenAdapter.width(20), right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(2),
            color: Color.fromRGBO(242, 243, 245, 1.0),
          ),
          Container(
            margin: EdgeInsets.only(left: ScreenAdapter.width(30), top: ScreenAdapter.height(65)),
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(120),
            child: Text('购票须知:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: ScreenAdapter.size(25)),),
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(85),
        color: Colors.yellow,
        child: Center(
          child: Text('立即购买'),
        ),
      ),
    );
  }
}
