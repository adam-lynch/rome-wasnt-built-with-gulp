slideChanger = new (require './slideChanger')

module.exports = class
    init: =>
        @bindEvents()

    bindEvents: =>
        for subscriber in @subscribers()
            Mousetrap.bind subscriber.keys, subscriber.handler

    onNextSlideRequest: (e) =>
        e.preventDefault()
        slideChanger.next()

    onPreviousSlideRequest: (e) =>
        e.preventDefault()
        slideChanger.previous()

    subscribers: => [
        {
            keys: 'up'
            handler: @onPreviousSlideRequest
        },
        {
            keys: 'right'
            handler: @onNextSlideRequest
        },
        {
            keys: 'down'
            handler: @onNextSlideRequest
        },
        {
            keys: 'left'
            handler: @onPreviousSlideRequest
        },
        {
            keys: 'space'
            handler: @onNextSlideRequest
        }
    ]