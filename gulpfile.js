var gulp = require('gulp');
var markdown = require('gulp-markdown');
var clean = require('gulp-clean');

gulp.task('default', ['compile']);

gulp.task('compile', ['markdown'], function(){

});

gulp.task('markdown', function(){
    gulp.src('./src/*.md')
        .pipe(markdown())
        .pipe(gulp.dest('./output'));
});

gulp.task('clean', function(){
    gulp.src('./output')
        .pipe(clean());
});