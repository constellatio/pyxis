gulp = require 'gulp'

gulp.task 'build', [
  'coffee'
  'browserify'
  'sass'
  'images'
  'copy'
]
