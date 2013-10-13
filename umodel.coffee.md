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

		constructor: (@_data = {}, options) ->

Default options

			@options =
				separator: '/'

Set options

			if options
				_.extend @options, options

### get
get {Mixed}key

		get: (key) ->

			@_get @_split key

### Set
set {Mixed}key {Mixed}value

		set: (key, value) ->

			@_set @_split(key), value
			
Setnx {Mixed}key {Mixed}value

		setnx: (key, value) ->

			@_set @_split(key), value, true

### _get
Internal `get` implementation. `accumulator` is for debugging purposes, to return the last defined key when a key is undefined

		_get: (key, parent = @_data, accumulator = []) ->

Get the next key

			head = key.shift()

Ensure that the key is defined

			if head

Throw an error if key does not exist

				if head not of parent
					throw new Error 'get: key "' + head + '" does not exist in "' + accumulator.join('/') + '"'

Otherwise, accumulate successful lookups for debugging purposes

				accumulator.push head

Recurse over the next deepest object

				return @_get key, parent[head], accumulator

Return the result

			parent

### _split
Internal key parser, parses strings to arrays.

		_split: (key) ->

			separator = @options.separator

Trim leading separator?

			if key.charAt(0) is separator

				key = key.slice 1

Trim trailing separator?

			if key.charAt(key.length - 1) is separator

				key = key.slice 0, -1

Split by separator

			key.split separator

### Internal `set` implementation
`nx` is a flag for "set only if the given key has not been set yet". `accumulator` is a key trace for debugging purposes

		_set: (key, value, nx = false, parent = @_data, accumulator = []) ->

Get the next key

			head = key.shift()

			if key.length

Lazy create key in chain?

				if head not of parent

					parent[head] = {}

Accumulate successful lookups for debug purposes

				accumulator.push head

Recurse to our parent key

				return @_set key, value, nx, parent[head], accumulator

Set and return *if* `setnx` and the key already exists, throw an error

			if not (nx and head of parent)
				parent[head] = value

UMD (play nice with AMD, CommonJS, globals)

	umd = (name, factory) ->
		if typeof exports is 'object'
			module.exports = factory
		else if typeof define is 'function' and define.amd
			define name, [], -> factory
		else
			@[name] = factory

	umd 'umodel', Model