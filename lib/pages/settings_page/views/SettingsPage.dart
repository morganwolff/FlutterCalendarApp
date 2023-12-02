import 'package:flutter/material.dart';

import '../../../locals/local_storage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Settings Page"),
            ElevatedButton(onPressed: () {
              LocalStorage.deleteLocalFile("calendar1${LocalStorage.eventExtension}");
            }, child: const Text("Remove event")),
          ],
        ),
      ),
    );
  }
}