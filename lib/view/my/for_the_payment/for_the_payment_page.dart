import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/my/for_the_payment/for_the_payment_provide.dart';
import 'package:provide/provide.dart';

///待付款
class ForThePaymentPage extends PageProvideNode {
  final ForThePaymentProvide _provide = ForThePaymentProvide();
  ForThePaymentPage() {
    mProviders.provide(Provider.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return ForThePaymentContentPage(_provide);
  }
}

class ForThePaymentContentPage extends StatefulWidget {
  final ForThePaymentProvide provide;
  ForThePaymentContentPage(this.provide);
  @override
  _ForThePaymentContentPageState createState() =>
      _ForThePaymentContentPageState();
}

class _ForThePaymentContentPageState extends State<ForThePaymentContentPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: ScreenAdapter.height(430),
      itemCount: widget.provide.forThePatmentListModle.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(430),
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(ScreenAdapter.width(35),
                        ScreenAdapter.height(50), 0, 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '订单号:  ${widget.provide.forThePatmentListModle[index]['orderNumber']}',
                          style: TextStyle(
                            fontSize: ScreenAdapter.size(28),
                          ),
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(260),
                        ),
                        Text(
                          '${widget.provide.forThePatmentListModle[index]['waitingForPayment']}',
                          style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(
                          width: ScreenAdapter.width(30),
                        )
                      ],
                    )),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, ScreenAdapter.height(115), 0, 0),
                  child: Container(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(180),
                    // color: Colors.yellow,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: ScreenAdapter.width(30),
                        ),
                        Container(
                          width: ScreenAdapter.width(570),
                          height: ScreenAdapter.height(175),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.fromLTRB(
                                    0, 0, ScreenAdapter.width(18), 0),
                                width: ScreenAdapter.width(115),
                                height: ScreenAdapter.height(170),
                                child: Image.asset(widget.provide
                                    .forThePatmentListModle[index]['image']),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ScreenAdapter.height(68),
                              ScreenAdapter.width(30),
                              0),
                          child: Container(
                            width: ScreenAdapter.width(120),
                            height: ScreenAdapter.height(165),
                            //color: Colors.yellow,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '￥',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.size(30),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${widget.provide.forThePatmentListModle[index]['prioc']}',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.size(45),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(ScreenAdapter.width(640),
                      ScreenAdapter.height(240), 0, 0),
                  child: Container(
                      child: Text(
                    '共${widget.provide.forThePatmentListModle[index]['num']}件',
                    style: TextStyle(color: Colors.black54),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),
                      ScreenAdapter.height(315), ScreenAdapter.width(30), 0),
                  child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(110),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: Color.fromRGBO(234, 234, 234, 1.0)),
                              bottom: BorderSide(
                                  color: Color.fromRGBO(249, 249, 249, 1.0),
                                  width: ScreenAdapter.width(7)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: ScreenAdapter.width(230),
                          ),
                          Container(
                            width: ScreenAdapter.width(137),
                            height: ScreenAdapter.height(60),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)),
                            child: Center(
                              child: Text('修改发票'),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(20),
                          ),
                          Container(
                            width: ScreenAdapter.width(137),
                            height: ScreenAdapter.height(60),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(234, 234, 234, 1.0),
                              //border: Border.all(color: Colors.black54)
                            ),
                            child: Center(
                              child: Text('取消订单'),
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(20),
                          ),
                          Container(
                            width: ScreenAdapter.width(137),
                            height: ScreenAdapter.height(60),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromRGBO(253, 142, 108, 1.0))),
                            child: Center(
                              child: Text(
                                '立即付款',
                                style: TextStyle(
                                    color: Color.fromRGBO(253, 142, 108, 1.0)),
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ));
      },
    );
  }
}
