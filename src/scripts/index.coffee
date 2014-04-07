init = ->

onDocReady = ->
    console.debug 'hello, world!'

# doc ready:
document.onreadystatechange = ->
    state = document.readyState
    if state is 'interactive'
        init()
    else if state is 'complete'
        onDocReady()