class SubsequentLettersBonus
    constructor: (@fullScore = 1) ->

    measureBeginning: (to, word, query) ->
        @fullScore / ((to + 1) * 2)

    measure: (layer, from, to, word, query) ->
        @fullScore / (to - from)

    measureEnding: (from, word, query) ->
        #@fullScore / ((word.length - from) * 3)
        0

DefaultMetric = SubsequentLettersBonus

module.exports =
    SubsequentLettersBonus: SubsequentLettersBonus
    DefaultMetric: DefaultMetric
