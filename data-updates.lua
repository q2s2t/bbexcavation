require("prototypes.mod-data.settings")

local api = require("api")

api.stage_proto.apply_config(function (mod_data)

  -- user setting = validation required

  if not api.config.surface_tile then api.config.surface_tile = {} end
  if mod_data.surface_tile then
  for surface, tile in pairs(mod_data.surface_tile) do
    if api.validate(
      "Invalid tile: "..tile,
      data.raw["tile"][tile] ~= nil )
    then
      api.config.surface_tile[surface] = tile
    end
  end end

  -- no user setting = no validation

  if not api.config.tech_prerequisites then api.config.tech_prerequisites = {} end
  if mod_data.tech_prerequisites then
  for preq, _ in pairs(mod_data.tech_prerequisites) do
    table.insert(api.config.tech_prerequisites, preq)
  end end

  if not api.config.tech_unit then api.config.tech_unit = {} end
  if mod_data.tech_unit then
    api.config.tech_unit = mod_data.tech_unit
  end

  if not api.config.ingredients then api.config.ingredients = {} end
  if mod_data.ingredients then
    api.config.ingredients = mod_data.ingredients
  end

end)

require("prototypes.technology")
require("prototypes.recipes")
require("prototypes.items")
require("prototypes.tile")
