import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testEpisode = TvEpisode(
  id: 63056,
  name: 'Winter Is Coming',
  overview:
      'Jon Arryn, the Hand of the King, is dead. King Robert Baratheon plans to ask his oldest friend, Eddard Stark, to take Jon\'s place. Across the sea, Viserys Targaryen plans to wed his sister to a nomadic warlord in exchange for an army.',
  airDate: '2011-04-17',
  episodeNumber: 1,
  episodeType: 'standard',
  productionCode: '101',
  runtime: 62,
  seasonNumber: 1,
  showId: 1399,
  stillPath: '/9hGF3WUkBf7cSjMg0cdMDHJkByd.jpg',
  voteAverage: 8.1,
  voteCount: 396,
);

final testTvSeason = TvSeason(
  id: 3624,
  name: 'Season 1',
  overview:
      'Trouble is brewing in the Seven Kingdoms of Westeros. For the driven inhabitants of this visionary world, control of Westeros\' Iron Throne holds the lure of great power. But in a land where the seasons can last a lifetime, winter is coming...and beyond the Great Wall that protects them, an ancient evil has returned. In Season One, the story centers on three primary areas: the Stark and the Lannister families, whose designs on controlling the throne threaten a tenuous peace; the dragon princess Daenerys, heir to the former dynasty, who waits just over the Narrow Sea with her malevolent brother Viserys; and the Great Wall--a massive barrier of ice where a forgotten danger is stirring.',
  airDate: '2011-04-17',
  posterPath: '/wgfKiqzuMrFIkU1M68DDDY8kGC1.jpg',
  seasonNumber: 1,
  voteAverage: 8.3,
  episodes: [testEpisode],
);

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: '/6LWy0jvMpmjoS9fojNgHIKoWL05.jpg',
  firstAirDate: '2011-04-17',
  genres: [Genre(id: 10765, name: 'Sci-Fi & Fantasy')],
  homepage: 'http://www.hbo.com/game-of-thrones',
  id: 1399,
  inProduction: false,
  languages: ['en'],
  lastAirDate: '2019-05-19',
  name: 'Game of Thrones',
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originCountry: ['US'],
  originalLanguage: 'en',
  originalName: 'Game of Thrones',
  overview:
      'Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night\'s Watch, is all that stands between the realms of men and icy horrors beyond.',
  popularity: 346.098,
  posterPath: '/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg',
  seasons: [testTvSeason],
  status: 'Ended',
  tagline: 'Winter Is Coming',
  type: 'Scripted',
  voteAverage: 8.438,
  voteCount: 21390,
  episodeRunTime: 60,
);

final testTvSeriesTable = TvSeriesTable.fromEntity(testTvSeriesDetail);
