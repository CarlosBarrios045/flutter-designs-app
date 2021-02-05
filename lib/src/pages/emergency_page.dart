import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart' show FadeInLeft;

// Widgets
import 'package:designs_app/src/widgets/headers.dart';
import 'package:designs_app/src/widgets/button_option.dart';

class ItemBoton {
  final IconData icon;
  final String title;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.title, this.color1, this.color2);
}

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.height > 550;

    final items = <ItemBoton>[
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
      new ItemBoton(FontAwesomeIcons.carCrash, 'Motor Accident',
          Color(0xff6989F5), Color(0xff906EF5)),
      new ItemBoton(FontAwesomeIcons.plus, 'Medical Emergency',
          Color(0xff66A9F2), Color(0xff536CF6)),
      new ItemBoton(FontAwesomeIcons.theaterMasks, 'Theft / Harrasement',
          Color(0xffF2D572), Color(0xffE06AA3)),
      new ItemBoton(FontAwesomeIcons.biking, 'Awards', Color(0xff317183),
          Color(0xff46997D)),
    ];

    List<Widget> itemWidgets = items
        .map((item) => FadeInLeft(
              duration: Duration(milliseconds: 250),
              child: ButtonOption(
                onPress: () {},
                title: item.title,
                icon: item.icon,
                color1: item.color1,
                color2: item.color2,
              ),
            ))
        .toList();

    return Scaffold(
        body: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: isLarge ? 220 : 10),
          child: SafeArea(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [SizedBox(height: 80.0), ...itemWidgets],
            ),
          ),
        ),
        if (isLarge) _Header()
      ],
    ));
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconHeader(
          icon: FontAwesomeIcons.plus,
          color1: Color(0xff526BF6),
          color2: Color(0xff67ACF2),
          subtitle: 'Haz solicitado',
          title: 'Asistencia médica',
        ),
        Positioned(
          right: -20,
          top: 50,
          child: RawMaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              padding: EdgeInsets.all(10.0),
              child: FaIcon(FontAwesomeIcons.ellipsisV, color: Colors.white)),
        )
      ],
    );
  }
}
