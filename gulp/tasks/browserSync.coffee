browserSync = require 'browser-sync'
gulp = require 'gulp'

gulp.task 'browserSync', ['build'], ->
  browserSync.init ['build/**'],
    proxy: 'localhost:8081'
    startPath: '/pyxis'
