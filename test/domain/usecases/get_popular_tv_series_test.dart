import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  test('should get list of popular tv series from the repository', () async {
  // arrange
  when(mockTvSeriesRepository.getPopularTvSeries())
      .thenAnswer((_) async => Right([testTvSeriesListItem]));
  // act
  final result = await usecase.execute();
  // assert
  final resultList = result.getOrElse(() => []);
  expect(resultList, [testTvSeriesListItem]);
});
}