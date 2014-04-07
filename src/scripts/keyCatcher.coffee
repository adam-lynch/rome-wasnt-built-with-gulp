slideChanger = new (require './slideChanger')

module.exports = class
    init: =>
        @bindEvents()

    bindEvents: =>
        for subscriber in @subscribers()
            Mousetrap.bind subscriber.keys, subscriber.handler

    subscribers: => [
        {
            keys: 'left'
            handler: slideChanger.previous
        },
        {
            keys: 'right'
            handler: slideChanger.next
        }
    ]