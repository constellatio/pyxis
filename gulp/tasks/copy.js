// Generated by CoffeeScript 1.9.1
var gulp;

gulp = require('gulp');

gulp.task('copy', function() {
  gulp.src('./src/index.html').pipe(gulp.dest('./build'));
  gulp.src('./src/assets/fonts/*').pipe(gulp.dest('./build/assets/fonts'));
  return gulp.src('./src/assets/fonts/*').pipe(gulp.dest('./build/assets/sounds'));
});
