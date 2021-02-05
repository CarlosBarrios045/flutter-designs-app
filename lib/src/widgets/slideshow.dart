import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool positionUp;
  final Color colorPrimary;
  final Color colorSecundary;
  final double dotSelectedSize;
  final double dotUnselectedSize;

  Slideshow({
    @required this.slides,
    this.positionUp = false,
    this.colorPrimary = Colors.blue,
    this.colorSecundary = Colors.grey,
    this.dotSelectedSize = 12.0,
    this.dotUnselectedSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _SlideshowModel(),
        child: SafeArea(child: Center(
          child: Builder(builder: (BuildContext context) {
            final provider = Provider.of<_SlideshowModel>(context);

            provider.colorPrimary = this.colorPrimary;
            provider.colorSecundary = this.colorSecundary;
            provider.dotSelectedSize = this.dotSelectedSize;
            provider.dotUnselectedSize = this.dotUnselectedSize;

            return Column(
              children: [
                if (this.positionUp) _Dots(this.slides.length),
                Expanded(child: _Slides(this.slides)),
                if (!this.positionUp) _Dots(this.slides.length),
              ],
            );
          }),
        )));
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      // Update provider
      Provider.of<_SlideshowModel>(context, listen: false).currentPage =
          pageViewController.page.round();
    });
  }

  @override
  void dispose() {
    pageViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PageView(
            controller: pageViewController,
            children: widget.slides.map((slide) {
              return _Slide(slide);
            }).toList()));
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30.0),
        child: slide);
  }
}

class _Dots extends StatelessWidget {
  final int count;

  _Dots(this.count);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          /* children: [
            _Dot(0),
            _Dot(1),
            _Dot(2),
          ], */
          children: List.generate(this.count, (i) => _Dot(i)),
        ));
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SlideshowModel>(context);
    final size = (ssModel.currentPage == index)
        ? ssModel.dotSelectedSize
        : ssModel.dotUnselectedSize;
    final color = (ssModel.currentPage == index)
        ? ssModel.colorPrimary
        : ssModel.colorSecundary;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _SlideshowModel with ChangeNotifier {
  int _currentPage = 0;
  Color _colorPrimary = Colors.blue;
  Color _colorSecundary = Colors.grey;
  double _dotSelectedSize = 12.0;
  double _dotUnselectedSize = 12.0;

  int get currentPage => this._currentPage;

  set currentPage(int currentPage) {
    this._currentPage = currentPage;
    notifyListeners();
  }

  Color get colorPrimary => this._colorPrimary;

  set colorPrimary(Color colorPrimary) {
    this._colorPrimary = colorPrimary;
  }

  Color get colorSecundary => this._colorSecundary;

  set colorSecundary(Color colorSecundary) {
    this._colorSecundary = colorSecundary;
  }

  double get dotSelectedSize => this._dotSelectedSize;

  set dotSelectedSize(double dotSelectedSize) {
    this._dotSelectedSize = dotSelectedSize;
  }

  double get dotUnselectedSize => this._dotUnselectedSize;

  set dotUnselectedSize(double dotUnselectedSize) {
    this._dotUnselectedSize = dotUnselectedSize;
  }
}
