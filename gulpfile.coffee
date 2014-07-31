gulp   = require 'gulp'
gutil  = require 'gulp-util'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
gulpif = require 'gulp-if'

coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'

less   = require 'gulp-less'
prefix = require 'gulp-autoprefixer'
mincss = require 'gulp-minify-css'

imgmin = require 'gulp-imagemin'
gm     = require 'gulp-gm'

gulp.task 'coffeeToJs', ->
  gulp.src ['src/coffee/*.coffee', 'bower_components/picturefill/dist/picturefill.js']
  .pipe gulpif /[.]coffee$/, coffee {bare:true}
  .pipe concat 'all.js'
  .pipe uglify()
  .pipe rename 'all.min.js'
  .pipe gulp.dest 'built'
  .on 'error', gutil.log

gulp.task 'lessToCss', ->
  gulp.src 'src/less/*.less'
  .pipe less()
  .pipe concat 'all.css'
  .pipe prefix()
  .pipe mincss()
  .pipe rename 'all.min.css'
  .pipe gulp.dest 'built'

gulp.task 'pictureLandscape', ->
  gulp.src 'src/image/landscape/*.jpg'
  .pipe gm (gmfile) ->
      gmfile.resize 1600
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/l/xxl'
  .pipe gm (gmfile) ->
    gmfile.resize 1382
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/l/xl'
  .pipe gm (gmfile) ->
    gmfile.resize 992
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/l/l'
  .pipe gm (gmfile) ->
    gmfile.resize 768
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/l/m'
  .pipe gm (gmfile) ->
    gmfile.resize 480
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/l/s'
  .pipe gm (gmfile) ->
    gmfile.resize 300
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/l/xs'

gulp.task 'picturePortrait', ->
  gulp.src 'src/image/portrait/*.jpg'
  .pipe gm (gmfile) ->
      gmfile.resize null, 1600
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/p/xxl'
  .pipe gm (gmfile) ->
    gmfile.resize null, 1382
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/p/xl'
  .pipe gm (gmfile) ->
    gmfile.resize null, 992
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/p/l'
  .pipe gm (gmfile) ->
    gmfile.resize null, 768
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/p/m'
  .pipe gm (gmfile) ->
    gmfile.resize null, 480
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/p/s'
  .pipe gm (gmfile) ->
    gmfile.resize null, 300
  .pipe imgmin {progressive: true}
  .pipe gulp.dest 'built/img/p/xs'

gulp.task 'font-awesome', ->
  gulp.src 'bower_components/font-awesome/fonts/*'
  .pipe gulp.dest 'dist/fonts/font-awesome'

gulp.task 'watch', ->
  gulp.watch 'src/coffee/*.coffee', ['coffeeToJs']
  gulp.watch 'src/less/*.less', ['lessToCss']
  gulp.watch 'src/image/landscape/*.jpg', ['pictureLandscape']
  gulp.watch 'src/image/portrait/*.jpg', ['picturePortrait']

gulp.task 'default', ['coffeeToJs', 'lessToCss', 'pictureLandscape', 'picturePortrait', 'font-awesome']
