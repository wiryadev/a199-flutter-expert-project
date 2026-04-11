import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/models/tv_season_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl dataSource;
  late MockTvSeriesDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockTvSeriesDatabaseHelper();
    dataSource = TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => Future.value());
      // act
      final result = await dataSource.insertWatchlist(testTvSeriesDetail);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesDetail))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvSeriesDetail);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    final tId = 1399;

    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(tId))
          .thenAnswer((_) async => Future.value());
      // act
      final result = await dataSource.removeWatchlist(tId);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTvSeriesWatchlist(tId))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(tId);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get Tv Series By Id', () {
    final tId = 1399;

    test('should return TvSeriesTable when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesTable);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesTable]);
    });
  });

  group('get Seasons By Tv Series Id', () {
    final tId = 1399;

    test('should return list of TvSeasonTable when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeasonsByTvSeriesId(tId))
          .thenAnswer((_) async => [TvSeasonTable.fromEntity(testTvSeason, tId)]);
      // act
      final result = await dataSource.getSeasonsByTvSeriesId(tId);
      // assert
      expect(result, [TvSeasonTable.fromEntity(testTvSeason, tId)]);
    });

    test('should return empty list when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeasonsByTvSeriesId(tId))
          .thenAnswer((_) async => []);
      // act
      final result = await dataSource.getSeasonsByTvSeriesId(tId);
      // assert
      expect(result, []);
    });
  });

  group('get Season Detail', () {
    final tId = 1399;
    final tSeasonNumber = 1;

    test('should return TvSeasonTable when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => TvSeasonTable.fromEntity(testTvSeason, tId));
      // act
      final result = await dataSource.getSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(result, TvSeasonTable.fromEntity(testTvSeason, tId));
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return empty list when watchlist is empty', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => []);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, []);
    });
  });
}