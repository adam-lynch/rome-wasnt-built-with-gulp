keyCatcher = new (require './keyCatcher')

init = ->

onDocReady = ->
    keyCatcher.init()

    $ =>
        # repaint elements using vw units
        $(window).on 'resize', (()->
            $('h1, h2, h3, p, a, li').css('z-index', 1)
        ).debounce(50)

        $(window).on 'scroll', ((e) ->
            $('.slide').each ->
                scrollTop =  window.pageYOffset
                elementDistance = $(this).offset().top

                if  elementDistance < scrollTop + 10 and elementDistance + $(this).height() > scrollTop + 10
                    newHash = 'slide-' + $(this).attr('id').split('-')[1]
#                    location.hash = 'slide-' + $(this).attr('id').split('-')[1]
                    history.pushState(null, null, '#' + newHash)
        ).debounce(50)


# doc ready:
document.onreadystatechange = ->
    state = document.readyState
    if state is 'interactive'
        init()
    else if state is 'complete'
        onDocReady()