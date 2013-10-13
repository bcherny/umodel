
Model = require '../umodel'

exports.umodel =

	init: (test) ->

		# with data
		model = new Model foo: bar
		actual = model._data.foo
		expected = 'bar'

		test.equal actual, expected, 'initializes with data'

		# with options
		model = new Model {}, separator: '.'
		actual = model.options.separator
		expected = '.'

		test.equal actual, expected, 'initializes with options'

		test.done()

	get: (test) ->

		model = new Model
		model._data =
			foo: 'bar'
			baz:
				moo: 'boo'

		# shallow
		actual = model.get 'foo'
		expected = 'bar'
		test.equal actual, expected, 'shallow get'

		# deep
		actual = model.get 'baz/moo'
		expected = 'boo'
		test.equal actual, expected, 'deep get'

		# error
		err = -> model.get 'woo'
		test.throws err, null, 'getting an undefined key throws an error'

		test.done()

	set: (test) ->

		model = new Model

		# shallow
		model.set 'foo', 'bar'
		actual = model._data.foo
		expected = 'bar'
		test.equal actual, expected, 'shallow set'

		# deep
		model.set 'baz/moo', 'boo'
		actual = model._data.baz.moo
		expected = 'boo'
		test.equal actual, expected, 'deep set'

		test.done()

	setnx: (test) ->

		model = new Model

		# shallow set
		model.setnx 'foo', 'bar'
		actual = model._data.foo
		expected = 'bar'

		test.equal actual, expected, 'shallow setnx sets'

		# shallow set doesn't override
		model.setnx 'foo', 'baz'
		actual = model._data.foo
		expected = 'bar'

		test.equal actual, expected, 'shallow setnx does not override once set'

		# deep set
		model.setnx 'baz/moo', 'boo'
		actual = model._data.baz.moo
		expected = 'boo'

		test.equal actual, expected, 'deep setnx sets'

		# deep set doesn't override
		model.setnx 'baz.moo', 'woo'
		actual = model._data.baz.moo
		expected = 'boo'

		test.equal actual, expected, 'deep setnx sets does not override once set'

		test.done()

	# on: (test) ->

	# 	model = new Model

	# 	calledGet = false
	# 	calledSet = false
	# 	calledSetnx = false

		
	# 	model.on 'set', -> calledSet = true
	# 	model.on 'setnx', -> calledSetnx = true

	# 	# get
	# 	model.on 'get', -> calledGet = true
	# 	model.get ''