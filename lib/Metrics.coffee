Text = require('./TextUtils.coffee')

class SubsequentLettersBonus
    constructor: (@fullScore = 1) ->

    measureBeginning: (to, word, query) ->
        @fullScore / ((to + 1) * 2)

    measure: (layer, from, to, word, query) ->
        @fullScore / (to - from)

    measureEnding: (from, word, query) ->
        @fullScore / ((word.length - from) * 100)

class CaseMatchBonus
    matchBonus: (i, word, j, query) ->
        return 0.01 if Text.isUpper(word[i]) == Text.isUpper(query[j])
        return 0

    measureBeginning: (to, word, query) ->
        @matchBonus(to, word, 0, query)

    measure: (layer, from, to, word, query) ->
        @matchBonus(to, word, layer, query)

    measureEnding: () -> 0

class SumMetric
    constructor: (@metrics...) ->
        console.log(@metrics)

    delegateToMetrics: (methodName, args) ->
        r = @metrics.reduce(((total, metric) -> metric[methodName](args...) + total), 0)

    measureBeginning: (args...) -> @delegateToMetrics("measureBeginning", args)
    measure:          (args...) -> @delegateToMetrics("measure", args)
    measureEnding:    (args...) -> @delegateToMetrics("measureEnding", args)


defaultMetric = new SumMetric(new SubsequentLettersBonus, new CaseMatchBonus)

module.exports =
    SubsequentLettersBonus: SubsequentLettersBonus
    CaseMatchBonus: CaseMatchBonus
    defaultMetric: defaultMetric
