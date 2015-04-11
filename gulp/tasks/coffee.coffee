gulp         = require 'gulp'
coffee       = require 'gulp-coffee'
gutil        = require 'gulp-util'
handleErrors = require '../util/handleErrors'

gulp.task 'coffee', ->
  gulp.src './src/server/*.coffee'
  .pipe coffee({bare: true}).on('error', gutil.log).on('error', handleErrors)
  .pipe gulp.dest './build'
