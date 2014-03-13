module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      compile:
        files:
          'build/reactiverecord.js': 'src/reactiverecord.coffee'
          'build/example.js': 'examples/example.coffee'
          'build/space-pen.js': ['vendor/jquery-extensions.coffee', 'vendor/space-pen.coffee']

    coffeelint:
      options:
        no_empty_param_list:
          level: 'error'
        max_line_length:
          level: 'ignore'

      gruntfile: ['Gruntfile.coffee']

    connect:
      server:
        options:
          port: 1337
          keepalive: true

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-connect')

  grunt.registerTask 'clean', ->
    rm = (pathToDelete) ->
      grunt.file.delete(pathToDelete) if grunt.file.exists(pathToDelete)
    rm('build')

  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('start', ['default', 'connect'])
  grunt.registerTask('default', ['coffee', 'lint'])
