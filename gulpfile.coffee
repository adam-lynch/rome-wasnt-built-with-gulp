# Include some plugins and stuff
gulp = require 'gulp'
markdown = require 'gulp-markdown'
frontMatter = require 'gulp-front-matter'
clean = require 'gulp-clean'
w3cjs = require 'gulp-w3cjs'
each = require 'through'
jade = require 'gulp-jade'

latestSlides = []
# Any reusable paths / globs go here; trying to keep things DRY
paths =
    source: './src/'
    output: './output/'
    slides: -> @source + 'slides/*.md'
    templates: -> @source + 'templates/*.jade'
    outputHtml: -> @output + '*.html'

#
# Main tasks
#

gulp.task 'default', ['compile']

gulp.task 'compile', ['parse-slides'], () ->
    gulp.src(paths.templates())
        .pipe(jade(
            locals:
                slides: latestSlides
        ))
        .pipe(gulp.dest(paths.output))


gulp.task 'clean', () ->
    gulp.src(paths.output)
    .pipe(clean())

gulp.task 'validate', () ->
    gulp.src(paths.outputHtml())
    .pipe(w3cjs())


#
# Secondary level tasks
#

gulp.task 'parse-slides', () ->
    gulp.src(paths.slides())
        .pipe(frontMatter())
        .pipe(markdown())
        .pipe each (slide) ->
            latestSlides.push slide