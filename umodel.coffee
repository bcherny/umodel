
class Model

	_data: {}

	get: (key) ->

	set: (key, value) ->

	setnx: (key, value) ->

# UMD (play nice with AMD, CommonJS, globals)
umd = (name, factory) ->
	if typeof exports is 'object'
		module.exports = factory
	else if typeof define is 'function' and define.amd
		define name, [], -> factory
	else
		@[name] = factory

umd 'umodel', Model