Benchmark = require 'benchmark'
DB      = require '../lib/Database.coffee'

suite = new Benchmark.Suite

genSequence = (i) ->
    ('a' for _ in [1..i]).join('')

benchAsSequence = (suite, i, j) ->
    word  = genSequence(i)
    query = genSequence(j)
    m = new M()
    suite.add "Scoring for W=#{i}x'a', Q=#{j}x'a'", ->
        new S(word, query, m).run()

#benchAsSequence(suite, 10,   10)
#benchAsSequence(suite, 100,  10)
#benchAsSequence(suite, 1000, 10)
#
#benchAsSequence(suite, 20, 3)
#benchAsSequence(suite, 20, 4)
#benchAsSequence(suite, 20, 5)
#benchAsSequence(suite, 20, 6)
#benchAsSequence(suite, 20, 7)
#benchAsSequence(suite, 20, 8)
#benchAsSequence(suite, 20, 9)
#benchAsSequence(suite, 20, 10)

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

#benchRandomDB(suite, 10000, 10, 5)
#benchRandomDB(suite, 100000, 10, 5)
#benchRandomDB(suite, 1000000, 10, 5)
#benchRandomDB(suite, 10000, 20, 10)
#benchRandomDB(suite, 100000, 20, 10)
#benchRandomDB(suite, 1000000, 20, 10)
benchRandomDB(suite, 1000000, 20, 1)
benchRandomDB(suite, 1000000, 20, 2)
benchRandomDB(suite, 1000000, 20, 3)
benchRandomDB(suite, 1000000, 20, 4)

suite.on('cycle', (e) -> console.log(String(e.target))).run()
