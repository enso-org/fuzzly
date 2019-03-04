SGG = require("./SubsequenceGraphGenerator.coffee")
SF = require("./SubsequenceFinder.coffee")

class Scorer
    constructor: (word, query, @metric) ->
        @word = Array.from(word)
        @query = Array.from(query)

    run: ->
        g = new SGG(@word, @query).run()
        new SF(@word, @query, g, @metric).run()

module.exports = Scorer
