import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(FontAwesomeIcons.commentDots),
            title: Text(
              'Chat',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => GoRouter.of(context).push('/chat'),
          ),
        ],
      ),
    );
  }
}
