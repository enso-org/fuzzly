class SubsequenceFinder
    constructor: (@word, @query, @graph, @metric) ->

    run: =>
        scoredLayers = []
        lastScoredLayer = ({ node: i, score: @metric.measureBeginning(i, @word, @query) } for i in @graph[0])
        scoredLayers.push(lastScoredLayer)
        for i in [1...@graph.length] by 1
            currentLayer = @graph[i]
            currentScoredLayer = []
            for node in currentLayer
                bestScore = -1
                bestPred  = -1
                for pred, idx in lastScoredLayer
                    break if pred.node >= node
                    score = pred.score + @metric.measure(i, pred.node, node, @word, @query)
                    if score > bestScore
                        bestScore = score
                        bestPred = idx
                currentScoredLayer.push({ node: node, score: bestScore, pred: bestPred })
            scoredLayers.push(currentScoredLayer)
            lastScoredLayer = currentScoredLayer
            currentScoredLayer = []
        bestEndingScore = -1
        bestEndingIdx   = -1
        for node, idx in lastScoredLayer
            score = node.score + @metric.measureEnding(node.node, @word, @query)
            if score > bestEndingScore
                bestEndingScore = score
                bestEndingIdx   = idx
        path = []
        for i in [@query.length - 1 .. 0] by -1
            path.push(scoredLayers[i][bestEndingIdx].node)
            bestEndingIdx = scoredLayers[i][bestEndingIdx].pred
        path.reverse()
        {match: path, score: bestEndingScore}

module.exports = SubsequenceFinder
