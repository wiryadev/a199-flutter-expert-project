import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final tId = 1399;

  test(
      'should return tv series detail with episodes when all calls are successful',
      () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockTvSeriesRepository.getSeasonDetail(
            tId, testTvSeasonNoEpisodes.seasonNumber))
        .thenAnswer((_) async => Right(testTvSeason));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetailWithEpisodes));
  });

  test(
      'should return tv series detail with empty episodes when season detail call fails',
      () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockTvSeriesRepository.getSeasonDetail(
            tId, testTvSeasonNoEpisodes.seasonNumber))
        .thenAnswer((_) async => Left(ServerFailure('')));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });

  test('should return failure when getTvSeriesDetail fails', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Left(ServerFailure('')));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Left(ServerFailure('')));
  });
}