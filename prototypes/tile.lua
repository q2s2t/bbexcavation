local api = require("api")

for _, tile_name in pairs(api.config.surface_tile) do repeat
  if tile_name == "ignore" then break end
  local tile = data.raw.tile[tile_name]
  tile.can_be_part_of_blueprint = true
  tile.placeable_by = { item = "bbexcavation-explosives", count = 1 }
until true end