# Include some plugins and stuff
gulp = require 'gulp'
markdown = require 'gulp-markdown'
frontMatter = require 'gulp-front-matter'
clean = require 'gulp-clean'
w3cjs = require 'gulp-w3cjs'
each = require 'through'
jade = require 'gulp-jade'
less = require 'gulp-less'

latestSlides = []
# Any reusable paths / globs go here; trying to keep things DRY
paths =
    source: -> './src/'
    output: -> './output/'
    slides: -> @source() + 'slides/*.md'
    stylesDir: -> @source() + 'styles/'
    styles: -> @stylesDir() + '*.less'
    rootStylesheet: -> @stylesDir() + 'index.less'
    templates: -> @source() + 'templates/*.jade'
    outputHtml: -> @output() + '*.html'

#
# Main tasks
#

gulp.task 'default', ['compile']

gulp.task 'compile', ['templates', 'styles'], ->

gulp.task 'clean', ->
    gulp.src(paths.output())
    .pipe(clean())

gulp.task 'validate', ->
    gulp.src(paths.outputHtml())
    .pipe(w3cjs())


gulp.task 'watch', ['compile'], ->
    gulp.watch [paths.slides(), paths.templates()], ['templates']
    gulp.watch paths.styles(), ['styles']

#
# Secondary level tasks
#

gulp.task 'parse-slides', ->
    latestSlides = [] # reset

    gulp.src(paths.slides())
        .pipe(frontMatter())
        .pipe(markdown())
        .pipe each (slide) ->
            latestSlides.push slide

gulp.task 'templates', ['parse-slides'], ->
    gulp.src(paths.templates())
    .pipe(jade(
            locals:
                slides: latestSlides
        ))
    .pipe(gulp.dest(paths.output()))

gulp.task 'styles', ->
    gulp.src(paths.rootStylesheet())
    .pipe(less())
    .pipe(gulp.dest(paths.output()))