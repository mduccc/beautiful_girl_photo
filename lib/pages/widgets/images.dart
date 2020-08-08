import 'package:beautiful_girl_photo/models/image_model.dart';
import 'package:beautiful_girl_photo/notifies/images_notify.dart';
import 'package:beautiful_girl_photo/pages/widgets/image_bottom_sheet.dart';
import 'package:beautiful_girl_photo/repositories/images_repository.dart';
import 'package:beautiful_girl_photo/utils/is_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class Images extends StatefulWidget {
  final Key key;
  final String tabID;
  final double statusBarHeight;
  final double navigateBarHeight;
  final crossAxisCount;

  Images(this.tabID,
      {this.key,
      this.statusBarHeight = 0,
      this.navigateBarHeight = 0,
      this.crossAxisCount})
      : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  ImagesNotify _notify;

  @override
  void initState() {
    super.initState();
    _notify = ImagesNotify(FetchImagesRepositoryImpl(), widget.tabID);
    _notify.fetch();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => _notify,
        child: Consumer(
            builder: (BuildContext context, ImagesNotify value, Widget child) =>
                _body(value.imgs)),
      );

  Widget _body(List<ImageModel> imgs) => Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          addAutomaticKeepAlives: true,
          shrinkWrap: true,
          itemCount: imgs.length,
          crossAxisCount: widget.crossAxisCount,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    elevation: 15,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (_) {
                      return ImageBottomSheet(
                        img: imgs[index],
                        statusBarHeight: widget.statusBarHeight,
                        navigateBarHeight: widget.navigateBarHeight,
                        imgs: imgs,
                        indexStart: index,
                        notify: _notify,
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: isMobile(context)
                        ? CachedNetworkImage(
                            placeholderFadeInDuration:
                                Duration(milliseconds: 1000),
                            imageUrl: imgs[index].thumbnail,
                            fit: BoxFit.fitWidth,
                          )
                        : Image.network(
                            imgs[index].thumbnail,
                            fit: BoxFit.fitWidth,
                          )),
              ),
            );
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        ),
      );
}
