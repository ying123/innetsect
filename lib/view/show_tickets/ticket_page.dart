import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/show_tickets/ticket_provide.dart';
import 'package:provide/provide.dart';

class TicketPage extends PageProvideNode {
  final TicketProvide _provide = TicketProvide();
  //final Map selectedTicketValue;
  TicketPage() {
    mProviders.provide(Provider<TicketProvide>.value(_provide));
   // _provide.currentTicketData = selectedTicketValue;
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
      body: Container(

      ),
     
    );
  }
}
