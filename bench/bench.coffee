Benchmark = require 'benchmark'
SGG       = require '../lib/SubsequenceGraphGenerator.coffee'

suite = new Benchmark.Suite

genSequence = (i) ->
    ('a' for _ in [1..i]).join('')

benchAsSequence = (suite, i, j) ->
    word  = genSequence(i)
    query = genSequence(j)
    suite.add "Graph generation for W=#{i}x'a', Q=#{j}x'a'", ->
        new SGG(word, query).run()

benchAsSequence(suite, 10,   10)
benchAsSequence(suite, 100,  10)
benchAsSequence(suite, 1000, 10)
suite.on('cycle', (e) -> console.log(String(e.target))).run()
