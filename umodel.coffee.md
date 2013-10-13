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

### Get
get {Mixed}key

		get: (key) ->

			@_get key.split(@options.separator)

### Internal `get` implementation
`accumulator` is for debugging purposes, to return the last defined key when a key is undefined

		_get: (key, parent = @_data, accumulator = []) ->

Get the next key

			head = key.shift()

Ensure that the key is defined

			if head

Throw an error if key does not exist

				if head not of parent
					throw new Error 'key "' + head + '" does not exist in "' + accumulator.join('/') + '"'

Otherwise, accumulate successful lookups for debugging purposes

				accumulator.push head

Recurse over the next deepest object

				return @_get key, parent[head], accumulator

Return the result

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