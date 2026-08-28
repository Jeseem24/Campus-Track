import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/participation_event_provider.dart';
import '../widgets/add_event_dialog.dart';
import '../../core/theme/modern_theme.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(participationEventListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements & Events'),
      ),
      body: eventsAsync.when(
        data: (events) {
          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events_outlined, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    "No events recorded yet.",
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add your hackathons and competitions!",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final date = DateTime.fromMillisecondsSinceEpoch(event.dateEpoch);

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              event.name,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ModernTheme.secondary,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () => ref.read(participationEventListProvider.notifier).deleteEvent(event.id!),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat.yMMMMd().format(date),
                            style: GoogleFonts.poppins(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      if (event.location != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              event.location!,
                              style: GoogleFonts.poppins(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                      if (event.description != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          event.description!,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text("Error: $e")),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddEventDialog(),
        ),
        label: const Text("Add Event"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
