# Neorg Zettelkasten 📤

_At the moment this module has no functionality. The commands just refer to empty functions_

The Zettelkasten module for neorg.

### Installation

You can install and load the module like this:

```lua
-- packer installation
use {'max397574/neorg-zettelkasten'}

-- neorg configuration
require('neorg').setup {
  load = {
    ...
    ["external.zettelkasten"] = {}
  },
}
```

### Usage

This module creates different commands for managing a zettelkasten in neorg.

- `Neorg zettel new`: Create a new zettel.
- `Neorg zettel backlinks float/split`: See the backlinks for the current zettel in a float or split.
- `Neorg zettel explore`: Search through all the zettels in your zettelkasten.
