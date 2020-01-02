
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/app.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/entrance_page.dart';
import 'package:innetsect/view/binding_sign_in/binding_sign_in_page.dart';
import 'package:innetsect/view/binding_sign_in/sign_protocol_page.dart';
import 'package:innetsect/view/brand/brand_mall_page.dart';
import 'package:innetsect/view/draw/check_the_registration_page.dart';
import 'package:innetsect/view/draw/draw_details_page.dart';
import 'package:innetsect/view/draw/draw_page.dart';
import 'package:innetsect/view/draw/end_of_the_draw_page.dart';
import 'package:innetsect/view/draw/registered_page.dart';
import 'package:innetsect/view/draw/registration_information_page.dart';
import 'package:innetsect/view/draw/registration_successful_page.dart';
import 'package:innetsect/view/exhibition/home_portlets_details_page.dart';
import 'package:innetsect/view/home/home_page.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/mall/commodity/commodity_page.dart';
import 'package:innetsect/view/mall/mall_page.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/mall/search/search_page.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
import 'package:innetsect/view/my/all/all_page.dart';
import 'package:innetsect/view/my/profile/profile_page.dart';
import 'package:innetsect/view/my_order/my_order_page.dart';
import 'package:innetsect/view/registered/country_page.dart';
import 'package:innetsect/view/registered/registered_page.dart';
import 'package:innetsect/view/show_tickets/show_tickets.dart';
import 'package:innetsect/view/venues_map/venues_map_page.dart';

final routes = {
  '/':(context)=>App(),
  '/entrancePage':(context)=>EntrancePage(),
  '/appNavigationBarPage':(context)=>AppNavigationBar(),
  '/mallPage':(context)=>MallPage(),
  '/mallSearchPage':(context)=>SearchPage(),
  '/commodityPage':(context)=>CommodityPage(),
  '/commodityDetailPage':(context)=>CommodityDetailPage(),
  '/country_page.dart':(context)=>CountryPage(),
  '/bindingSignIn':(context)=>BindingSignInPage(),
  '/loginPage':(context)=>LoginPage(),
  '/regiseredPage':(context)=>RegisteredPage(),
  '/orderDetailPage':(context)=>OrderDetailPage(),
  '/homePage':(context)=>HomePage(),
  '/allPage':(context)=>AllPage(),
  '/myOrderPage':(context)=>MyOrderPage(),
  '/venuesMapPage':(context,{arguments})=>VenuesMapPage(hallsData: arguments,),
  '/showTickets':(context,{arguments})=>ShowTicketsPage(showId: arguments,),
  // '/brandMallPage':(context)=>BrandMallPage(),
  '/homePortletsDetailsPage':(context,{arguments})=>HomePortletsDetailsPage(contentID: arguments,),
  '/ProfilePage':(context)=>ProfilePage(),
  '/SignProtocolPage':(context)=>SignProtocolPage(),
  '/drawPage':(context)=>DrawPage(),
  '/drawDetailsPage':(context,{arguments})=>DrawDetailsPage(shopID: arguments,),
  '/registrationInformationPage':(context,{arguments})=>RegistrationInformationPage(lotteryRegistrationPageModel: arguments,),
  '/registrationSuccessfulPage':(context,{arguments})=>RegistrationSuccessfulPage(draweeModel: arguments,),
  '/checkTheRegistrationPage':(context,{arguments})=>CheckTheRegistrationPage(draweeModel:arguments ,),
  '/drawRegisteredPage':(context)=>DrawRegisteredPage(),
  '/endOfTheDrawPage':(context,{arguments})=>EndOfTheDrawPage(pics: arguments,),
  ///DrawDetailsPage
  /////RegistrationInformationPage
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  print('settings:->${settings.name}');
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      print('arguments->${settings.arguments}');
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
