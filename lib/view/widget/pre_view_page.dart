import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class PreViewPage extends StatelessWidget {
  final String image;
  PreViewPage({this.image});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_down),
        ),
        title: new Text(''),
      ),
      body: PhotoView(
        imageProvider: NetworkImage( this.image,),
      ),
    );
  }
}