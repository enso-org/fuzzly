Text = require('./TextUtils.coffee')

class NaiveMatchFinder
    constructor: (@word, @query) ->

    run: () ->
        queryPos = 0
        wordPos  = 0
        while queryPos < @query.length && wordPos < @word.length
            if Text.equalUpToCase(@query[queryPos], @word[wordPos])
                queryPos += 1
            wordPos += 1
        queryPos == @query.length

module.exports = NaiveMatchFinder
