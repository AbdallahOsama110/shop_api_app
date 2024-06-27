import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/theme_switch_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => GoRouter.of(context).push('/profile'),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.mapLocationDot),
            title: Text(
              'Location',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => GoRouter.of(context).push('/location'),
          ),
          ListTile(
            leading: const Icon(Icons.nights_stay_rounded),
            title: Text(
              'Theme Mode',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: imageSwitch(),
          ),
        ],
      ),
    );
  }
}
