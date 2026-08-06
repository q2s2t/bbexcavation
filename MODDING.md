# Mod integration

Other mods can extend or override Blueberry Excavation's configuration with a
`mod-data` prototype. Declare `bbexcavation` as a dependency and register the
prototype from your mod's `data.lua`. Configuration is collected during
`data-updates.lua`.

Every field is optional. The following example shows the available fields:

```lua
local api = require("__bbexcavation__/api")

data:extend({{
  type = "mod-data",
  name = "my-mod-bbexcavation-config",
  data_type = api.config.data_type,
  data = {
    -- Identifies the configuration provider in diagnostics.
    source = "my-mod",

    -- Tile placed after excavation, keyed by surface name.
    -- Use "any" as the fallback for surfaces not listed explicitly.
    -- Use "ignore" to preserve the tile already present at the position.
    surface_tile = {
      ["nauvis"] = "water",
      ["vulcanus"] = "lava",
      ["any"] = "water",
    },

    -- Additional technologies required before excavation explosives unlock.
    tech_prerequisites = {
      ["cliff-explosives"] = true,
    },

    -- Technology unit settings for the excavation explosives technology.
    tech_unit = {
      count = 400,
      time = 30,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
      },
    },

    -- Ingredients added to the excavation explosives recipe.
    ingredients = {
      { type = "item", name = "cliff-explosives", amount = 5 },
    },
  },
}})
```

## Overrides and removal
Configuration is loaded in this order:

1. Base configuration
2. Built-in compatibility
3. Compatibility supplied by other mods
4. User settings.

Because later values override earlier assignments, startup settings have the
highest precedence.

Existing entries can be removed with the same markers accepted by the startup 
settings. This lets a compatibility layer undo an earlier assignment instead of 
replacing it.

Surface-tile entries can be removed with `"--"`:

```lua
data = {
  surface_tile = {
    ["vulcanus"] = "--",
  },
}
```

Tile names are validated against registered tile prototypes. The special value
`"ignore"` is also valid. Technology prerequisites and recipe ingredients are
merged into the existing configuration; `tech_unit` is replaced when supplied.
