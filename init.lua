--Data (11) : in_pos, out_pos, y_dest, x_dest, z_dest, factor, look, r_pos, waypoint1, waypoint2, waypoint3
data = minetest.get_mod_storage()

dofile(minetest.get_modpath("tardis_new") .. "/exterior.lua")
dofile(minetest.get_modpath("tardis_new") .. "/interior.lua")
dofile(minetest.get_modpath("tardis_new") .. "/consle.lua")

minetest.register_craftitem("tardis_new:arton", {
		description = "Arton Crystal",
		inventory_image = "arton.png",
		groups = {}
})
minetest.register_node("tardis_new:spacetime", {
		description = "Compressed Spacetime",
		tiles = {"tardis_spacetime.png"},
		groups = {cracky = 1},
})
minetest.register_craftitem("tardis_new:board", {
		description = "Tardis Circuitry",
		inventory_image = "tardis_board.png",
		groups = {}
})
minetest.register_tool("tardis_new:sonic", {
	description = "Sonic Screwdriver",
	inventory_image = "sonic.png",
	stack_max=1,
	on_use = function(itemstack, player, pointed_thing)
	local pmeta = player:get_meta()
	local id = player:get_player_name()
	local imeta = itemstack:get_meta()
	imeta:set_string("interact", "no")
	if pointed_thing.type == "node" then
		local node = minetest.get_node(pointed_thing.under)
		local meta = minetest.get_meta(pointed_thing.under)
		local select_pos = pointed_thing.under
		if id == meta:get_string("id") then
			if minetest.get_item_group(node.name, "tardis") == 1 then
				local look = data:get_string(id.."look")
				minetest.set_node(select_pos, {name = look.."_locked"})
				local ometa = minetest.get_meta(select_pos)
				ometa:set_string("id", id)
				minetest.chat_send_player(id, "Tardis Locked")
				imeta:set_string("interact", "yes")
			end
			if minetest.get_item_group(node.name, "tardis_locked") == 1 then
				local look = data:get_string(id.."look")
				minetest.set_node(select_pos, {name = look})
				local timer = minetest.get_node_timer(select_pos)
				timer:start(0.2)
				local ometa = minetest.get_meta(select_pos)
				ometa:set_string("id", id)
				minetest.chat_send_player(id, "Tardis Unlocked")
				imeta:set_string("interact", "yes")
			end
		end
		if minetest.get_modpath("doors") then
			if node.name == "doors:door_steel_a" or node.name == "doors:door_steel_c" then
				doors.door_toggle(select_pos, nil, nil)
				imeta:set_string("interact", "yes")
			end
			if node.name == "doors:trapdoor_steel" or node.name == "doors:trapdoor_steel_open" then
				doors.trapdoor_toggle(select_pos, nil, nil)
				imeta:set_string("interact", "yes")
			end
		end
		if node.name == "default:glass" then
			minetest.set_node(select_pos, {name = "default:obsidian_glass"})
			imeta:set_string("interact", "yes")
		end
		if node.name == "default:dirt" then
			minetest.set_node(select_pos, {name = "default:dirt_with_grass"})
			imeta:set_string("interact", "yes")
		end
		if node.name == "default:sand" then
			minetest.set_node(select_pos, {name = "default:silver_sand"})
			imeta:set_string("interact", "yes")
		end
		if imeta:get_string("interact") == "no" then
			if pmeta:get_string("in") == "no" then 
				if data:get_int(id.."power") < 3 then minetest.chat_send_player(id, "Not Enough Power In Tardis!") else
					local select_pos = pointed_thing.above
					local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
					local look = data:get_string(id.."look")
					minetest.set_node(out_pos, {name = "air"})
					out_pos.x = select_pos.x
					out_pos.y = select_pos.y
					out_pos.z = select_pos.z
						
					out_pos.y = out_pos.y+1
					minetest.set_node(out_pos, {name = "air"})
					out_pos.y = out_pos.y-1
					
					minetest.set_node(out_pos, {name=look})
					local ometa = minetest.get_meta(out_pos)
					ometa:set_string("id", id)
					data:set_string(id.."out_pos", minetest.serialize(out_pos))
					data:set_int(id.."power", data:get_string(id.."power")-3)
					local timer = minetest.get_node_timer(out_pos)
					timer:start(0.5)
					minetest.chat_send_player(id, "Tardis Summoned")
				end
			end
		end
	end
	if pointed_thing.type == "object" then
		local obj = pointed_thing.ref
		minetest.chat_send_player(id, obj:get_hp()/2 .. " Hearts")
	end
	minetest.sound_play("sonic_sound", { max_hear_distance = 10})
	itemstack:set_wear(itemstack:get_wear() + 400) return itemstack
end
})
local function get_formspec_screen(power, posx, posy, posz, desx, desy, desz, block, id)
	local power = "Tardis Energy Banks: " .. power
	local cur = "Current Position: " .. posx .. ", " .. posy .. ", " .. posz
	local dest = "Destination: " .. desx .. ", " .. desy .. ", " .. desz
	local block = block
	local id = "Tardis Owner: " .. id
    return "size[10,10]"..
		"label[1,1;"..minetest.formspec_escape(power).."]"..
		"label[1,2.5;"..minetest.formspec_escape(cur).."]"..
		"label[1,4;"..minetest.formspec_escape(dest).."]"..
		"label[1,5.5;Block Tardis Is On: ]"..
		"item_image[3,5;2,2;"..minetest.formspec_escape(block).."]"..
		"label[1,7;"..minetest.formspec_escape(id).."]"
