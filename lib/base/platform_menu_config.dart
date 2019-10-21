/// 菜单配置
class PlatFormMenu{
  final int index;
  final String title;
  final String icon;
  final String selIcon;

  const PlatFormMenu({this.index,this.title,this.icon,this.selIcon});
}

/// 商城首页头部导航
const List<PlatFormMenu> mallTabBarList = const <PlatFormMenu>[
  const PlatFormMenu(index: 0,title: "热卖"),
  const PlatFormMenu(index: 1,title: "新品")
];

/// 商城底部导航
const List<PlatFormMenu> mallNavBarList = const <PlatFormMenu>[
  const PlatFormMenu(index: 0,title: "热卖",
    icon: "assets/images/mall/tab_news.png",
    selIcon: "assets/images/mall/tab_news_h.png",
  ),
  const PlatFormMenu(index:1,title: "潮人",
    icon: "assets/images/mall/tab_star.png",
    selIcon: "assets/images/mall/tab_star_h.png",
  ),
  const PlatFormMenu(index:1,title: "首页",
    icon: "assets/images/mall/tab_home.png",
    selIcon: "assets/images/mall/tab_home_h.png",
  ),
  const PlatFormMenu(index:1,title: "商城",
    icon: "assets/images/mall/tab_mall.png",
    selIcon: "assets/images/mall/tab_mall_h.png",
  ),
  const PlatFormMenu(index:1,title: "我的",
    icon: "assets/images/mall/tab_me.png",
    selIcon: "assets/images/mall/tab_me_h.png",
  ),
];

/// 商品详情导航栏
const List<PlatFormMenu> detailTabBarList = const <PlatFormMenu>[
  const PlatFormMenu( index: 0,title: "商品" ),
  const PlatFormMenu( index: 1,title: "详情" )
];

