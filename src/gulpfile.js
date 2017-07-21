var gulp    = require('gulp');
var coffee  = require('gulp-coffee');
var pug     = require('gulp-pug');

gulp.task('pug', function() {
    var YOUR_LOCALS = {}
    gulp.src('iso-collections.pug')
        .pipe(pug({locals: YOUR_LOCALS}))
        .pipe(gulp.dest('../'))
})


gulp.task('default', ['pug'])
