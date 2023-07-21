import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guava/atomic/zpages/info.dart';

class BuildPopupMenu extends StatelessWidget {
  const BuildPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text(
            'Contact',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            'Preferences',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
      icon: FaIcon(
        FontAwesomeIcons.sliders,
        color: Theme.of(context).colorScheme.tertiary,
      ), // Icône à afficher
      onSelected: (value) {
        // Gestion des actions sur la sélection d'un élément
        switch (value) {
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoPage(),
                ));
            break;
          case 2:
            Navigator.of(context).pushNamed("/preference_language");
            break;
        }
      },
    );
  }
}
