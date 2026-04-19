import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers.',
    popularity: 60.441,
    posterPath: '/posterPath',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieNullFields = Movie(
    adult: false,
    backdropPath: null,
    genreIds: [],
    id: 1,
    originalTitle: null,
    overview: null,
    popularity: 1,
    posterPath: null,
    releaseDate: null,
    title: null,
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('MovieCard should display movie title and overview',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieCard(tMovie)));

    expect(find.text('Spider-Man'), findsOneWidget);
    expect(
        find.text(
            'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers.'),
        findsOneWidget);
  });

  testWidgets('MovieCard should display dash when title and overview are null',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(_makeTestableWidget(MovieCard(tMovieNullFields)));

    expect(find.text('-'), findsWidgets);
  });

  testWidgets('MovieCard should display Card widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieCard(tMovie)));

    expect(find.byType(Card), findsOneWidget);
  });

  testWidgets('MovieCard should display InkWell widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(MovieCard(tMovie)));

    expect(find.byType(InkWell), findsOneWidget);
  });
}