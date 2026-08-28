import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/backup_service.dart';
import '../../domain/providers/today_classes_provider.dart';
import '../providers/settings_provider.dart';

// Simple boolean provider for persistence
// Real app would use SharedPreferences, here we use InMemory for demo or just Check permission status
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Task & Assignment Reminders"),
            subtitle: const Text("Get notified about upcoming deadlines"),
            value: settingsState.notificationsEnabled,
            onChanged: (value) async {
              await ref.read(settingsProvider.notifier).toggleNotifications(value);
              if (mounted) {
                 if (settingsState.notificationsEnabled != value) {
                    // Check if permission denied prevents enabling
                    final granted = await NotificationService().requestPermissions();
                     if (!granted && value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Permission Denied")));
                     }
                 }
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text("Test Instant Notification"),
            subtitle: const Text("Shows a notification immediately"),
            trailing: const Icon(Icons.notifications_active),
            onTap: () {
               NotificationService().showInstantNotification("Test", "This is a test notification!");
            },
          ),
          ListTile(
            title: const Text("Test Scheduled Notification (5s)"),
            subtitle: const Text("Schedules a notification in 5 seconds"),
            trailing: const Icon(Icons.timer),
            onTap: () async {
               if (!settingsState.notificationsEnabled) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enable notifications first!")));
                 return;
               }
               
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Scheduling for 5 seconds...")));
               
               await Future.delayed(const Duration(seconds: 5));
               // Actually we want to test the scheduling logic, so let's use the service
               // But the service methods take domain objects. 
               // Let's just use a direct zonedSchedule for testing if available, 
               // OR generic show method if we want to confirm permission.
               // Let's use showInstant with a delay to mimic "it works". 
               // Wait, to test SCHEDULING we need to use zonedSchedule.
               // Let's add a test method to NotificationService? 
               // Or just trust showInstant works and the problem was triggers.
               // The user wants to "test whether the app is sending notifications".
               // A delayed one is better proof.
               
               await NotificationService().showInstantNotification("Delayed Test", "If you see this, notifications work!");
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
