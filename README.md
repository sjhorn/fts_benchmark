# Full-text-search (FTS) benchmarks

This benchmarking suite aims to test the indexing and searching behaviour of different full-text-search indexes

Inspired by [Full-Text Search Benchmark](https://github.com/RediSearch/ftsb)

...Still a work in progress...

## Indexing

The index will focus on the time after a json document has been parsed in assembled into a simple Map<String, String> document. 

## Searching / Query-types

|Query type|Description|Example|Status|
|:---|:---|:---|:---|
|simple-1word-query| Simple 1 Word Query | `Abraham` | :heavy_check_mark:
|2word-union-query| 2 Word Union Query | `Abraham Lincoln` | :heavy_check_mark:
|2word-intersection-query| 2 Word Intersection Query| `Abraham`&#124;`Lincoln` | :heavy_check_mark:
|exact-3word-match| Exact 3 Word Match| `"President Abraham Lincoln"` |:heavy_multiplication_x:
|autocomplete-1100-top3| Autocomplete -1100 Top 2-3 Letter Prefixes|  | :heavy_multiplication_x:
|2field-2word-intersection-query| 2 Fields, one word each, Intersection query | `title: text_value1 abstract: text_value2` | :heavy_multiplication_x:

Spell-check / Levinstein distance
|Query type|Description|Example|Status|
|:---|:---|:---|:---|
| simple-1word-spellcheck | Simple 1 Word Spell Check Query | `prsident~1 braham~1` | :heavy_check_mark:


## Data sources

* [Wikipedia English-language abstracts](https://dumps.wikimedia.org/enwiki/latest/enwiki-latest-abstract1.xml.gz)
* [English-language Wikipedia last page revisions](https://dumps.wikimedia.org/enwiki/20210501/enwiki-20210501-pages-articles1.xml-p1p41242.bz2)
* .. others from FTSB link above.

## Wikipedia English-language page abstract

The json source is as follows
```json
{
'title': 'Wikipedia: Politics of the Democratic Republic of the Congo',
'url': 'https://en.wikipedia.org/wiki/Politics_of_the_Democratic_Republic_of_the_Congo',
'abstract': 'Politics of the Democratic Republic of Congo take place in a framework of a republic in transition from a civil war to a semi-presidential republic.'
}
```

