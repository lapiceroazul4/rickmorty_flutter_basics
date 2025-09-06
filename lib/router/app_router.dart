import 'package:flutter/material.dart';
import 'package:test_app/models/menu_option.dart';
import 'package:test_app/screens/screens.dart';

class AppRouter {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    MenuOption(
      route: 'home',
      name: 'Home',
      screen: const HomePage(),
      icon: Icons.home,
    ),
    MenuOption(
      route: 'characters',
      name: 'Characters',
      screen: const CharactersScreen(),
      icon: Icons.person,
    ),
    MenuOption(
      route: 'locations',
      name: 'Locations',
      screen: const LocationsScreen(),
      icon: Icons.place,
    ),
    MenuOption(
      route: 'episodes',
      name: 'Episodes',
      screen: const EpisodesScreen(),
      icon: Icons.movie,
    ),
    MenuOption(
      route: 'search_location',
      name: 'Search Location',
      screen: const SearchLocationScreen(),
      icon: Icons.search,
    ),
    // puedes dejar las otras que ya tenías
    MenuOption(
      route: 'listview1',
      name: 'List View Tipo 1',
      screen: const Listview1Screen(),
      icon: Icons.list,
    ),
    MenuOption(
      route: 'listview2',
      name: 'List View Tipo 2',
      screen: const Listview2Screen(),
      icon: Icons.list_alt_outlined,
    ),
    MenuOption(
      route: 'alert',
      name: 'Alerta',
      screen: const AlertScreen(),
      icon: Icons.align_vertical_bottom,
    ),
    MenuOption(
      route: 'card',
      name: 'Tarjetas',
      screen: const CardScreen(),
      icon: Icons.credit_card,
    ),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
