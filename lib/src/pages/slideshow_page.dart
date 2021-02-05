import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// widgets
import 'package:designs_app/src/widgets/slideshow.dart';

// Theme
import 'package:designs_app/src/theme/theme.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.height > 500;

    final List<Widget> children = [
      _MySlideshow(),
      _MySlideshow(),
    ];

    return Scaffold(
        body: isLarge
            ? Column(
                children: children,
              )
            : Row(children: children));
  }
}

class _MySlideshow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Expanded(
      child: Slideshow(
        colorPrimary: currentTheme.accentColor,
        dotSelectedSize: 14.0,
        dotUnselectedSize: 12.0,
        slides: [
          SvgPicture.asset('assets/svg/slide-1.svg'),
          SvgPicture.asset('assets/svg/slide-2.svg'),
          SvgPicture.asset('assets/svg/slide-3.svg'),
          SvgPicture.asset('assets/svg/slide-4.svg'),
          SvgPicture.asset('assets/svg/slide-5.svg'),
          SvgPicture.asset('assets/svg/slide-6.svg'),
          SvgPicture.asset('assets/svg/slide-7.svg'),
        ],
      ),
    );
  }
}
