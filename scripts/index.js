(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var init, keyCatcher, onDocReady;

keyCatcher = new (require('./keyCatcher'));

init = function() {};

onDocReady = function() {
  keyCatcher.init();
  return $((function(_this) {
    return function() {
      $(window).on('resize', (function() {
        return $('h1, h2, h3, p, a, li').css('z-index', 1);
      }).debounce(50));
      return $(window).on('scroll', (function(e) {
        return $('.slide').each(function() {
          var elementDistance, newHash, scrollTop;
          scrollTop = window.pageYOffset;
          elementDistance = $(this).offset().top;
          if (elementDistance < scrollTop + 10 && elementDistance + $(this).height() > scrollTop + 10) {
            newHash = 'slide-' + $(this).attr('id').split('-')[1];
            return history.pushState(null, null, '#' + newHash);
          }
        });
      }).debounce(50));
    };
  })(this));
};

document.onreadystatechange = function() {
  var state;
  state = document.readyState;
  if (state === 'interactive') {
    return init();
  } else if (state === 'complete') {
    return onDocReady();
  }
};


},{"./keyCatcher":2}],2:[function(require,module,exports){
var slideChanger,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

slideChanger = new (require('./slideChanger'));

module.exports = (function() {
  function _Class() {
    this.subscribers = __bind(this.subscribers, this);
    this.onPreviousSlideRequest = __bind(this.onPreviousSlideRequest, this);
    this.onNextSlideRequest = __bind(this.onNextSlideRequest, this);
    this.bindEvents = __bind(this.bindEvents, this);
    this.init = __bind(this.init, this);
  }

  _Class.prototype.init = function() {
    return this.bindEvents();
  };

  _Class.prototype.bindEvents = function() {
    var subscriber, _i, _len, _ref, _results;
    _ref = this.subscribers();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      subscriber = _ref[_i];
      _results.push(Mousetrap.bind(subscriber.keys, subscriber.handler));
    }
    return _results;
  };

  _Class.prototype.onNextSlideRequest = function(e) {
    e.preventDefault();
    return slideChanger.next();
  };

  _Class.prototype.onPreviousSlideRequest = function(e) {
    e.preventDefault();
    return slideChanger.previous();
  };

  _Class.prototype.subscribers = function() {
    return [
      {
        keys: 'up',
        handler: this.onPreviousSlideRequest
      }, {
        keys: 'right',
        handler: this.onNextSlideRequest
      }, {
        keys: 'down',
        handler: this.onNextSlideRequest
      }, {
        keys: 'left',
        handler: this.onPreviousSlideRequest
      }, {
        keys: 'space',
        handler: this.onNextSlideRequest
      }
    ];
  };

  return _Class;

})();


},{"./slideChanger":3}],3:[function(require,module,exports){
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

module.exports = (function() {
  var currentSlideDataAttributeName;

  function _Class() {
    this.getSlidesContainer = __bind(this.getSlidesContainer, this);
    this.getSlides = __bind(this.getSlides, this);
    this.getCurrentSlide = __bind(this.getCurrentSlide, this);
    this.changeToSlideByIndex = __bind(this.changeToSlideByIndex, this);
    this.previous = __bind(this.previous, this);
    this.next = __bind(this.next, this);
  }

  currentSlideDataAttributeName = 'currentSlide';

  _Class.prototype.next = function() {
    var currentSlideIndex, slides;
    slides = this.getSlides();
    currentSlideIndex = slides.indexOf(this.getCurrentSlide());
    if (!(currentSlideIndex >= (slides.length - 1))) {
      return this.changeToSlideByIndex(currentSlideIndex + 1);
    }
  };

  _Class.prototype.previous = function() {
    var currentSlideIndex, slides;
    slides = this.getSlides();
    currentSlideIndex = slides.indexOf(this.getCurrentSlide());
    if (!(currentSlideIndex <= 0)) {
      return this.changeToSlideByIndex(currentSlideIndex - 1);
    }
  };

  _Class.prototype.changeToSlideByIndex = function(index) {
    return $('body').animate({
      scrollTop: $('#slide-' + index).offset().top
    }, 200, (function(_this) {
      return function() {
        return location.href = '#slide-' + index;
      };
    })(this));
  };

  _Class.prototype.getCurrentSlide = function() {
    var slideIndex;
    if (location.hash) {
      slideIndex = parseInt(location.hash.split('-')[1]);
    } else {
      slideIndex = 0;
    }
    return this.getSlides()[slideIndex];
  };

  _Class.prototype.getSlides = function() {
    return Array.prototype.slice.call(this.getSlidesContainer().querySelectorAll('.slide'));
  };

  _Class.prototype.getSlidesContainer = function() {
    return document.getElementById('slides');
  };

  return _Class;

})();


},{}]},{},[1])