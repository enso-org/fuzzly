hasCase = (a) ->
    a.toLowerCase() != a.toUpperCase()

isUpper = (a) ->
    a == a.toUpperCase()

isLower = (a) ->
    a == a.toLowerCase()

equalUpToCase = (a,b) ->
    a.toLowerCase() == b.toLowerCase()

module.exports =
    hasCase: hasCase
    isUpper: isUpper
    isLower: isLower
    equalUpToCase: equalUpToCase
