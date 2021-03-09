
--data = minetest.get_mod_storage()

minetest.register_node("tardis_new:in_door", {
		description = "Tardis Interior Door",
		tiles = {"inside_door.png"},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 },
			},
		},
		collision_box = {
		type = "fixed",
		fixed = {
			{ 0.48, -0.5,-0.5,  0.5,  1.5, 0.5},
			{-0.5 , -0.5, 0.48, 0.48, 1.5, 0.5},
			{-0.5,  -0.5,-0.5 ,-0.48, 1.5, 0.5},
			{ -0.7,-0.6,-0.7,0.7,-0.48, 0.7},
		}
	},
		sunlight_propagates = true,
		groups = {not_in_creative_inventory = 1},
		diggable = false,
		-- on_construct = function(pos)
			-- local timer = minetest.get_node_timer(pos)
			-- timer:start(0.2)
		-- end,
		on_timer = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.9)
		if objs[1] == nil then return true else
			if objs[1]:is_player() then
			
				local pmeta = objs[1]:get_meta()
				local meta = minetest.get_meta(pos)
				local id = meta:get_string("id")
				local go_pos = minetest.deserialize(data:get_string(id.."out_pos"))
				
				go_pos.z = go_pos.z-0.8
				objs[1]:set_look_horizontal( math.rad( 180 ))
				objs[1]:set_look_vertical( math.rad( 0 ))
				objs[1]:set_pos(go_pos)
				pmeta:set_string("in", "no")
				
				if pmeta:get_string("vortex") == "yes" then 
					go_pos.z = go_pos.z-1
					objs[1]:set_pos(go_pos)
					objs[1]:set_hp(0) 
				end
	
				minetest.after(1, function()
					local meta = minetest.get_meta(pos)
					local id = meta:get_string("id")
					local go_pos = minetest.deserialize(data:get_string(id.."out_pos"))
					local node = minetest.get_node(go_pos)
					local look = data:get_string(id.."look")
					minetest.set_node(go_pos, {name=look})
					local ometa = minetest.get_meta(go_pos)
					ometa:set_string("id", id)
					local timer = minetest.get_node_timer(go_pos)
					timer:start(0.2)
				end)
			end
		end
		return true
	end
})
minetest.register_node("tardis_new:wall", {
		description = "Tardis Wall (non-craftable)",
		tiles = {"tardis_wall.png"},
		diggable = false,
		groups = { not_in_creative_inventory = 1},
})
minetest.register_node("tardis_new:wall_craftable", {
		description = "Tardis Wall",
		tiles = {"tardis_wall.png"},
		groups = {cracky = 1},
})
minetest.register_node("tardis_new:stone", {
		description = "Stone",
		tiles = {"default_stone.png"},
		diggable = false,
		groups = { not_in_creative_inventory = 1},
})
minetest.register_node("tardis_new:expand_1", {
		description = "Expanding Wall Segment (1)",
		tiles = {"tardis_expand.png"},
		diggable = false,
		groups = { not_in_creative_inventory = 0},
		on_rightclick = function(pos, node, clicker, itemstack)
		local pmeta = clicker:get_meta()
		local id = pmeta:get_string("id")
		--if data:get_int(id.."power") < 10 then minetest.chat_send_player(name, "You Need 10 Power") else
			pos.y = pos.y-3
			pos.x = pos.x-3
			minetest.place_schematic(pos, minetest.get_modpath("tardis_new") .. "/schems/hallway_1.mts")
		--end
		end
})
minetest.register_node("tardis_new:expand_2", {
		description = "Expanding Wall Segment (2)",
		tiles = {"tardis_expand.png"},
		diggable = false,
		groups = {cracky = 3, not_in_creative_inventory = 0},
})
minetest.register_node("tardis_new:expand_3", {
		description = "Expanding Wall Segment (3)",
		tiles = {"tardis_expand.png"},
		diggable = false,
		groups = { not_in_creative_inventory = 0},
		on_rightclick = function(pos, node, clicker, itemstack)
		local pmeta = clicker:get_meta()
		local id = pmeta:get_string("id")
		--if data:get_int(id.."power") < 10 then minetest.chat_send_player(name, "You Need 10 Power") else
			pos.y = pos.y-3
			pos.x = pos.x-3
			pos.z = pos.z-14
			minetest.place_schematic(pos, minetest.get_modpath("tardis_new") .. "/schems/hallway_3.mts")
		--end
		end
})
minetest.register_node("tardis_new:expand_4", {
		description = "Expanding Wall Segment (4)",
		tiles = {"tardis_expand.png"},
		diggable = false,
		groups = { not_in_creative_inventory = 0},
})