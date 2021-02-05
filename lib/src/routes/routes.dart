import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//  Pages
import 'package:designs_app/src/pages/slideshow_page.dart';
import 'package:designs_app/src/pages/pinterest_page.dart';
import 'package:designs_app/src/pages/notifications_page.dart';
import 'package:designs_app/src/pages/emergency_page.dart';
import 'package:designs_app/src/pages/headers_page.dart';
import 'package:designs_app/src/challenges/cuadrado_animated.dart';
import 'package:designs_app/src/pages/circular_graphs.dart';
import 'package:designs_app/src/pages/slivers_page.dart';

class _Route {
  final IconData icon;
  final String title;
  final Widget page;

  _Route(this.icon, this.title, this.page);
}

final List<_Route> pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.slideshare, 'Slideshow', SlideshowPage()),
  _Route(FontAwesomeIcons.pinterest, 'Pinterest', PinterestPage()),
  _Route(FontAwesomeIcons.bell, 'Notificaciones', NotificationsPage()),
  _Route(FontAwesomeIcons.ambulance, 'Emengencia', EmergencyPage()),
  _Route(FontAwesomeIcons.heading, 'Encabezados', HeadersPage()),
  _Route(FontAwesomeIcons.peopleCarry, 'Cuadro Animado', CuadradoAnimadoPage()),
  _Route(FontAwesomeIcons.circleNotch, 'Barra de progreso', CircularGraphs()),
  _Route(FontAwesomeIcons.mobile, 'Slivers', SliversPage()),
];
