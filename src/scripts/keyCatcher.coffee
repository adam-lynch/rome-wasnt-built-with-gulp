slideChanger = new (require './slideChanger')

module.exports = class
    init: =>
        @bindEvents()

    bindEvents: =>
        for subscriber in @subscribers()
            Mousetrap.bind subscriber.keys, subscriber.handler

    subscribers: => [
        {
            keys: 'up'
            handler: (e) =>
                e.preventDefault()
                slideChanger.previous()
        },
        {
            keys: 'down'
            handler: (e) =>
                e.preventDefault()
                slideChanger.next()
        }
    ]