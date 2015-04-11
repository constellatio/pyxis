gulp = require 'gulp'

gulp.task 'copy', ->
  gulp.src('./src/index.html').pipe gulp.dest './build'
  gulp.src('./src/assets/fonts/*').pipe gulp.dest './build/assets/fonts'
  gulp.src('./src/assets/sounds/*').pipe gulp.dest './build/assets/sounds'
  gulp.src('./src/views/*').pipe gulp.dest './build/views'