end
minetest.register_node("tardis_new:screen", {
		description = "Tardis Moniter",
		tiles = {"tardis_side_1.png", "tardis_side_1.png", "tardis_side_1.png", "tardis_side_1.png", "tardis_screen.png", "tardis_side_1.png"},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.4, 0.1, 0.5,  0.4, 0 },
				{ 0.1, 0.1, 0, -0.1, -0.1, -0.5},
			},
		},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			if pmeta:get_string("in") == "yes" then 
				local meta = minetest.get_meta(pos)
				local id = pmeta:get_string("id")
				local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
				meta:set_string("id", id)
		
				out_pos.y = out_pos.y-1
				local node = minetest.get_node(out_pos)
				if node.name == "ignore" then
					minetest.get_voxel_manip():read_from_map(out_pos, out_pos)
					local node = minetest.get_node(out_pos)
				end
				out_pos.y = out_pos.y+1
		
				meta:set_string("formspec", get_formspec_screen(data:get_int(id.."power"), out_pos.x, out_pos.y, out_pos.z, data:get_int(id.."x_dest"), data:get_int(id.."y_dest"), data:get_int(id.."z_dest"), node.name, id ))
			else minetest.dig_node(pos) end
		end,
		on_rightclick = function(pos)
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
		
			out_pos.y = out_pos.y-1
			local node = minetest.get_node(out_pos)
			if node.name == "ignore" then
				minetest.get_voxel_manip():read_from_map(out_pos, out_pos)
				local node = minetest.get_node(out_pos)
			end
			out_pos.y = out_pos.y+1
		
			meta:set_string("formspec", get_formspec_screen(data:get_int(id.."power"), out_pos.x, out_pos.y, out_pos.z, data:get_int(id.."x_dest"), data:get_int(id.."y_dest"), data:get_int(id.."z_dest"), node.name, id ))
		end
})
local function get_formspec_lab(pos)
    return "size[10,10]"..
		"image[4.5,2;1,1;tardis_arrow.png]"..
		"list[context;fuel;2,2;1,1;1]"..
		"list[context;dest;7,2;1,1;1]"..
		"list[current_player;main;1,5;8,4;]"
