
local tardis_on_place = function(pos, placer, itemstack, pointed_thing)
	if placer:get_player_name() == "" then return else
		local meta = minetest.get_meta(pos)
		local name = placer:get_player_name()
		local timer = minetest.get_node_timer(pos)
		if data:get_string(name.."in_pos") == "" then
			data:set_string(name.."out_pos", minetest.serialize(pos)) --set exterior position
			pos.y = pos.y-300
			minetest.place_schematic(pos, minetest.get_modpath("tardis_new") .. "/schems/console_room.mts")
			pos.y = pos.y+2
			pos.x = pos.x+7
			pos.z = pos.z+16
			local ometa = minetest.get_meta(pos)
			local otimer = minetest.get_node_timer(pos)
			otimer:start(0.2) --start door timer (in case it doesn't start on construct)
			ometa:set_string("id", name) --set door id
			meta:set_string("id", name) -- set exterior id
			data:set_string(name.."in_pos", minetest.serialize(pos)) --set interior position
			data:set_int(name.."power", 0) --set power
			data:set_int(name.."factor", 1) -- set travel factor
			data:set_string(name.."look", "tardis_new:tardis_old") --set skin
			data:set_int(name.."y_dest", 0)
			data:set_int(name.."x_dest", 0)
			data:set_int(name.."z_dest", 0)
			data:set_string(name.."way1", minetest.serialize({x=0, y=0, z=0}) )
			data:set_string(name.."way2", minetest.serialize({x=0, y=0, z=0}) )
			data:set_string(name.."way3",minetest.serialize({x=0, y=0, z=0}) )
			data:set_string(name.."r_pos", "") 
			timer:start(0.2)
		else minetest.set_node(pos, {name = "air"}) minetest.add_item(pos, "tardis_new:tardis_old") end
	end
end

local tardis_timer = function(pos)
	local objs = minetest.get_objects_inside_radius(pos, 0.9)
	if objs[1] == nil then return true else
		if objs[1]:is_player() then
			local meta = minetest.get_meta(pos)
			local pmeta = objs[1]:get_meta()
			local id = meta:get_string("id")
			local go_pos = minetest.deserialize(data:get_string(id.."in_pos"))
			go_pos.z = go_pos.z-1
			objs[1]:set_look_horizontal( math.rad( 180 ))
			objs[1]:set_look_vertical( math.rad( 0 ))
			objs[1]:set_pos(go_pos)
			pmeta:set_string("id", id)
		else
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			local go_pos = minetest.deserialize(data:get_string(id.."in_pos"))
			go_pos.z = go_pos.z-2
			objs[1]:set_pos(go_pos)
		end
	end
	return true
end
--------------------
--NODE DEFINITIONS--
--------------------
minetest.register_node("tardis_new:tardis", {
		description = "Tardis",
		tiles = {"tardis_main.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		light_source = 10,
		groups = {not_in_creative_inventory = 1, tardis = 1},
		after_place_node = tardis_on_place,
		diggable = false,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_locked", {
		description = "Tardis (locked)",
		tiles = {"tardis_main.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		light_source = 10,
		groups = {not_in_creative_inventory = 1, tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_pink", {
		description = "Tardis",
		tiles = {"tardis_pink.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		sselection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		light_source = 10,
		groups = {not_in_creative_inventory = 1},
		diggable = false,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_pink_locked", {
		description = "Tardis (locked)",
		tiles = {"tardis_pink.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		light_source = 10,
		groups = {not_in_creative_inventory = 1, tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_yellow", {
		description = "Tardis",
		tiles = {"tardis_yellow.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		light_source = 10,
		diggable = false,
		groups = {not_in_creative_inventory = 1, tardis = 1},
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_yellow_locked", {
		description = "Tardis (locked)",
		tiles = {"tardis_yellow.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		light_source = 10,
		groups = {not_in_creative_inventory = 1, tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_old", {
		description = "Tardis",
		tiles = {"tardis_old.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		light_source = 10,
		groups = {tardis = 1},
		diggable = false,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_old_locked", {
		description = "Tardis (locked)",
		tiles = {"tardis_old.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		light_source = 10,
		groups = {not_in_creative_inventory = 1, tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_stone", {
		description = "Tardis",
		tiles = {"default_stone.png"},
		drawtype = "nodebox",
		node_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		groups = {not_in_creative_inventory = 1, tardis = 1},
		diggable = false,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_stone_locked", {
		description = "Tardis",
		tiles = {"default_stone.png"},
		drawtype = "nodebox",
		node_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		groups = {not_in_creative_inventory = 1, tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_empty", {
		description = "Tardis",
		tiles = {"empty.png"},
		drawtype = "nodebox",
		node_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		groups = {not_in_creative_inventory = 1,  tardis = 1},
		diggable = false,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_empty_locked", {
		description = "Tardis",
		tiles = {"empty.png"},
		drawtype = "nodebox",
		node_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		groups = {not_in_creative_inventory = 1,  tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_cool", {
		description = "Tardis",
		tiles = {"tardis_cool.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		groups = {not_in_creative_inventory = 1,  tardis = 1},
		diggable = false,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_cool_locked", {
		description = "Tardis",
		tiles = {"tardis_cool.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		groups = {not_in_creative_inventory = 1,  tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_leave", {
		description = "Tardis",
		tiles = {"default_leaves.png"},
		drawtype = "nodebox",
		node_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		groups = {not_in_creative_inventory = 1,  tardis = 1},
		diggable = false,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_leave_locked", {
		description = "Tardis",
		tiles = {"default_leaves.png"},
		drawtype = "nodebox",
		node_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		groups = {not_in_creative_inventory = 1,  tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_soda", {
		description = "Tardis",
		tiles = {"tardis_soda.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		groups = {not_in_creative_inventory = 1, tardis = 1},
		diggable = false,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_soda_locked", {
		description = "Tardis",
		tiles = {"tardis_soda.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		groups = {not_in_creative_inventory = 1, tardis_locked = 1},
		diggable = false
})
minetest.register_node("tardis_new:tardis_funky", {
		description = "Tardis",
		tiles = {"tardis_funky.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { 0.48, -0.5,-0.5,  0.5,  1.5, 0.5}, {-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5}, {-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5}, { -0.8,-0.6,-0.8,0.8,-0.48, 0.8} }},
		groups = {not_in_creative_inventory = 1, tardis = 1},
		diggable = false,
		light_source = 10,
		after_place_node = tardis_on_place,
		on_timer = tardis_timer
})
minetest.register_node("tardis_new:tardis_funky_locked", {
		description = "Tardis",
		tiles = {"tardis_funky.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		light_source = 10,
		groups = {not_in_creative_inventory = 1, tardis_locked = 1},
		diggable = false
})
