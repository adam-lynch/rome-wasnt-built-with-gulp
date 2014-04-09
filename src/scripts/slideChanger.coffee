module.exports = class
    currentSlideDataAttributeName = 'currentSlide'

    next: =>
        slides = @getSlides()
        current = @getCurrentSlide()
        currentSlideIndex = slides.indexOf(current)

        unless currentSlideIndex >= (slides.length - 1)
            @changeToSlideByIndex currentSlideIndex + 1

    previous: =>
        slides = @getSlides()
        current = @getCurrentSlide()
        currentSlideIndex = slides.indexOf(current)

        unless currentSlideIndex <= 0
            @changeToSlideByIndex currentSlideIndex - 1

    changeToSlideByIndex: (index) =>
        @getSlides()[index].scrollIntoView()
        @getSlidesContainer().dataset[currentSlideDataAttributeName] = index

    getCurrentSlide: =>
        slideIndex = parseInt(@getSlidesContainer().dataset[currentSlideDataAttributeName], 10)
        @getSlides()[slideIndex]

    # returns an {Array}
    getSlides: =>
        Array.prototype.slice.call @getSlidesContainer().querySelectorAll('.slide')

    getSlidesContainer: =>
        document.getElementById('slides')