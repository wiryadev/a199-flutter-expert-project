import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvSeriesWatchlist usecase;
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
    usecase = SaveTvSeriesWatchlist(repository);
  });

  test('should return success message when saving to watchlist succeeds',
      () async {
    // arrange
    when(mockLocalDataSource.insertWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => 'Added to Watchlist');
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    expect(result, Right('Added to Watchlist'));
  });

  test('should return database failure when saving to watchlist fails',
      () async {
    // arrange
    when(mockLocalDataSource.insertWatchlist(testTvSeriesDetail))
        .thenThrow(DatabaseException('Failed to add watchlist'));
    // act
    final result = await usecase.execute(testTvSeriesDetail);
    // assert
    expect(result, Left(DatabaseFailure('Failed to add watchlist')));
  });
}
