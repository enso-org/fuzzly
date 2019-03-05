NaiveMatchFinder = require('./NaiveMatchFinder.coffee')
Scorer = require('./Scorer.coffee')
defaultMetric = require('./Metrics.coffee').defaultMetric

class Database
    constructor: (items = []) ->
        @data = {}
        for item in items
            [idx, word] = item
            @data[word] ?= []
            @data[word].push(idx)

    query: (q, metric = defaultMetric) ->
        results = []
        for word, ixes of @data
            if new NaiveMatchFinder(word, q).run()
                result = new Scorer(word, q, metric).run()
                results.push({ixes: ixes, score: result.score, match: result.match})
        @normalizeScores(results)
        results.map((a) -> [a.ixes, a.match, a.score])

    normalizeScores: (scored) ->
        maxScore = 0
        for item in scored
            maxScore = Math.max(maxScore, item.score)
        maxScore = 1 if maxScore == 0
        for item in scored
            item.score /= maxScore

module.exports = Database
