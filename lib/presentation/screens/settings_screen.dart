import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/backup_service.dart';
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
        await NotificationService().showInstantNotification("Notifications Enabled", "You will be reminded about your tasks and assignments!");
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
            title: const Text("Task & Assignment Reminders"),
            subtitle: const Text("Get notified about upcoming deadlines"),
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
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Data Management", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          ListTile(
            leading: const Icon(Icons.save_alt, color: Colors.blue),
            title: const Text("Backup Data"),
            subtitle: const Text("Export your data to a file"),
            onTap: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Generating backup...")),
              );
              try {
                await BackupService().exportData();
                // Share plugin handles the success UI mostly (by opening share sheet)
              } catch (e) {
                if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Backup Failed: $e")));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.restore, color: Colors.orange),
            title: const Text("Restore Data"),
            subtitle: const Text("Import data from a backup file"),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                  title: const Text("Restore Data?"),
                  content: const Text("WARNING: This will DELETE all current data and replace it with the backup. This cannot be undone."),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(c, false), child: const Text("Cancel")),
                    TextButton(onPressed: () => Navigator.pop(c, true), child: const Text("Proceed", style: TextStyle(color: Colors.red))),
                  ],
                ),
              );

              if (confirm == true) {
                 if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Restoring data...")));
                 try {
                   final success = await BackupService().importData();
                   if (mounted) {
                     if (success) {
                       showDialog(
                         context: context,
                         builder: (c) => const AlertDialog(
                           title: Text("Restore Successful"),
                           content: Text("Data has been restored. Please restart the app to see all changes."),
                         ),
                       );
                     } else {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Restore Cancelled or Failed")));
                     }
                   }
                 } catch (e) {
                   if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
                 }
              }
            },
          ),
        ],
      ),
    );
  }
}
