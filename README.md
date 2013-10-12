# µModel

Tiny, generic, fully tested model.

## API

```coffee
model = require 'umodel'

model.set 'foo', 'bar'

model.get 'foo'

model.set 'bar/baz', (beans) -> 'stew'

# set only if the key "tomato" is not yet set.
model.setnx 'tomato', 'potato'
```