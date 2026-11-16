import 'package:cs310_watchlist/main.dart';
import 'package:cs310_watchlist/movie.dart';
import 'package:cs310_watchlist/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('captures the six screens from a real app session', (
    tester,
  ) async {
    await tester.pumpWidget(const WatchlistApp());
    await tester.pumpAndSettle();
    if (defaultTargetPlatform == TargetPlatform.android) {
      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
    }

    Future<void> capture(String file) async {
      await tester.pumpAndSettle();
      await binding.takeScreenshot(file);
    }

    Future<void> tap(Finder finder) async {
      await tester.ensureVisible(finder);
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }

    Finder tab(String title) => find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(title),
    );

    await capture('01 Login');
    await tap(find.text('New here? Sign up'));
    await capture('02 Sign up');

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'demo@example.com');
    await tester.enterText(fields.at(1), 'movie123');
    await tap(find.text('Create account'));
    await capture('07 Form confirmation');
    await tap(find.text('Continue'));

    final cardContext = tester.element(find.byType(Dismissible));
    await precacheImage(
      NetworkImage(sampleMovies.first.posterUrl),
      cardContext,
    );
    await capture('03 Discover');
    await tap(find.text('Filters'));
    await capture('08 Filters');
    await tap(find.text('Cancel'));
    await tap(find.text('Save'));
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    await tap(tab('Search'));
    await tester.enterText(find.byType(TextField), 'Interstellar');
    await tap(find.widgetWithText(FilledButton, 'Search'));
    await capture('04 Search');
    await tap(find.widgetWithText(MovieRow, 'Interstellar'));
    await capture('05 Movie details');
    await tap(find.byTooltip('Back'));
    await tap(tab('Watchlist'));
    await tap(find.text('Watched'));
    await tap(find.byTooltip('Rate Interstellar 4 out of 5'));
    await capture('06 Watchlist');
    expect(find.text('Your rating: 4/5'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
