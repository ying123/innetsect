import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:provide/provide.dart';

class SearchScreenPage extends PageProvideNode{

  final SearchProvide _searchProvide = SearchProvide.instance;

  SearchScreenPage(){
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SearchScreenContent(_searchProvide);
  }
}

class SearchScreenContent extends StatefulWidget {
  final SearchProvide _searchProvide;
  SearchScreenContent(this._searchProvide);
  @override
  _SearchScreenContentState createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<SearchScreenContent> {
  SearchProvide _searchProvide;

  List navList = [ {'index': 0,'title': "销量",'isSelected': false,'direction':null},
                    {'index': 1,'title': "价格",'isSelected': false,'direction':null},
                    {'index': 2,'title': "新品",'isSelected': false,'direction':null}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget:new Text(_searchProvide.searchValue,style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 ),) ,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: new Container(
              width: double.infinity,
              color: Colors.white,
              height: ScreenAdapter.height(80),
              child: new Row(
                children: navList.map((item){
                  if(item['index']==1){
                    return Expanded(
                      child: InkWell(
                        onTap: (){
                          // 判断价格点击
                          navList[0]['isSelected']=false;
                          navList[2]['isSelected']=false;
                          item['isSelected'] = !item['isSelected'];
                          if(item['isSelected']){
                            setState(() {
                              item['direction'] = 'up';
                            });
                          }

                          if(!item['isSelected']){
                            setState(() {
                              item['direction'] = 'down';
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(item['title'],style: TextStyle(color: item['direction']!=null?Colors.black:Colors.black26)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdapter.height(10),
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.bottomLeft,
                                    child: Icon(Icons.arrow_drop_up,size: 16,color: item['isSelected']&&item['direction']!=null&&item['direction']=="up"?Colors.black:Colors.black26,),
                                  ),
                                  Container(
                                    height: ScreenAdapter.height(10),
                                    alignment: Alignment.topLeft,
                                    child: Icon(Icons.arrow_drop_down,size: 16,color: !item['isSelected']&&item['direction']!=null&&item['direction']=="down"?Colors.black:Colors.black26),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return Expanded(
                      child: InkWell(
                        onTap: (){
                          navList.forEach((val){
                            val['isSelected']=false;
                            val['direction']=null;
                          });
                          setState(() {
                            item['isSelected'] = !item['isSelected'];
                          });
                        },
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text(item['title'],style: TextStyle(color: item['isSelected']?Colors.black:Colors.black26),),
                        ),
                      ),
                    );
                  }
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchProvide ??= widget._searchProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    navList.forEach((item){
      item['isSelected']=false;
      item['direction']=null;
    });
  }
}
