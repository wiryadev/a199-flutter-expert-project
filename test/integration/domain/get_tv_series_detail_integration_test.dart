import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  final tId = 1399;
  final tSeasonNumber = 1;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
    usecase = GetTvSeriesDetail(repository);
  });

  test(
      'should return tv series detail with episodes when all calls are successful',
      () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesDetail(tId))
        .thenAnswer((_) async => testTvSeriesDetailResponse);
    when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => testSeasonDetailResponse);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetailWithEpisodes));
  });

  test(
      'should return tv series detail with empty episodes when season detail fails',
      () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesDetail(tId))
        .thenAnswer((_) async => testTvSeriesDetailResponse);
    when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
        .thenThrow(ServerException());
    when(mockLocalDataSource.getSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => null);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });

  test('should return server failure when getTvSeriesDetail fails', () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesDetail(tId))
        .thenThrow(ServerException());
    when(mockLocalDataSource.getTvSeriesById(tId))
        .thenAnswer((_) async => null);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Left(ServerFailure('')));
  });

  test(
      'should return local data when getTvSeriesDetail fails and local data exists',
      () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesDetail(tId))
        .thenThrow(ServerException());
    when(mockLocalDataSource.getTvSeriesById(tId))
        .thenAnswer((_) async => testTvSeriesTable);
    when(mockLocalDataSource.getSeasonsByTvSeriesId(tId))
        .thenAnswer((_) async => [testTvSeasonTable]);
    when(mockRemoteDataSource.getSeasonDetail(tId, tSeasonNumber))
        .thenThrow(ServerException());
    when(mockLocalDataSource.getSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => testTvSeasonTable);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, isA<Right>());
  });

  test('should return connection failure when socket exception thrown',
      () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesDetail(tId))
        .thenThrow(SocketException('Failed to connect to the network'));
    when(mockLocalDataSource.getTvSeriesById(tId))
        .thenAnswer((_) async => null);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Left(ConnectionFailure('Failed to connect to the network')));
  });
}
