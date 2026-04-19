import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesWatchListStatus usecase;
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
    usecase = GetTvSeriesWatchListStatus(repository);
  });

  test('should return true when tv series is in watchlist', () async {
    // arrange
    when(mockLocalDataSource.getTvSeriesById(tId))
        .thenAnswer((_) async => testTvSeriesTable);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, true);
  });

  test('should return false when tv series is not in watchlist', () async {
    // arrange
    when(mockLocalDataSource.getTvSeriesById(tId))
        .thenAnswer((_) async => null);
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, false);
  });
}
