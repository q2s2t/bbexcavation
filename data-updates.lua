require("prototypes.mod-data.settings")

local api = require("api")
local valid = require("lualib.valid")
local config = api.config

valid.tile = require("lualib.valid_tile")
valid.tile["ignore"] = true

api.apply_data_config(function (mod_data)

  -- user setting = validation required

  config.surface_tile = config.surface_tile or {}
  if mod_data.surface_tile then for k, tile in pairs(mod_data.surface_tile) do repeat
    if tile == "--" then config.surface_tile[k] = nil break end
    if not valid.is("tile", tile,  valid.tile[tile]) then break end
    config.surface_tile[k] = tile
  until true end end

  -- no user setting = no validation

  config.tech_prerequisites = config.tech_prerequisites or {}
  if mod_data.tech_prerequisites then
  for preq, _ in pairs(mod_data.tech_prerequisites) do
    table.insert(config.tech_prerequisites, preq)
  end end

  config.tech_unit = config.tech_unit or {}
  if mod_data.tech_unit then
    config.tech_unit = mod_data.tech_unit
  end

  config.ingredients = config.ingredients or {}
  if mod_data.ingredients then
    config.ingredients = mod_data.ingredients
  end

end)

require("prototypes.tile")
require("prototypes.items")
require("prototypes.recipes")
require("prototypes.technology")
