import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
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

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1399,
    name: 'Game of Thrones',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Game of Thrones',
    overview: 'Seven noble families fight for control of the mythical land.',
    popularity: 1,
    posterPath: '/posterPath',
    voteAverage: 8.4,
    voteCount: 21390,
  );

  final tTvSeriesNullFields = TvSeries(
    backdropPath: null,
    firstAirDate: null,
    genreIds: [],
    id: 1,
    name: null,
    originCountry: [],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: null,
    popularity: 1,
    posterPath: null,
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('TvSeriesCard should display tv series name and overview',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(TvSeriesCard(tTvSeries)));

    expect(find.text('Game of Thrones'), findsOneWidget);
    expect(find.text('Seven noble families fight for control of the mythical land.'),
        findsOneWidget);
  });

  testWidgets('TvSeriesCard should display dash when name is null',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesCard(tTvSeriesNullFields)));

    expect(find.text('-'), findsWidgets);
  });

  testWidgets('TvSeriesCard should display dash when overview is null',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(_makeTestableWidget(TvSeriesCard(tTvSeriesNullFields)));

    expect(find.text('-'), findsWidgets);
  });

  testWidgets('TvSeriesCard should display Card widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(TvSeriesCard(tTvSeries)));

    expect(find.byType(Card), findsOneWidget);
  });

  testWidgets('TvSeriesCard should display InkWell widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(TvSeriesCard(tTvSeries)));

    expect(find.byType(InkWell), findsOneWidget);
  });
}