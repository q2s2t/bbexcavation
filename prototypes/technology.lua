local api = require("api")

data:extend({{
  type = "technology",
  name = "bbexcavation-explosives",
  icon = "__bbexcavation__/graphics/technology/excavation-explosives.png",
  icon_size = 256,
  prerequisites = api.config.tech_prerequisites,
  unit = api.config.tech_unit,
  effects = { {
      type = "unlock-recipe",
      recipe = "bbexcavation-explosives"
  } },
}})
