import 'package:beautiful_girl_photo/image_bottom_sheet.dart';
import 'package:beautiful_girl_photo/is_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Photo UI',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _categories = [
    'For you',
    'News',
    'Unisex',
    'Korea Style',
    'Uzzizang'
  ];

  final List<String> _imagesUrl_1 = [
    'https://i.pinimg.com/564x/8e/f1/97/8ef197feac317adcd17e3a210213ae86.jpg',
    'https://i.pinimg.com/564x/2c/84/41/2c8441dc134ddc8c883d13eef09bd5ce.jpg',
    'https://i.pinimg.com/564x/cd/74/ce/cd74ceb636c9a10b291af1962d68acf6.jpg',
    'https://i.pinimg.com/564x/33/49/8c/33498c46fa93859a58aa3682034a6b5b.jpg',
    'https://i.pinimg.com/564x/39/23/cf/3923cf091e22bcc07f11d9973810ac5f.jpg',
    'https://i.pinimg.com/564x/35/bc/a2/35bca2b691a7ac0ef98901a473bd640b.jpg',
    'https://i.pinimg.com/564x/ec/b2/62/ecb262307fae651ad3b918e2a7ad2db3.jpg',
    'https://i.pinimg.com/564x/8c/24/53/8c24534bde83f4a0d0abc0573c312bb7.jpg',
    'https://i.pinimg.com/564x/eb/fa/29/ebfa2919775d262a18eed3151439abc7.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
    'https://i.pinimg.com/564x/7e/51/dc/7e51dc72a662ced3451260de035bf412.jpg',
    'https://i.pinimg.com/564x/12/76/56/1276560f894e1fcc86c047ca005650a2.jpg'
        /**/
        'https://i.pinimg.com/564x/8e/f1/97/8ef197feac317adcd17e3a210213ae86.jpg',
    'https://i.pinimg.com/564x/2c/84/41/2c8441dc134ddc8c883d13eef09bd5ce.jpg',
    'https://i.pinimg.com/564x/cd/74/ce/cd74ceb636c9a10b291af1962d68acf6.jpg',
    'https://i.pinimg.com/564x/33/49/8c/33498c46fa93859a58aa3682034a6b5b.jpg',
    'https://i.pinimg.com/564x/39/23/cf/3923cf091e22bcc07f11d9973810ac5f.jpg',
    'https://i.pinimg.com/564x/35/bc/a2/35bca2b691a7ac0ef98901a473bd640b.jpg',
    'https://i.pinimg.com/564x/ec/b2/62/ecb262307fae651ad3b918e2a7ad2db3.jpg',
    'https://i.pinimg.com/564x/8c/24/53/8c24534bde83f4a0d0abc0573c312bb7.jpg',
    'https://i.pinimg.com/564x/eb/fa/29/ebfa2919775d262a18eed3151439abc7.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
    'https://i.pinimg.com/564x/7e/51/dc/7e51dc72a662ced3451260de035bf412.jpg',
    'https://i.pinimg.com/564x/12/76/56/1276560f894e1fcc86c047ca005650a2.jpg'
  ];

  final List<String> _imagesUrl_2 = [
    'https://i.pinimg.com/564x/eb/fa/29/ebfa2919775d262a18eed3151439abc7.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
    'https://i.pinimg.com/564x/7e/51/dc/7e51dc72a662ced3451260de035bf412.jpg',
    'https://i.pinimg.com/564x/12/76/56/1276560f894e1fcc86c047ca005650a2.jpg'
  ];

  final List<String> _imagesUrl_3 = [
    'https://i.pinimg.com/564x/7e/51/dc/7e51dc72a662ced3451260de035bf412.jpg',
    'https://i.pinimg.com/564x/12/76/56/1276560f894e1fcc86c047ca005650a2.jpg'
        'https://i.pinimg.com/564x/eb/fa/29/ebfa2919775d262a18eed3151439abc7.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
  ];

  final List<String> _imagesUrl_4 = [
    'https://i.pinimg.com/564x/2c/84/41/2c8441dc134ddc8c883d13eef09bd5ce.jpg',
    'https://i.pinimg.com/564x/cd/74/ce/cd74ceb636c9a10b291af1962d68acf6.jpg',
    'https://i.pinimg.com/564x/33/49/8c/33498c46fa93859a58aa3682034a6b5b.jpg',
    'https://i.pinimg.com/564x/39/23/cf/3923cf091e22bcc07f11d9973810ac5f.jpg',
    'https://i.pinimg.com/564x/35/bc/a2/35bca2b691a7ac0ef98901a473bd640b.jpg',
    'https://i.pinimg.com/564x/ec/b2/62/ecb262307fae651ad3b918e2a7ad2db3.jpg',
    'https://i.pinimg.com/564x/8c/24/53/8c24534bde83f4a0d0abc0573c312bb7.jpg',
    'https://i.pinimg.com/564x/eb/fa/29/ebfa2919775d262a18eed3151439abc7.jpg',
    'https://i.pinimg.com/564x/bc/67/80/bc6780c97cf6e8da6ec2789004a55ca8.jpg',
  ];

  final List<String> _imagesUrl_5 = [];

  int _categoriesSelected = 0;

  final List<List<String>> _tabsUrl = [];

  int _crossAxisCount = 4;

  @override
  void initState() {
    _tabsUrl.addAll([
      _imagesUrl_1,
      _imagesUrl_2,
      _imagesUrl_3,
      _imagesUrl_4,
      _imagesUrl_5,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _crossAxisCount =
        MediaQuery.of(context).size.width < MediaQuery.of(context).size.height
            ? 4
            : 8;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (_, __) {
                  return [
                    SliverAppBar(
                      primary: true,
                      backgroundColor: Colors.white,
                      elevation: 10,
                      expandedHeight: 200,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: _header(),
                      ),
                      bottom: _navigate(),
                    )
                  ];
                },
                body: Images(
                  _tabsUrl[_categoriesSelected],
                  crossAxisCount: _crossAxisCount,
                  onImageTapped: (url, index) {
                    /*   Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ImageBottomSheet(
                                url, MediaQuery.of(context).padding.top)));*/
                    showModalBottomSheet(
                        isScrollControlled: true,
                        elevation: 15,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_) {
                          return ImageBottomSheet(
                              url,
                              MediaQuery.of(context).padding.top,
                              _tabsUrl[_categoriesSelected],
                              index);
                        });
                  },
                ),
              ),
            );
          },
        ));
  }

  Widget _header() => Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        alignment: FractionalOffset.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'Life style',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
        ),
      );

  Widget _navigate() => PreferredSize(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: FractionalOffset.centerLeft,
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories
                  .asMap()
                  .entries
                  .map((entry) => Container(
                        height: 45,
                        child: FlatButton(
                          onPressed: () {
                            _categoriesSelected = entry.key;
                            setState(() {});
                          },
                          color: entry.key == _categoriesSelected
                              ? Colors.black.withOpacity(0.2)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Text(
                            _categories[entry.key],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          5,
        ),
      );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ) // Or Brightness.dark
        );
  }
}

class Images extends StatefulWidget {
  final List<String> _imagesUrl;
  final Function(String, int) onImageTapped;
  final crossAxisCount;

  Images(this._imagesUrl, {this.onImageTapped, this.crossAxisCount});

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Widget _body() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          addAutomaticKeepAlives: true,
          shrinkWrap: true,
          itemCount: widget._imagesUrl.length,
          crossAxisCount: widget.crossAxisCount,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                widget.onImageTapped(widget._imagesUrl[index], index);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: isMobile(context)
                        ? CachedNetworkImage(
                            placeholderFadeInDuration:
                                Duration(milliseconds: 1000),
                            imageUrl: widget._imagesUrl[index],
                            fit: BoxFit.fitWidth,
                          )
                        : Image.network(
                            widget._imagesUrl[index],
                            fit: BoxFit.fitWidth,
                          )),
              ),
            );
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        ),
      );
}
