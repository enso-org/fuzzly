expect = require("chai").expect
SGG = require("../lib/SubsequenceGraphGenerator.coffee")
Database = require("../lib/Database.coffee")

describe "Subsequence Graph Generator", ->
    it 'Returns correct graph for W="fooof" Q="oof"', ->
        expectedGraph = [[1,2], [2,3], [4]]
        returnedGraph = new SGG("fooof", "oof").run()
        expect(returnedGraph).to.equal(returnedGraph)

    it 'Returns correct graph for W="Ffoobarbarfoo" Q="Foorfoo"', ->
        expectedGraph = [[0,1], [2], [6,9], [10], [11,12], [12,13]]
        returnedGraph = new SGG("Ffoobarbarfoo", "Foorfoo").run()
        expect(returnedGraph).to.equal(returnedGraph)

describe "Database", ->
    it "Returns correct results", ->
        db = new Database([[10, "Bind"], [11, "bin"]])
        console.log(db.query("Bin"))
