import 'package:cs310_watchlist/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  }

  Future<void> fillAccess(WidgetTester tester) async {
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'demo@example.com');
    await tester.enterText(fields.at(1), 'movie123');
  }

  Finder tab(String label) => find.descendant(
    of: find.byType(NavigationBar),
    matching: find.text(label),
  );

  for (final size in [const Size(320, 568), const Size(430, 932)]) {
    testWidgets('core flows work at ${size.width} × ${size.height}', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(size);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(const WatchlistApp());
      await tap(tester, find.text('Log in'));
      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);

      await tap(tester, find.text('New here? Sign up'));
      expect(find.text('Create an account'), findsOneWidget);
      await fillAccess(tester);
      await tap(tester, find.text('Create account'));
      expect(find.text('Preview ready'), findsOneWidget);
      await tap(tester, find.text('Cancel'));
      expect(find.text('Create an account'), findsOneWidget);
      await tap(tester, find.text('Already registered? Log in'));
      await fillAccess(tester);
      await tap(tester, find.text('Log in'));
      await tap(tester, find.text('Continue'));

      await tap(tester, find.text('Filters'));
      await tester.enterText(find.byType(TextFormField).last, 'abc');
      await tap(tester, find.text('Apply'));
      expect(find.text('Enter a year from 1888 to 2100'), findsOneWidget);
      await tap(tester, find.text('Cancel'));
      expect(find.text('Interstellar'), findsOneWidget);
      await tap(tester, find.text('Filters'));
      await tester.enterText(find.byType(TextFormField).last, '2019');
      await tap(tester, find.text('Apply'));
      expect(find.text('Parasite'), findsOneWidget);

      final card = find.byType(Dismissible);
      await tester.ensureVisible(card);
      await tester.drag(card, const Offset(280, 0));
      await tester.pumpAndSettle();
      expect(find.text('No more matching movies'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tap(tester, tab('Watchlist'));
      expect(find.text('Parasite'), findsOneWidget);
      await tap(tester, find.text('Watched'));
      expect(
        tester.widget<CheckboxListTile>(find.byType(CheckboxListTile)).value,
        isTrue,
      );
      await tap(tester, find.byTooltip('Rate Parasite 4 out of 5'));
      expect(find.text('Your rating: 4/5'), findsOneWidget);
      await tap(tester, find.text('Clear rating'));
      expect(find.text('Your rating: Unrated'), findsOneWidget);

      await tap(tester, tab('Search'));
      await tester.enterText(find.byType(TextField), 'xyzzy');
      await tap(tester, find.widgetWithText(FilledButton, 'Search'));
      expect(find.text('No movies found'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'inter');
      await tap(tester, find.widgetWithText(FilledButton, 'Search'));
      await tap(tester, find.text('Interstellar'));
      expect(find.text('Movie details'), findsOneWidget);
      await tap(tester, find.text('Add to watchlist'));
      expect(find.text('Remove from watchlist'), findsOneWidget);
      await tap(tester, find.byTooltip('Back'));
      expect(find.text('Results for “inter”'), findsOneWidget);
      await tap(tester, tab('Watchlist'));
      expect(find.text('2 saved'), findsOneWidget);
      await tap(tester, find.text('Remove').first);
      expect(find.text('1 saved'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await tap(tester, find.text('Remove'));
      expect(find.text('Your watchlist is empty'), findsOneWidget);
    });
  }
}
