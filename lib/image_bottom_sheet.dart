import 'dart:ui';

import 'package:beautiful_girl_photo/is_mobile.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageBottomSheet extends StatefulWidget {
  final String imageUrl;
  final _statusBarHeight;
  final List<String> _imagesUrl;
  final int index;

  ImageBottomSheet(
      this.imageUrl, this._statusBarHeight, this._imagesUrl, this.index);

  @override
  _ImageBottomSheetState createState() => _ImageBottomSheetState();
}

class _ImageBottomSheetState extends State<ImageBottomSheet> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.index, viewportFraction: 1);
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
            children: widget._imagesUrl.map((ele) => _image(ele)).toList()),
        Positioned(
          bottom: widget._statusBarHeight - 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 35,
              height: 35,
              padding: EdgeInsets.zero,
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _image(String imgUrl) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        widget._statusBarHeight -
                        20),
                margin: EdgeInsets.only(
                    top: widget._statusBarHeight + 10,
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
                          imageUrl: imgUrl,
                          fit: BoxFit.scaleDown,
                          alignment: FractionalOffset.center,
                        )
                      : Image.network(
                          imgUrl,
                          fit: BoxFit.scaleDown,
                          alignment: FractionalOffset.center,
                        ),
                )),
          ),
        ],
      );
}
