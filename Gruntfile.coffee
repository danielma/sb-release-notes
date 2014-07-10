module.exports = (grunt) ->
  grunt.initConfig
    pkg:    grunt.file.readJSON 'package.json'
    banner: require('banners')
    concat:
      options:
        banner: '<%= banner.block %>'
      dist:
        src:  'lib/src/**/*.js'
        dest: 'dist/<%= pkg.name %>.js'
    uglify:
      dist:
        src:  '<%= concat.dist.dest %>'
        dest: 'dist/<%= pkg.name %>.min.js'
    jasmine:
      customtemplate:
        src: '<%= coffeelint.src %>'
        options:
          specs:    'src/spec/*spec.js'
          helpers:  'src/spec/*helper.js'
          template: 'src/templates/custom.tmpl'
    coffee:
      compile:
        expand:  true
        cwd:     'src'
        src:     ['**/*.coffee']
        dest:    ''
        ext:     '.js'
    coffeelint:
      src: 'src/**/*.coffee'
    watch:
      files: '<%= coffeelint.src %>'
      tasks: ['coffeelint', 'test', 'coffee', 'concat']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'test',    []
  grunt.registerTask 'default', ['coffeelint', 'coffee', 'concat', 'uglify']
