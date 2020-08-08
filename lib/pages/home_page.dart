import 'package:beautiful_girl_photo/notifies/tab_notify.dart';
import 'package:beautiful_girl_photo/pages/widgets/images.dart';
import 'package:beautiful_girl_photo/repositories/images_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _categoriesSelected = 0;
  BuildContext _context;

  final List<Widget> _tabs = [];

  int _crossAxisCount = 4;
  TabNotify _notify;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _context = context;
      setState(() {});
    });
    _notify = TabNotify(FetchImagesRepositoryImpl());
    _notify.fetch();
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
              child: ChangeNotifierProvider(
                create: (_) => _notify,
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
                  body: Consumer(builder:
                      (BuildContext context, TabNotify value, Widget child) {
                    if (_context == null) {
                      return Container();
                    }
                    if (_tabs.length == 0) {
                      _tabs.addAll(value.tabs
                          .map((ele) => Images(
                                ele.tabID,
                                key: Key(ele.tabID),
                                statusBarHeight:
                                    MediaQuery.of(_context).padding.top,
                                navigateBarHeight:
                                    MediaQuery.of(_context).padding.bottom,
                                crossAxisCount: _crossAxisCount,
                              ))
                          .toList());
                    }
                    if (_tabs.length == 0) {
                      return Container();
                    } else if (_categoriesSelected >= _tabs.length) {
                      _categoriesSelected = 0;
                      return _tabs[0];
                    }
                    return _tabs[_categoriesSelected];
                  }),
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
        child: Consumer(
          builder: (BuildContext context, TabNotify value, Widget child) =>
              Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15),
            alignment: FractionalOffset.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: value.tabs
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
                              value.tabs[entry.key].tabName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ))
                    .toList(),
              ),
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
