# µModel

## helpers

	_ =

### extend
shallow object extend

		extend: (a, b) ->
			for own key of b
				a[key] = b[key]
			a

## µModel

	class Model

Default options

		options:

			separator: '/'

		constructor: (@_data = {}, options) ->

Set options

			if options
				_.extend @options, options

Get {Mixed}key

		get: (key) ->

			@_get key.split(@options.separator)

Internal `get` implementation

		_get: (key, parent = @_data) ->

			head = key.shift()

			if head and head of parent

				@_get key, parent[head]

			else

				parent

Set {Mixed}key {Mixed}value

		set: (key, value) ->

Setnx {Mixed}key {Mixed}value

		setnx: (key, value) ->

UMD (play nice with AMD, CommonJS, globals)

	umd = (name, factory) ->
		if typeof exports is 'object'
			module.exports = factory
		else if typeof define is 'function' and define.amd
			define name, [], -> factory
		else
			@[name] = factory

	umd 'umodel', Model