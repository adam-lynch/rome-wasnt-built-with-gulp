init = ->

onDocReady = ->
    Mousetrap.bind '1', ->
        alert 1

# doc ready:
document.onreadystatechange = ->
    state = document.readyState
    if state is 'interactive'
        init()
    else if state is 'complete'
        onDocReady()