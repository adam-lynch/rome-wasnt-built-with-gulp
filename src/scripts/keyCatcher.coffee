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
            handler: slideChanger.previous
        },
        {
            keys: 'down'
            handler: slideChanger.next
        }
    ]