# µModel

Tiny, generic, fully tested model.

## API

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