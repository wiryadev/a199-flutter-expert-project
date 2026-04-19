import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_airing_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/test_tv_series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetAiringTvSeries(mockTvSeriesRepository);
  });


  test('should get list of airing tv series from the repository', () async {
  // arrange
  when(mockTvSeriesRepository.getAiringTvSeries())
      .thenAnswer((_) async => Right([testTvSeriesListItem]));
  // act
  final result = await usecase.execute();
  // assert
  final resultList = result.getOrElse(() => []);
  expect(resultList, [testTvSeriesListItem]);
});
}