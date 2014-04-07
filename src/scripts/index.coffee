keyCatcher = new (require './keyCatcher')

init = ->

onDocReady = ->
    keyCatcher.init()

# doc ready:
document.onreadystatechange = ->
    state = document.readyState
    if state is 'interactive'
        init()
    else if state is 'complete'
        onDocReady()