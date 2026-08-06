local api = require("api")

data:extend({
  { type = "recipe",
    name = "bbexcavation-explosives",
    energy_required = 8,
    enabled = false,
    categories = { "crafting" },
    ingredients = api.config.ingredients,
    results = {
      { type = "item", name = "bbexcavation-explosives", amount = 1 },
    }
  },
})

if mods["recycler"] then
  local recycling = require("__recycler__.recycling")
  recycling.generate_recycling_recipe(data.raw.recipe["bbexcavation-explosives"])
end
