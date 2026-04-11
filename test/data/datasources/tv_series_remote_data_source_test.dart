import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_season_detail_response.dart';
import 'package:ditonton/data/models/tv_series_detail_response.dart';
import 'package:ditonton/data/models/tv_series_list_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';
import '../../response_utils.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Airing Tv Series', () {
    final tTvSeriesList = TvSeriesListResponse.fromJson(
            json.decode(readJson('dummy_data/airing_tv_series.json')))
        .results;

    test('should return list of TvSeriesResponse when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async =>
              createUtf8Response('dummy_data/airing_tv_series.json'));
      final result = await dataSource.getAiringTvSeries();
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getAiringTvSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Series', () {
    final tTvSeriesList = TvSeriesListResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv_series.json')))
        .results;

    test('should return list of TvSeriesResponse when response is success (200)',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              createUtf8Response('dummy_data/popular_tv_series.json'));
      final result = await dataSource.getPopularTvSeries();
      expect(result, tTvSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getPopularTvSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Series', () {
    final tTvSeriesList = TvSeriesListResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv_series.json')))
        .results;

    test('should return list of TvSeriesResponse when response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              createUtf8Response('dummy_data/top_rated_tv_series.json'));
      final result = await dataSource.getTopRatedTvSeries();
      expect(result, tTvSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTopRatedTvSeries();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tv Series Detail', () {
    final tId = 1399;
    final tTvSeriesDetail = TvSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')));

    test('should return TvSeriesDetailResponse when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              createUtf8Response('dummy_data/tv_series_detail.json'));
      final result = await dataSource.getTvSeriesDetail(tId);
      expect(result, equals(tTvSeriesDetail));
    });

    test(
        'should throw ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTvSeriesDetail(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tv Series Recommendations', () {
    final tId = 1399;
    final tTvSeriesList = TvSeriesListResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series_recommendations.json')))
        .results;

    test('should return list of TvSeriesResponse when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async =>
              createUtf8Response('dummy_data/tv_series_recommendations.json'));
      final result = await dataSource.getTvSeriesRecommendations(tId);
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getTvSeriesRecommendations(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Season Detail', () {
    final tId = 1399;
    final tSeasonNumber = 1;
    final tSeasonDetail = TvSeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_season_detail.json')));

    test('should return SeasonDetailResponse when the response code is 200',
        () async {
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async =>
              createUtf8Response('dummy_data/tv_season_detail.json'));
      final result = await dataSource.getSeasonDetail(tId, tSeasonNumber);
      expect(result, equals(tSeasonDetail));
    });

    test(
        'should throw ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(
              Uri.parse('$BASE_URL/tv/$tId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.getSeasonDetail(tId, tSeasonNumber);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Tv Series', () {
    final tQuery = 'Breaking Bad';
    final tTvSeriesList = TvSeriesListResponse.fromJson(
            json.decode(readJson('dummy_data/search_tv_series.json')))
        .results;

    test('should return list of TvSeriesResponse when response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async =>
              createUtf8Response('dummy_data/search_tv_series.json'));
      final result = await dataSource.searchTvSeries(tQuery);
      expect(result, tTvSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = dataSource.searchTvSeries(tQuery);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}