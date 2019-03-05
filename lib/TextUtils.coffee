isAlpha = (a) ->
    a.toLowerCase() != a.toUpperCase()

isUpper = (a) ->
    a == a.toUpperCase()

isLower = (a) ->
    a == a.toLowerCase()

module.exports =
    isAlpha: isAlpha
    isUpper: isUpper
    isLower: isLower
