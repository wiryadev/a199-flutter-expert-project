import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import 'search_tv_series_page_test.mocks.dart';

@GenerateMocks([TvSeriesSearchNotifier])
void main() {
  late MockTvSeriesSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesSearchNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(SearchTvSeriesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.searchResult).thenReturn([testWatchlistTvSeries]);

    await tester.pumpWidget(_makeTestableWidget(SearchTvSeriesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display empty container when state is empty',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Empty);

    await tester.pumpWidget(_makeTestableWidget(SearchTvSeriesPage()));

    expect(find.byType(ListView), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Page should call fetchTvSeriesSearch when search submitted',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Empty);

    await tester.pumpWidget(_makeTestableWidget(SearchTvSeriesPage()));

    await tester.enterText(find.byType(TextField), 'Game of Thrones');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    verify(mockNotifier.fetchTvSeriesSearch('Game of Thrones'));
  });
}