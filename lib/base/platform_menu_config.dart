/// 菜单配置
class PlatFormMenu{
  int index;
  String title;
  String icon;
  String selIcon;

  PlatFormMenu({this.index,this.title,this.icon,this.selIcon});
}

/// 商城首页头部导航
List<PlatFormMenu> mallTabBarList = [
  PlatFormMenu(index: 0,title: "热卖"),
  PlatFormMenu(index: 1,title: "新品"),
  PlatFormMenu(index: 2,title: "人气")
];

/// 商城底部导航
List<PlatFormMenu> mallNavBarList = [
  PlatFormMenu(index: 0,title: "热卖",
    icon: "assets/images/mall/tab_news.png",
    selIcon: "assets/images/mall/tab_news_h.png",
  ),
  PlatFormMenu(index:1,title: "潮人",
    icon: "assets/images/mall/tab_star.png",
    selIcon: "assets/images/mall/tab_star_h.png",
  ),
  PlatFormMenu(index:1,title: "首页",
    icon: "assets/images/mall/tab_home.png",
    selIcon: "assets/images/mall/tab_home_h.png",
  ),
  PlatFormMenu(index:1,title: "商城",
    icon: "assets/images/mall/tab_mall.png",
    selIcon: "assets/images/mall/tab_mall_h.png",
  ),
  PlatFormMenu(index:1,title: "我的",
    icon: "assets/images/mall/tab_me.png",
    selIcon: "assets/images/mall/tab_me_h.png",
  ),
];

