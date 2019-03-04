class NaiveMatchFinder
    constructor: (@word, @query) ->

    run: () ->
        queryPos = 0
        wordPos  = 0
        while queryPos < @query.length && wordPos < @word.length
            if @query[queryPos].toLowerCase() == @word[wordPos].toLowerCase()
                queryPos += 1
            wordPos += 1
        queryPos == @query.length

module.exports = NaiveMatchFinder
