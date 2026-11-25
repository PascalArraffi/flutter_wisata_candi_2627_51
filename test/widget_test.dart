import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wisata_candi_2627_51/providers/favorite_provider.dart';
import 'package:flutter_wisata_candi_2627_51/screens/search_screen.dart';

void main() {
  test('FavoriteProvider toggles and counts favorites', () {
    final provider = FavoriteProvider();

    provider.toggle('Candi Borobudur');
    expect(provider.isFavorite('Candi Borobudur'), isTrue);
    expect(provider.count, 1);

    provider.toggle('Candi Borobudur');
    expect(provider.isFavorite('Candi Borobudur'), isFalse);
    expect(provider.count, 0);
  });

  testWidgets('SearchScreen filters temples and clears the query', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SearchScreen()));

    expect(find.text('Candi Borobudur'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Prambanan');
    await tester.pump();

    expect(find.text('Candi Prambanan'), findsOneWidget);
    expect(find.text('Candi Borobudur'), findsNothing);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    expect(find.text('Candi Borobudur'), findsOneWidget);
  });
}
