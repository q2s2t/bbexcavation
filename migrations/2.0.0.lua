local old_technology_name = "blasting-charges"
local new_technology_name = "bbexcavation-explosives"
local old_recipe_name = "blasting-charge"
local new_recipe_name = "bbexcavation-explosives"
local old_item_name = "blasting-charge"
local new_item_name = "bbexcavation-explosives"

local function migrate_stack(stack)
  if stack and stack.valid_for_read and stack.name == old_item_name then
    stack.set_stack({
      name = new_item_name,
      count = stack.count,
      quality = stack.quality.name
    })
  end
end

local function migrate_inventory(inventory)
  if not inventory or not inventory.valid then return end
  for i = 1, #inventory do
    migrate_stack(inventory[i])
  end
end

local inventory_ids = {}
for _, inventory_id in pairs(defines.inventory) do
  inventory_ids[inventory_id] = true
end

for _, force in pairs(game.forces) do
  local old_technology = force.technologies[old_technology_name]
  local new_technology = force.technologies[new_technology_name]
  local old_recipe = force.recipes[old_recipe_name]
  local new_recipe = force.recipes[new_recipe_name]

  if old_technology and new_technology then
    if old_technology.researched then
      new_technology.researched = true
    elseif old_technology.saved_progress > new_technology.saved_progress then
      new_technology.saved_progress = old_technology.saved_progress
    end
  end

  if old_recipe and new_recipe and old_recipe.enabled then
    new_recipe.enabled = true
  end
end

for _, player in pairs(game.players) do
  migrate_stack(player.cursor_stack)
  for inventory_id in pairs(inventory_ids) do
    migrate_inventory(player.get_inventory(inventory_id))
  end
end

for _, surface in pairs(game.surfaces) do
  for _, entity in pairs(surface.find_entities()) do
    if entity.type == "item-entity" then
      migrate_stack(entity.stack)
    end
    for inventory_id in pairs(inventory_ids) do
      migrate_inventory(entity.get_inventory(inventory_id))
    end
  end
end
