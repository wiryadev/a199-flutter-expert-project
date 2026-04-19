import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
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
    usecase = GetTopRatedTvSeries(repository);
  });

  test('should return list of tv series from repository', () async {
    // arrange
    when(mockRemoteDataSource.getTopRatedTvSeries())
        .thenAnswer((_) async => testTvSeriesResponseList);
    // act
    final result = await usecase.execute();
    // assert
    final resultList = result.getOrElse(() => []);
    expect(resultList, testTvSeriesList);
  });

  test('should return server failure when remote data source throws', () async {
    // arrange
    when(mockRemoteDataSource.getTopRatedTvSeries())
        .thenThrow(ServerException());
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Left(ServerFailure('')));
  });

  test('should return connection failure when socket exception thrown',
      () async {
    // arrange
    when(mockRemoteDataSource.getTopRatedTvSeries())
        .thenThrow(SocketException('Failed to connect to the network'));
    // act
    final result = await usecase.execute();
    // assert
    expect(result,
        Left(ConnectionFailure('Failed to connect to the network')));
  });
}