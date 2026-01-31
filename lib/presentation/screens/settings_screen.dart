import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/notification_service.dart';
import '../../domain/providers/today_classes_provider.dart';

// Simple boolean provider for persistence
// Real app would use SharedPreferences, here we use InMemory for demo or just Check permission status
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    // We can't easily check 'status' without another plugin, 
    // but we can check if we successfully requested before.
    // For now, default false until toggled.
  }

  Future<void> _toggleNotifications(bool value) async {
    if (value) {
      final granted = await NotificationService().requestPermissions();
      if (granted) {
        setState(() => _notificationsEnabled = true);
        await NotificationService().showInstantNotification("Notifications Enabled", "You will be reminded 10 mins before classes!");
        // TODO: Schedule here
      } else {
        if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permission Denied")));
      }
    } else {
       // Cancel all?
       setState(() => _notificationsEnabled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Class Reminders"),
            subtitle: const Text("Get notified 10 minutes before each class"),
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
          ),
          const Divider(),
          ListTile(
            title: const Text("Test Notification"),
            trailing: const Icon(Icons.notifications_active),
            onTap: () {
               NotificationService().showInstantNotification("Test", "This is a test notification!");
            },
          )
        ],
      ),
    );
  }
}
