module.exports = (grunt) ->
  grunt.initConfig
    pkg:    grunt.file.readJSON 'package.json'
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      build:
        src:  'lib/<%= pkg.name %>.js'
        dest: 'build/<%= pkg.name %>.min.js' 
    jasmine:
      customTemplate:
        src: '<%= coffeelint.src %>'
        options:
          specs: 'src/spec/*Spec.js'
          helpers: 'src/spec/*Helper.js'
          template: 'src/templates/custom.tmpl'
    coffee:
      compile:
        files:
          'lib/sb-release-notes.js': 'src/lib/*.coffee'
          'spec/*.js':               'src/spec/*.coffee'
    coffeelint:
      src: 'src/**/*.coffee'
    watch:
      files: '<%= coffeelint.src %>'
      tasks: ['coffeelint', 'jasmine']
            
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask 'test',    ['jasmine']
  grunt.registerTask 'default', ['coffeelint', 'coffee', 'uglify']