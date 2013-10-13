# µModel

Tiny, generic, fully tested model.

```coffee
new umodel [data], [options]
```

`data` {Object} initialize the model with some data
`options` {Object}
	`separator` (default: `/`) separator for getting/setting nested keys

## API

`umodel.get key` get a key, throwing an error if a parent key is not set
`umodel.set key, value` set a key, lazy-creating parent keys along the way if nested
`umodel.setnx key, value` like `set`, but only if the given key has not been set yet

## Usage

```coffee
Model = require 'umodel'

model = new Model
	foo: 'bar'
# => model

model.get 'foo'
# => 'bar'

model.set 'bar/baz', (beans) -> 'stew'
# => [Function]

model.get 'bar/baz'
# => [Function]

# set only if the key "tomato" is not yet set.
model.setnx 'tomato', 'potato'
# => "potato"
```