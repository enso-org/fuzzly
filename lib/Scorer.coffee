SGG = require("./SubsequenceGraphGenerator.coffee")
SF  = require("./SubsequenceFinder.coffee")

class Scorer
    constructor: (word, query, @metric) ->
        @word = Array.from(word)
        @query = Array.from(query)

    run: ->
        graph = new SGG(@word, @query).run()
        new SF(@word, @query, graph, @metric).run()

module.exports = Scorer
