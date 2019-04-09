NaiveMatchFinder = require('./NaiveMatchFinder.coffee')
Scorer           = require('./Scorer.coffee')
defaultMetric    = require('./Metrics.coffee').defaultMetric
FlexSearch       = require('flexsearch')

class WordIndex
    constructor: (items = []) ->
        @data = {}
        for item in items
            @data[item.word] ?= []
            @data[item.word].push(item.index)

    query: (q, metric = defaultMetric) ->
        results = []
        for word, ixes of @data
            if new NaiveMatchFinder(word, q).run()
                result = new Scorer(word, q, metric).run()
                results.push(
                    ixes: ixes
                    score: result.score
                    match: result.match
                )
        @normalizeScores(results)
        results.map((a) -> [a.ixes, a.match, a.score])

    normalizeScores: (scored) ->
        maxScore = 0
        for item in scored
            maxScore = Math.max(maxScore, item.score)
        maxScore = 1 if maxScore == 0
        for item in scored
            item.score /= maxScore

class DocumentationIndex
    constructor: (@items = []) ->
        @index = new FlexSearch()
        for item in @items
            @index.add(item.index, item.documentation)

    query: (q) ->
        @index.search(q)

class Database
    constructor: (items = []) ->
        @wordIndex = new WordIndex(items)
        @documentationIndex = new DocumentationIndex(items)

    queryWord: (q) ->
        @wordIndex.query(q)

    queryDocumentation: (q) ->
        @documentationIndex.query(q)

module.exports = Database
