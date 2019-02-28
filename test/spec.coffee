expect = require("chai").expect
SGG = require("../lib/SubsequenceGraphGenerator.coffee")

describe "Subsequence Graph Generator", ->
    it 'Returns correct graph for W="fooof" Q="oof"', ->
        expectedGraph = [[1,2], [2,3], [4]]
        returnedGraph = new SGG("fooof", "oof").run()
        expect(returnedGraph).to.equal(returnedGraph)

    it 'Returns correct graph for W="Ffoobarbarfoo" Q="Foorfoo"', ->
        expectedGraph = [[0,1], [2], [6,9], [10], [11,12], [12,13]]
        returnedGraph = new SGG("Ffoobarbarfoo", "Foorfoo").run()
        expect(returnedGraph).to.equal(returnedGraph)
