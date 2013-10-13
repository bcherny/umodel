# µModel

[![browser support](https://ci.testling.com/eighttrackmind/umodel.png)](https://ci.testling.com/eighttrackmind/umodel)
[![Build Status](https://travis-ci.org/eighttrackmind/umodel.png)](https://travis-ci.org/eighttrackmind/umodel.png)

Tiny, generic, fully tested model.

```coffee
new umodel([data], [options])
```

`data` {Object} initialize the model with some data

`options` {Object}

- `separator` (default: `/`) separator for getting/setting nested keys

## API

`umodel.`

- `get(key)` get a key, throwing an error if a parent key is not set
- `set(key, value)` set a key, lazy-creating parent keys along the way if nested
- `setnx(key, value)` like `set`, but only if the given key has not been set yet
- `on("event1 [event2...], :[property]", fn)` call `fn` with `{key: value}, this` when an event is triggered

## Usage

```js
var Model = require('umodel')

var model = new Model({
	foo: 'bar'
})
//-> model

model.get('foo')
//-> 'bar'

model.set('bar/baz', function (beans) {
	return 'stew'
})
//-> [Function]

model.get('bar/baz')
//-> [Function]

// set only if the key "tomato" is not yet set.
model.setnx('tomato', 'potato')
//-> "potato"

// call the function `callback` when any property is read
var callback = function (changes, model) { ... }
model.on('get', callback)
//-> undefined

// call the function `callback` when `set` or `setnx` is called on `foo/bar` or any of its descendants (a more precisely specified version of the "change" event available in many mvc frameworks)
model.on('set setnx: foo/bar', callback)
//-> undefined
```