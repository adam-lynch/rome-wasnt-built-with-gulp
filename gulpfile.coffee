# Include some plugins and stuff
gulp = require 'gulp'
markdown = require 'gulp-markdown'
frontMatter = require 'gulp-front-matter'
clean = require 'gulp-clean'
w3cjs = require 'gulp-w3cjs'
each = require 'through'
jade = require 'gulp-jade'
less = require 'gulp-less'
imagemin = require 'gulp-imagemin'
autoprefixer = require 'gulp-autoprefixer'
coffee = require 'gulp-coffee'
gulpBowerFiles = require 'gulp-bower-files'
concat = require 'gulp-concat'
minifyJs = require 'gulp-uglify'
lazypipe = require 'lazypipe'
browserify = require 'gulp-browserify'
rename = require 'gulp-rename'


latestSlides = []
# Any reusable paths / globs go here; trying to keep things DRY
paths =
    source: -> './src/'
    imagesDir: -> @source() + 'images/'
    images: -> [@imagesDir() + '*.png', @imagesDir() + '*.jpg']
    compressedImagesDir: -> @imagesDir() + 'compressedImages/'
    compressedImages: -> @compressedImagesDir() + '*'
    slides: -> @source() + 'slides/*.md'
    scriptsDir: -> @source() + 'scripts/'
    scripts: -> @scriptsDir() + '*.coffee'
    rootScript: -> @scriptsDir() + 'index.coffee'
    stylesDir: -> @source() + 'styles/'
    styles: -> @stylesDir() + '*.less'
    rootStylesheet: -> @stylesDir() + 'index.less'
    templates: -> @source() + 'templates/*.jade'

    output: -> './output/'
    outputHtml: -> @output() + '*.html'
    outputImageDir: -> @output() + 'images/'
    outputScriptsDir: -> @output() + 'scripts/'


#
# Resusable pipelines
#
pipes =
    minifyAndStoreScripts = lazypipe()
#        .pipe(minifyJs)
        .pipe(gulp.dest, paths.outputScriptsDir())


#
# Main tasks
#


gulp.task 'default', ['compile']


gulp.task 'compile', ['images', 'scripts', 'styles', 'templates']


gulp.task 'watch', ['compile'], ->
    gulp.watch paths.compressedImages(), ['images']
    gulp.watch paths.scripts(), ['scripts']
    gulp.watch paths.styles(), ['styles']
    gulp.watch [paths.slides(), paths.templates()], ['templates']


gulp.task 'clean', ->
    gulp.src(paths.output())
    .pipe(clean())


gulp.task 'validate', ->
    gulp.src(paths.outputHtml())
    .pipe(w3cjs())


gulp.task 'compress-images', ->
    gulp.src(paths.images())
    .pipe(imagemin())
    .pipe(gulp.dest(paths.compressedImagesDir()))


#
# Secondary level tasks
#


gulp.task 'images', ->
    gulp.src(paths.compressedImages())
    .pipe(gulp.dest(paths.outputImageDir()))


gulp.task 'parse-slides', ->
    latestSlides = [] # reset

    gulp.src(paths.slides())
        .pipe(frontMatter())
        .pipe(markdown())
        .pipe each (slide) ->
            latestSlides.push slide


gulp.task 'scripts', ['scripts-first-party', 'scripts-third-party']


gulp.task 'scripts-first-party', ->
    gulp.src(paths.rootScript(), {read:false})
    .pipe(browserify(
            transform: ['coffeeify']
            extensions: ['.coffee']
        ))
    .pipe(rename('index.js'))
    .pipe(minifyAndStoreScripts())


gulp.task 'scripts-third-party', ->
    gulpBowerFiles()
    .pipe(concat('third-party.js'))
    .pipe(minifyAndStoreScripts())

    gulp.src(paths.source() + 'third-party/third-party-static/*')
    .pipe(concat('third-party-static.js'))
    .pipe(minifyAndStoreScripts())


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
    .pipe(autoprefixer('last 2 versions'))
    .pipe(gulp.dest(paths.output()))

gulp.task 'watch', ['compile'], ->
    gulp.watch paths.images(), ['images']
    gulp.watch paths.scripts(), ['scripts']
    gulp.watch paths.styles(), ['styles']
    gulp.watch [paths.slides(), paths.templates()], ['templates']
