local api = require("api")
api.stage_runtime.init()

local function place_tiles(entity, target)
  local surface = entity.surface.name
  if not api.config.surface_tile[surface] then surface = "any" end
  local tile_name = api.config.surface_tile[surface]
  for _, tile in pairs(target) do
    entity.surface.create_entity({
      name = "big-explosion",
      force = entity.force,
      position = { tile.position.x + 0.5, tile.position.y + 0.5 }
    })
    tile.name = tile_name
  end
  if tile_name then
    entity.surface.set_tiles(target)
  end
end

script.on_event(defines.events.on_player_built_tile, function(event)
  if event.item
    and event.item.valid
    and event.item.name == "bbexcavation-explosives"
  then
    place_tiles(game.players[event.player_index], event.tiles)
  end
end)

script.on_event(defines.events.on_robot_built_tile, function(event)
  if event.item
    and event.item.valid
    and event.item.name == "bbexcavation-explosives"
  then
    place_tiles(event.robot, event.tiles)
  end
end)

--FIXME Offshore pumps. When a blueprint containing excavation tiles and offshore pumps is created Factorio can initialize the pumps before Blueberry Excavation replaces the tiles with the destination surface's fluid. Offshore pumps cache their source fluid when created and do not detect a later scripted tile replacement, leaving them unable to pump. The fix of deleting/replacing them works but it also degrades the undo/redo stack.