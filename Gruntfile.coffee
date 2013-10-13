module.exports = (grunt) ->

	grunt.config.init

		coffee:

			compile:
				files:
					'umodel.js': 'umodel.coffee'

		uglify:

			options:
				mangle:
					toplevel: true
				compress:
					dead_code: true
					unused: true
					join_vars: true
				comments: false

			standard:
				files:
					'umodel.min.js': [
						'umodel.js'
					]


	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-uglify'

	grunt.registerTask 'default', ['coffee', 'uglify']