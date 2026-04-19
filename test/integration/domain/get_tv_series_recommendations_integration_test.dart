import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  final tId = 1399;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
    usecase = GetTvSeriesRecommendations(repository);
  });

  test('should return list of tv series recommendations from repository',
      () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => testTvSeriesResponseList);
    // act
    final result = await usecase.execute(tId);
    // assert
    final resultList = result.getOrElse(() => []);
    expect(resultList, testTvSeriesList);
  });

  test('should return server failure when remote data source throws', () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
        .thenThrow(ServerException());
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Left(ServerFailure('')));
  });

  test('should return connection failure when socket exception thrown',
      () async {
    // arrange
    when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
        .thenThrow(SocketException('Failed to connect to the network'));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result,
        Left(ConnectionFailure('Failed to connect to the network')));
  });
}
