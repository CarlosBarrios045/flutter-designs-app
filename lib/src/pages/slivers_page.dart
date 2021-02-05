import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Theme
import 'package:designs_app/src/theme/theme.dart';

class SliversPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _MainScroll(),
        Positioned(right: 0, bottom: -10, child: _ButtonNewTask())
      ],
    ));
  }
}

class _ButtonNewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Provider.of<ThemeChanger>(context);

    return ButtonTheme(
      minWidth: size.width * 0.9,
      height: 100.0,
      child: RaisedButton(
        onPressed: () {},
        color: theme.currentTheme.accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0))),
        child: Text('Create new list',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.darkTheme || theme.customTheme
                    ? Colors.black87
                    : Colors.white,
                letterSpacing: 3.0)),
      ),
    );
  }
}

class _MainScroll extends StatelessWidget {
  final items = [
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
    _ListItem('Orange', Color(0xffF08F66)),
    _ListItem('Family', Color(0xffF2A38A)),
    _ListItem('Subscriptions', Color(0xffF7CDD5)),
    _ListItem('Books', Color(0xffFCEBAF)),
  ];

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return CustomScrollView(
      slivers: [
        /* SliverAppBar(
          floating: true,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.red,
          title: Text('Hello world'),
        ), */
        SliverPersistentHeader(
            floating: true,
            delegate: _SliverCustomHeaderDelegate(
                minHeight: 200,
                maxHeight: 205,
                child: Container(
                    alignment: Alignment.centerLeft,
                    color: currentTheme.scaffoldBackgroundColor,
                    child: _Title()))),
        SliverList(
          delegate: SliverChildListDelegate([
            ...items,
            SizedBox(
              height: 120.0,
            )
          ]),
        )
      ],
    );
  }
}

class _SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverCustomHeaderDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _SliverCustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return Container(
      child: Column(
        children: [
          SizedBox(height: 30.0),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text('New',
                  style: TextStyle(
                      color: theme.darkTheme || theme.customTheme
                          ? Colors.grey
                          : Color(0xff532128),
                      fontSize: 50.0))),
          Stack(
            children: [
              SizedBox(width: 100.0),
              Positioned(
                  bottom: 2,
                  child: Container(
                      width: 100.0,
                      height: 6.0,
                      color: theme.darkTheme || theme.customTheme
                          ? Colors.grey
                          : Color(0xffF7CDD5))),
              Container(
                child: Text('List',
                    style: TextStyle(
                        color: Color(0xffD93A30),
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final Color color;

  _ListItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(30.0),
      margin: EdgeInsets.all(10.0),
      height: 120.0,
      decoration: BoxDecoration(
          color: this.color, borderRadius: BorderRadius.circular(30.0)),
      child: Text(this.title,
          style: TextStyle(
              color: theme.darkTheme || theme.customTheme
                  ? Colors.black87
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0)),
    );
  }
}