end
local function lab_recipe(item,result,pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if inv:contains_item("fuel", item) == true and inv:is_empty("dest") then
		inv:remove_item("fuel",item)
		local fuel_s = inv:get_stack("fuel", 2)
		inv:set_stack("fuel", 2, fuel_s)
		inv:set_stack("dest", 2, result)
	end
end
local function lab_crafting(pos)
	lab_recipe("default:diamondblock","tardis_new:spacetime",pos)
	lab_recipe("default:mese_crystal","tardis_new:arton",pos)
	lab_recipe("default:mese","default:diamond",pos)
	lab_recipe("default:copper_ingot","default:steel_ingot",pos)
	lab_recipe("default:coal_lump","default:tin_lump 3",pos)
	lab_recipe("default:steelblock","default:mese_crystal 3",pos)
	lab_recipe("default:dirt","default:coal_lump",pos)
end
minetest.register_node("tardis_new:lab", {
		description = "Gallifreyan Lab",
		tiles = {"tardis_lab.png"},
		groups = {cracky = 3},
		on_construct = function(pos, node)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			--Set inventories (no idea why they have to be 1 * 2)
			inv:set_size("fuel", 2*1)
			inv:set_size("dest", 2*1)
			--Set formspec
			formspec = get_formspec_lab(pos)
			meta:set_string("formspec", formspec)
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			lab_crafting(pos)
			player:set_hp(player:get_hp()-4) 
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			lab_crafting(pos)
			player:set_hp(player:get_hp()-4)
		end
})
minetest.register_craftitem("tardis_new:biscut", {
		description = "Biscut",
		inventory_image = "tardis_biscut.png",
		on_use = minetest.item_eat(8)
})
minetest.register_on_dieplayer(function(player)
	local pmeta = player:get_meta()
	pmeta:set_string("in", "no") 
	pmeta:set_string("vortex", "no") 
end)
-----------
--Recipes--
-----------
minetest.register_craft({
		output = "tardis_new:tardis_old",
		recipe = {
			{"default:steelblock", "tardis_new:arton", "default:steelblock"},
			{"default:steelblock", "tardis_new:spacetime", "default:steelblock"},
			{"default:steelblock", "tardis_new:board", "default:steelblock"}
		}
})
minetest.register_craft({
		output = "tardis_new:lab",
		recipe = {
			{"default:tinblock", "default:mese", "default:steelblock"},
			{"default:mese", "tardis_new:board", "default:mese"},
			{"default:steelblock", "default:mese", "default:tinblock"}
		}
})
minetest.register_craft({
		output = "tardis_new:board",
		recipe = {
			{"default:copper_ingot", "default:diamond", "default:tin_ingot"},
			{"default:mese_crystal", "default:goldblock", "default:steel_ingot"},
			{"group:wood", "group:wood", "group:wood"}
		}
})
minetest.register_craft({
		output = "tardis_new:rotor",
		recipe = {
			{"default:steelblock", "default:diamond", "default:steelblock"},
			{"default:glass", "tardis_new:arton", "default:glass"},
			{"default:steelblock", "tardis_new:board", "default:steelblock"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_y",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:grass_1", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_x",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:dry_grass_1", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_z",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:junglegrass", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_go",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:silver_sandstone_block", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_c",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:cactus", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_f",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:obsidian_block", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_o",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:bronzeblock", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_s",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:permafrost", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:screen",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:board", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
		}
})
minetest.register_craft({
		output = "tardis_new:light",
		recipe = {
			{"", "default:steel_ingot", ""},
			{"default:steel_ingot", "tardis_new:arton", "default:steel_ingot"},
			{"", "default:steel_ingot", ""}
		}
})
minetest.register_craft({
		output = "tardis_new:wall_craftable 9",
		recipe = {
			{"default:steel_ingot"},
			{"tardis_new:arton"},
			{"default:steel_ingot"}
		}
})

minetest.register_craft({
		output = "tardis_new:tardis_old",
		recipe = {
			{"default:steelblock", "tardis_new:arton", "default:steelblock"},
			{"default:steelblock", "tardis_new:spacetime", "default:steelblock"},
			{"default:steelblock", "tardis_new:board", "default:steelblock"}
		}
})
minetest.register_craft({
		output = "tardis_new:lab",
		recipe = {
			{"default:tinblock", "default:mese", "default:steelblock"},
			{"default:mese", "tardis_new:board", "default:mese"},
			{"default:steelblock", "default:mese", "default:tinblock"}
		}
})
minetest.register_craft({
		output = "tardis_new:board 2",
		recipe = {
			{"default:copper_ingot", "default:diamond", "default:tin_ingot"},
			{"default:mese_crystal", "default:goldblock", "default:steel_ingot"},
			{"group:wood", "group:wood", "group:wood"}
		}
})
minetest.register_craft({
		output = "tardis_new:rotor",
		recipe = {
			{"default:steelblock", "default:diamond", "default:steelblock"},
			{"default:glass", "tardis_new:arton", "default:glass"},
			{"default:steelblock", "tardis_new:board", "default:steelblock"}
		}
})