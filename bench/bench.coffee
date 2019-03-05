Benchmark = require 'benchmark'
DB      = require '../lib/Database.coffee'

suite = new Benchmark.Suite

randomWord = (size) ->
    chars = Array.from("abcdefghijklmnopqrstuvwxyz")
    res = []
    for i in [0...size] by 1
        res.push(chars[Math.floor(Math.random() * chars.length)])
    res.join('')

benchRandomDB = (suite, dbSize, wordSize, querySize) ->
    edb = []
    for i in [0...dbSize] by 1
        edb.push([0, randomWord(wordSize)])
    db = new DB(edb)
    q = randomWord(querySize)
    suite.add "Querying a random DB of size #{dbSize} of words of length #{wordSize}, query of length #{querySize}.", ->
        db.query q

benchRandomDB(suite, 100000, 20, 5)
benchRandomDB(suite, 100000, 20, 6)
benchRandomDB(suite, 100000, 20, 7)
benchRandomDB(suite, 100000, 20, 8)

suite.on('cycle', (e) -> console.log(String(e.target))).run()
