import 'dart:convert';
import 'dart:io';

import 'package:lunr/lunr.dart';

class LunrSearch {
  var movies = json.decode(File('./.temp/movies.json').readAsStringSync());

  Index index() {
    int id = 1;
    Map<String, String> catalog = {};
    return lunr((b) {
      b.field('title');
      b.metadataWhitelist.add('position');
      for (var movie in movies) {
        catalog['$id'] = movie['title'];
        b.add({'id': '$id', 'title': movie['title']});
        id++;
      }
    });
  }

  List<DocMatch> search(Index idx, String query) {
    return idx.search(query);
  }
}

void main(List<String> arguments) {
  var ls = LunrSearch();
  Stopwatch s = Stopwatch();
  List<int> indexTimes = [];
  List<int> searchTimes = [];

  stdout.write('Index benchmark:');
  for (var _ in List.filled(10, 0)) {
    s.start();
    ls.index();
    indexTimes.add(s.elapsedMicroseconds);
    stdout.write('.');
    s.reset();
  }
  stdout.write('done\nSearch benchmark:');
  Index idx = ls.index();
  for (var _ in List.filled(100, 0)) {
    s.start();
    ls.search(idx, 'america');
    searchTimes.add(s.elapsedMicroseconds);
    stdout.write('.');
    s.reset();
  }
  print('done');
  print(idx.search('america').length);

  indexTimes.sort();
  searchTimes.sort();
  print(
      'Index: tp50 ${indexTimes[5]}us tp75 ${indexTimes[8]}us tp90 ${indexTimes[9]}us');
  print(
      'Search: tp50 ${searchTimes[50]}us tp75 ${searchTimes[75]}us tp90 ${searchTimes[90]}us');
}
