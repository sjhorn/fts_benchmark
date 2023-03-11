const lunr = require('lunr');
const fs = require("fs");
const movies = JSON.parse(fs.readFileSync('./.temp/movies.json'))

function index() {
    
    var id = 1;
    return lunr(function () {
        this.ref('id');
        this.field('title');
        this.metadataWhitelist.push('position');
        movies.forEach(function (movie) {
            this.add({'id': `${id}`, 'title': movie['title']});
            id++;
        }, this);
    });
}

var idx = index();

function search(idx, query) {
    return idx.search(query);
}


  var s = performance.now();
  var indexTimes = [];
  var searchTimes = [];
  var stdout = process.stdout;
  var print = console.log;

  stdout.write('Index benchmark:');
  for (var _ of Array(10).keys()) {
    index();
    indexTimes.push(1000*(performance.now() - s));
    stdout.write('.');
    s = performance.now();
  }
  stdout.write('done\nSearch benchmark:');
  var idx = index();
  for (var _ of Array(100).keys()) {
    s = performance.now();
    var result = search(idx, 'am*rica');
    searchTimes.push(1000* (performance.now() - s));
    
    s = performance.now();
  }
  print('done');

  indexTimes.sort(function(a,b) { return a - b });
  searchTimes.sort(function(a,b) { return a - b });
  print(
      `Index: tp50 ${indexTimes[5]}us tp75 ${indexTimes[8]}us tp90 ${indexTimes[9]}us`);
  print(
      `Search: tp50 ${searchTimes[50]}us tp75 ${searchTimes[75]}us tp90 ${searchTimes[90]}us`);