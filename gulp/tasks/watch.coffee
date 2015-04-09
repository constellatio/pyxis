gulp = require 'gulp'

gulp.task 'watch', ['setWatch', 'browserSync'], ->
  gulp.watch 'src/sass/**', ['sass']
  gulp.watch 'src/assets/images/**', ['images']
  gulp.watch 'src/assets/**', ['copy']
  # Note: The browserify task handles js recompiling with watchify
