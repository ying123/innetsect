import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my/profile/profile_provide.dart';
import 'package:provide/provide.dart';
class ProfilePage extends PageProvideNode{
  final ProfileProvide _profileProvide = ProfileProvide.instance;

  ProfilePage(){
    mProviders.provide(Provider<ProfileProvide>.value(_profileProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return ProfileContent(_profileProvide);
  }
}
class ProfileContent extends StatefulWidget {
  final ProfileProvide _profileProvide;
  ProfileContent(this._profileProvide);
  @override
  _ProfileContentState createState() => new _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  ProfileProvide _profileProvide;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileProvide??=widget._profileProvide;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}