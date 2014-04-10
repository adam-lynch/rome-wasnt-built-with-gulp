module.exports = class
    currentSlideDataAttributeName = 'currentSlide'

    next: =>
        slides = @getSlides()
        currentSlideIndex = slides.indexOf @getCurrentSlide()

        unless currentSlideIndex >= (slides.length - 1)
            @changeToSlideByIndex currentSlideIndex + 1

    previous: =>
        slides = @getSlides()
        currentSlideIndex = slides.indexOf @getCurrentSlide()

        unless currentSlideIndex <= 0
            @changeToSlideByIndex currentSlideIndex - 1

    changeToSlideByIndex: (index) =>
        $('body').animate {
            scrollTop: $('#slide-'+index).offset().top
        }, 200, =>
            location.href = '#slide-'+index

    getCurrentSlide: =>
        if location.hash
            slideIndex = parseInt(location.hash.split('-')[1])
        else
            slideIndex = 0

        @getSlides()[slideIndex]

    # returns an {Array}
    getSlides: =>
        Array.prototype.slice.call @getSlidesContainer().querySelectorAll('.slide')

    getSlidesContainer: =>
        document.getElementById('slides')