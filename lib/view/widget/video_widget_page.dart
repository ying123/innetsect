import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/widget/video_widget_provide.dart';
import 'package:provide/provide.dart';
import 'package:video_player/video_player.dart';

class VideoWidgetPage extends PageProvideNode {
  final String url;
  final String previewImgUrl; //预览图片的地址
  final bool showProgressBar; //是否显示进度条
  final bool showProgressText; //是否显示进度文本
  final int positionTag;
  final VideoWidgetProvide _provide = VideoWidgetProvide();
  VideoWidgetPage(
      {this.url,
      this.previewImgUrl,
      this.showProgressBar,
      this.showProgressText,
      this.positionTag}) {
    mProviders.provide(Provider.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return VideoWidgetContentPage(_provide, this.url, this.previewImgUrl,
        this.showProgressBar, this.showProgressText, this.positionTag);
  }
}

class VideoWidgetContentPage extends StatefulWidget {
  final String url;
  final String previewImgUrl; //预览图片的地址
  final bool showProgressBar; //是否显示进度条
  final bool showProgressText; //是否显示进度文本
  final int positionTag;
  final VideoWidgetProvide _provide;
  VideoWidgetContentPage(this._provide, this.url, this.previewImgUrl,
      this.showProgressBar, this.showProgressText, this.positionTag);
  @override
  _VideoWidgetContentPageState createState() => _VideoWidgetContentPageState();
}

class _VideoWidgetContentPageState extends State<VideoWidgetContentPage> {
  ///视频播放控制器
  VideoPlayerController _controller;

  VideoWidgetProvide _provide;
  @override
  void initState() {
    _provide ??= widget._provide;
    super.initState();

    _controller = VideoPlayerController.asset(widget.url)
      ..initialize()
      ..setLooping(true).then((_) {
        _controller.play();
        _provide.videoPrepared = true;
      });
  }

  @override
  void dispose() {
    //释放播放器资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _setupVideo(),
        getPreviewImg(),
      ],
    );
  }

//设置视屏
  Provide<VideoWidgetProvide> _setupVideo() {
    return Provide<VideoWidgetProvide>(
      builder:
          (BuildContext context, Widget child, VideoWidgetProvide provide) {
        return GestureDetector(
          child: Stack(
            children: <Widget>[
              VideoPlayer(_controller),
            ],
          ),
          onTap: () {
            if (_controller.value.isPlaying) {
              _controller.pause();
              provide.hideActionButton = false;
            } else {
              _controller.play();
              provide.videoPrepared = true;
              provide.hideActionButton = true;
            }
          },
        );
      },
    );
  }

  Provide<VideoWidgetProvide> getPreviewImg() {
    return Provide<VideoWidgetProvide>(
      builder:
          (BuildContext context, Widget child, VideoWidgetProvide provide) {
        return Offstage(
            offstage: provide.videoPrepared,
            child: Image.asset(
              widget.previewImgUrl,
              fit: BoxFit.cover,
              width: ScreenAdapter.getScreenPxWidth(),
              height: ScreenAdapter.getScreenPxHeight(),
            ));
      },
    );
  }
}
