local api = require("api")
local compat = "space-age"
if not mods[compat] then return end

data:extend({{
  type = "mod-data",
  name = "bbexcavation-config-compat-"..compat,
  data_type = api.config.data_type,
  data = {

    source = compat,

    surface_tile = {
      ["nauvis"] = "water-shallow",
      ["vulcanus"] = "lava",
      ["fulgora"] = "oil-ocean-shallow",
      ["gleba"] = "water-shallow",
      ["aquilo"] = "brash-ice",
    },

    tech_prerequisites = {
      ["carbon-fiber"] = true,
    },

    tech_unit = {
      count = 750,
      time = 30,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "military-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "space-science-pack", 1 },
        { "metallurgic-science-pack", 1 },
        { "agricultural-science-pack", 1 },
      },
    },

    ingredients = {
      { type = "item", name = "barrel", amount = 1 },
      { type = "item", name = "carbon-fiber", amount = 10 },
      { type = "item", name = "cliff-explosives", amount = 5 },
      { type = "item", name = "landfill", amount = 1 },
    }

  }
}})
