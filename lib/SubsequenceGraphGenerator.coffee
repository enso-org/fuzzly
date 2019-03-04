class Int32Array2D
    constructor: (@rows, @columns) ->
        @data = new Int32Array(@rows * @columns)

    index: (row, col) ->
        row * @columns + col

    get: (row, col) ->
        @data[@index(row,col)]

    set: (row, col, item) ->
        @data[@index(row, col)] = item

    toArray: ->
        result = []
        for row in [0...@rows] by 1
            r = []
            for col in [0...@columns] by 1
                r.push(@get(row, col))
            result.push(r)
        result

class SubsequenceGraphGenerator
    constructor: (@word, @query) ->

    run: ->
        @data = new Int32Array2D(@query.length, @word.length)
        eq = (i, j) => @word[i].toLowerCase() == @query[j].toLowerCase()
        for i in [0...@query.length] by 1
            @data.set(i, 0, if eq(0, i) then 1 else 0)
        for i in [1...@word.length] by 1
            prev = @data.get
            @data.set(0, i, if eq(i, 0) then 1 else @data.get(0, i-1))
        for i in [1...@query.length] by 1
            for j in [1...@word.length] by 1
                left    = @data.get(i, j - 1)
                topLeft = if eq(j, i) then @data.get(i - 1, j - 1) + 1 else 0
                @data.set(i, j, Math.max(left, topLeft))
        candidatesMatrix = []
        lastCandidatePosition = @word.length
        for i in [@query.length - 1 .. 0] by -1
            candidatesThisRow = []
            for j in [lastCandidatePosition - 1 .. 0] by -1
                isValid = @data.get(i, j) == i + 1 && @query[i].toLowerCase() == @word[j].toLowerCase()
                if isValid
                    candidatesThisRow.push(j)
            lastCandidatePosition = candidatesThisRow[0]
            candidatesThisRow.reverse()
            candidatesMatrix.push(candidatesThisRow)
            candidatesThisRow = []
        candidatesMatrix.reverse()
        candidatesMatrix

module.exports = SubsequenceGraphGenerator
