gulp = require 'gulp'

gulp.task 'watch', ['setWatch', 'browserSync'], ->
  gulp.watch 'src/server/**', ['coffee']
  gulp.watch 'src/sass/**', ['sass']
  gulp.watch 'src/assets/images/**', ['images']
  gulp.watch 'src/assets/**', ['copy']
  gulp.watch 'src/views/**', ['copy']
  # Note: The browserify task handles js recompiling with watchify
