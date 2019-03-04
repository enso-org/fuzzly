NaiveMatchFinder = require('./NaiveMatchFinder.coffee')
Scorer = require('./Scorer.coffee')
Metric = require('./Metrics.coffee').DefaultMetric

class Database
    constructor: (items = []) ->
        @data = {}
        for item in items
            [idx, word] = item
            @data[word] ?= []
            @data[word].push(idx)

    query: (q, metric = new Metric()) ->
        results = []
        for word, ixes of @data
            if new NaiveMatchFinder(word, q).run()
                result = new Scorer(word, q, metric).run()
                results.push({ixes: ixes, score: result.score, match: result.match})
        results.sort((a, b) -> if a.score < b.score then 1 else -1)
        results.map((a) -> [a.ixes, a.match, a.score])

module.exports = Database
