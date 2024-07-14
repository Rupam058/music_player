import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: const Text(
          'S E T T I N G S',
          style: TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // dark Mode
            const Text(
              'Dark Mode',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            // switch
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false).toggletheme();
              },
            )
          ],
        ),
      ),
    );
  }
}
