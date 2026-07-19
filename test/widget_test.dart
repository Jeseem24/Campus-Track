import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campus_track/main.dart';
import 'package:campus_track/domain/providers/active_semester_provider.dart';

void main() {
  testWidgets('App builds and shows welcome setup screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeSemesterProvider.overrideWith((ref) => Future.value(null)),
        ],
        child: const CampusTrackApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the setup/welcome page is shown when no semester is active
    expect(find.text("Welcome to CampusTrack"), findsOneWidget);
  });
}
