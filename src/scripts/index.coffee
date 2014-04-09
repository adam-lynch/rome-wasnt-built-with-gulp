keyCatcher = new (require './keyCatcher')

init = ->

onDocReady = ->
    keyCatcher.init()

    $ =>
        $(window).on 'resize', (()->
            $('h1, h2, h3, p, a, li').css('z-index', 1)
        ).debounce(50)

# doc ready:
document.onreadystatechange = ->
    state = document.readyState
    if state is 'interactive'
        init()
    else if state is 'complete'
        onDocReady()