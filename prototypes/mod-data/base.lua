local api = require("api")
local source = "base"

data:extend({{
  type = "mod-data",
  name = "bbexcavation-config-"..source,
  data_type = api.config_data_type,
  data = {

    source = source,

    surface_tile = {
      ["any"] = "water",
    },

    tech_prerequisites = {
      ["cliff-explosives"] = true,
      ["landfill"] = true,
      ["military-science-pack"] = true,
    },

    tech_unit = {
      count = 400,
      time = 30,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "military-science-pack", 1 },
        { "chemical-science-pack", 1 },
      },
    },

    ingredients = {
      { type = "item", name = "barrel", amount = 1 },
      { type = "item", name = "iron-stick", amount = 10 },
      { type = "item", name = "cliff-explosives", amount = 5 },
    }

  }
}})
