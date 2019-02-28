SGG = require './lib/SubsequenceGraphGenerator.coffee'

new SGG("fooof", "oof").run()
console.log(new SGG("Ffoobarbarfooo", "Foorfoo").run())
