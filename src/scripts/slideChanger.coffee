module.exports = class
    shownClass: 'is-shown'

    next: =>
        current = @getCurrentSlide()
        currentSlideIndex = @getIndexOfSlide(current)

        unless currentSlideIndex >= (@getNumberOfSlides() - 1)
            @changeToSlideByIndex currentSlideIndex + 1, current

    previous: =>
        current = @getCurrentSlide()
        currentSlideIndex = @getIndexOfSlide(current)

        unless currentSlideIndex <= 0
            @changeToSlideByIndex currentSlideIndex - 1, current

    changeToSlideByIndex: (index, currentSlideBeforeThis) =>
        newCurrentSlide = @getSlideByIndex(index)
        newCurrentSlide.scrollIntoView()
        newCurrentSlide.classList.add @shownClass
        currentSlideBeforeThis.classList.remove @shownClass


    getCurrentSlide: =>
        @getSlides().filter( (slide) =>
            slide.classList.contains @shownClass
        )[0]

    # returns an {Array}
    getSlides: =>
        Array.prototype.slice.call @getSlidesContainer().querySelectorAll('.slide')

    getSlidesContainer: =>
        document.getElementById('slides')

    getNumberOfSlides: =>
        @getSlides().length

    getIndexOfSlide: (slide) =>
        @getSlides().indexOf slide

    getSlideByIndex: (index) =>
        @getSlides()[index]