import 'dart:ui';
import 'package:beautiful_girl_photo/models/image_model.dart';
import 'package:beautiful_girl_photo/notifies/images_notify.dart';
import 'package:beautiful_girl_photo/pages/widgets/blur_button.dart';
import 'package:beautiful_girl_photo/pages/widgets/heart_btn.dart';
import 'package:beautiful_girl_photo/utils/is_mobile.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageBottomSheet extends StatefulWidget {
  final Key key;
  final ImageModel img;
  final double statusBarHeight;
  final double navigateBarHeight;
  final List<ImageModel> imgs;
  final int indexStart;
  final ImagesNotify notify;

  ImageBottomSheet(
      {this.key,
      this.img,
      this.statusBarHeight,
      this.navigateBarHeight,
      this.imgs,
      this.indexStart,
      this.notify})
      : super(key: key);

  @override
  _ImageBottomSheetState createState() => _ImageBottomSheetState();
}

class _ImageBottomSheetState extends State<ImageBottomSheet> {
  PageController _pageController;
  ImageModel _currentImg;

  @override
  void initState() {
    super.initState();
    _currentImg = widget.imgs[widget.indexStart];
    _pageController =
        PageController(initialPage: widget.indexStart, viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0),
              )),
        ),
        PageView(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            onPageChanged: (page) {
              _currentImg = widget.imgs[page];

              setState(() {});
            },
            children: widget.imgs.map((ele) => _image(ele)).toList()),
        Positioned(
          top: widget.statusBarHeight + 10,
          right: 10,
          child: BlurButton(
            child: Icon(
              Icons.clear,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Positioned(
          bottom: widget.navigateBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _currentImg.heartCount == 0
                        ? ''
                        : '+${_currentImg.heartCount.toStringAsFixed(0)}',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  HeartBtn(hasSelected: _currentImg.heart)
                ],
              ),
              SizedBox(width: 7),
              BlurButton(
                child: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                  size: 20,
                ),
                opacity: 0.1,
                onPressed: () {
                  widget.notify.save(_currentImg);
                },
              ),
              SizedBox(width: 7),
              BlurButton(
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20,
                ),
                opacity: 0.1,
              ),
              SizedBox(width: 7),
            ],
          ),
        )
      ],
    );
  }

  Widget _image(ImageModel _img) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        widget.statusBarHeight -
                        20),
                margin: EdgeInsets.only(
                    top: widget.statusBarHeight + 10,
                    bottom: 10,
                    left: 5,
                    right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: isMobile(context)
                      ? CachedNetworkImage(
                          progressIndicatorBuilder: (_, __, ___) {
                            return Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 30,
                            );
                          },
                          placeholder: (_, __) {
                            return Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 30,
                            );
                          },
                          errorWidget: (_, __, ___) {
                            return Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 30,
                            );
                          },
                          placeholderFadeInDuration:
                              Duration(milliseconds: 1000),
                          imageUrl: _img.thumbnail,
                          fit: BoxFit.scaleDown,
                          alignment: FractionalOffset.center,
                        )
                      : Image.network(
                          _img.thumbnail,
                          fit: BoxFit.scaleDown,
                          alignment: FractionalOffset.center,
                        ),
                )),
          ),
        ],
      );
}
