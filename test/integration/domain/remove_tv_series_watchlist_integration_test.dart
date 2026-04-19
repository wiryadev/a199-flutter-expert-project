import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist usecase;
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
    usecase = RemoveTvSeriesWatchlist(repository);
  });

  test('should return success message when removing from watchlist succeeds',
      () async {
    // arrange
    when(mockLocalDataSource.removeWatchlist(testTvSeriesDetail.id))
        .thenAnswer((_) async => 'Removed from Watchlist');
    // act
    final result = await usecase.execute(testTvSeriesDetail.id);
    // assert
    expect(result, Right('Removed from Watchlist'));
  });

  test('should return database failure when removing from watchlist fails',
      () async {
    // arrange
    when(mockLocalDataSource.removeWatchlist(testTvSeriesDetail.id))
        .thenThrow(DatabaseException('Failed to remove watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail.id);
    // assert
    expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
  });
}