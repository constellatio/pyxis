sass         = require 'gulp-sass'
gulp         = require 'gulp'
notify       = require 'gulp-notify'
handleErrors = require '../util/handleErrors'

gulp.task 'sass', ->
  gulp.src './src/sass/*.scss'
  .pipe sass()
  .pipe gulp.dest './build'
  .on 'error', handleErrors
