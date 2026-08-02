local api = require("api")
local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({{ type = "item",
  name = "bbexcavation-explosives",
  icon = "__bbexcavation__/graphics/icons/excavation-explosives.png",
  icon_size = 64,
  subgroup = "terrain",
  order = "e[excavation-explosives]",
  inventory_move_sound = item_sounds.explosive_inventory_move,
  pick_sound = item_sounds.explosive_inventory_pickup,
  drop_sound = item_sounds.explosive_inventory_move,
  stack_size = 20,
  weight = 50 * kg,
  place_as_tile = {
    result = api.config.surface_tile["any"],
    condition_size = 1,
    condition = { layers = { water_tile = true } }
  }
}})
