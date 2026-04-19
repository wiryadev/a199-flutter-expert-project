import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
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
    usecase = GetWatchlistTvSeries(repository);
  });

  test('should return list of watchlist tv series from local data source',
      () async {
    // arrange
    when(mockLocalDataSource.getWatchlistTvSeries())
        .thenAnswer((_) async => [testTvSeriesTable]);
    // act
    final result = await usecase.execute();
    // assert
    final resultList = result.getOrElse(() => []);
    expect(resultList, [testTvSeriesTable.toListEntity()]);
  });

  test('should return empty list when watchlist is empty', () async {
    // arrange
    when(mockLocalDataSource.getWatchlistTvSeries())
        .thenAnswer((_) async => []);
    // act
    final result = await usecase.execute();
    // assert
    final resultList = result.getOrElse(() => []);
    expect(resultList, []);
  });
}