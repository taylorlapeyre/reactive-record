var gulp   = require('gulp');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');

var paths = {
  scripts: ['vendor/**/*.coffee', 'src/**/*.coffee', 'examples/**/*.coffee']
}

gulp.task('scripts', function() {
  return gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(concat('all.js'))
    .pipe(gulp.dest('build'));
});


gulp.task('watch', function() {
  return gulp.watch(paths.scripts, ['scripts']);
})

gulp.task('default', ['scripts', 'watch']);
