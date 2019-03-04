DB = require('./index.coffee').Database

db = new DB([[0, "a"], [10, "foo"], [20, "foo"], [30, "foofoo"]])
console.log(db.query("o"))
console.log(db.query("oo"))
