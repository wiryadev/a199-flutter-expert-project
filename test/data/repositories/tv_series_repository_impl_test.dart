import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('Airing Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getAiringTvSeries())
          .thenAnswer((_) async => testTvSeriesResponseList);
      final result = await repository.getAiringTvSeries();
      verify(mockRemoteDataSource.getAiringTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getAiringTvSeries())
          .thenThrow(ServerException());
      final result = await repository.getAiringTvSeries();
      verify(mockRemoteDataSource.getAiringTvSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getAiringTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getAiringTvSeries();
      verify(mockRemoteDataSource.getAiringTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv Series', () {
    test('should return tv series list when call to data source is success',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => testTvSeriesResponseList);
      final result = await repository.getPopularTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      final result = await repository.getPopularTvSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getPopularTvSeries();
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => testTvSeriesResponseList);
      final result = await repository.getTopRatedTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      final result = await repository.getTopRatedTvSeries();
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getTopRatedTvSeries();
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1399;

    test(
        'should return tv series data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => testTvSeriesDetailResponse);
      final result = await repository.getTvSeriesDetail(tId);
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return server failure when remote fails and data is not in local',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      final result = await repository.getTvSeriesDetail(tId);
      expect(result, equals(Left(ServerFailure(''))));
    });

    test('should return local data when server exception and data is in local',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesTable);
      when(mockLocalDataSource.getSeasonsByTvSeriesId(tId))
          .thenAnswer((_) async => [testTvSeasonTable]);
      final result = await repository.getTvSeriesDetail(tId);
      final expected =
          testTvSeriesTable.toEntity(seasons: [testTvSeasonTable.toEntity()]);
      expect(result, equals(Right(expected)));
    });

    test(
        'should return connection failure when device is not connected and data is not in local',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      final result = await repository.getTvSeriesDetail(tId);
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return local data when socket exception and data is in local',
        () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesTable);
      when(mockLocalDataSource.getSeasonsByTvSeriesId(tId))
          .thenAnswer((_) async => [testTvSeasonTable]);
      final result = await repository.getTvSeriesDetail(tId);
      final expected =
          testTvSeriesTable.toEntity(seasons: [testTvSeasonTable.toEntity()]);
      expect(result, equals(Right(expected)));
    });
  });

  group('Get Season Detail', () {
    final tId = 1399;
    final tSeasonNumber = 1;

    test(
        'should return season data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => testSeasonDetailResponse);
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      verify(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(Right(testTvSeason)));
    });

    test(
        'should return server failure when remote fails and data is not in local',
        () async {
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(ServerException());
      when(mockLocalDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => null);
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return local data when server exception fails and data is in local',
        () async {
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(ServerException());
      when(mockLocalDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => testTvSeasonTable);
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      expect(result, equals(Right(testTvSeasonTable.toEntity())));
    });

    test(
        'should return connection failure when socket exception and data is not in local',
        () async {
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      when(mockLocalDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => null);
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test('should return local data when socket exception and data is in local',
        () async {
      when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenThrow(SocketException('Failed to connect to the network'));
      when(mockLocalDataSource.getSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => testTvSeasonTable);
      final result = await repository.getSeasonDetail(tId, tSeasonNumber);
      expect(result, equals(Right(testTvSeasonTable.toEntity())));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tId = 1399;

    test('should return data when the call is successful', () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => testTvSeriesResponseList);
      final result = await repository.getTvSeriesRecommendations(tId);
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(testTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      final result = await repository.getTvSeriesRecommendations(tId);
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getTvSeriesRecommendations(tId);
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'Game of Thrones';

    test('should return tv series list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => testTvSeriesResponseList);
      final result = await repository.searchTvSeries(tQuery);
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      final result = await repository.searchTvSeries(tQuery);
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.searchTvSeries(tQuery);
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalDataSource.insertWatchlist(testTvSeriesDetail))
          .thenAnswer((_) async => 'Added to Watchlist');
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlist(testTvSeriesDetail))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalDataSource.removeWatchlist(testTvSeriesDetail.id))
          .thenAnswer((_) async => 'Removed from Watchlist');
      final result = await repository.removeWatchlist(testTvSeriesDetail.id);
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlist(testTvSeriesDetail.id))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      final result = await repository.removeWatchlist(testTvSeriesDetail.id);
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      when(mockLocalDataSource.getTvSeriesById(testTvSeriesDetail.id))
          .thenAnswer((_) async => null);
      final result = await repository.isAddedToWatchlist(testTvSeriesDetail.id);
      expect(result, false);
    });

    test('should return true when data is found', () async {
      when(mockLocalDataSource.getTvSeriesById(testTvSeriesDetail.id))
          .thenAnswer((_) async => testTvSeriesTable);
      final result = await repository.isAddedToWatchlist(testTvSeriesDetail.id);
      expect(result, true);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of Tv Series', () async {
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      final result = await repository.getWatchlistTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
