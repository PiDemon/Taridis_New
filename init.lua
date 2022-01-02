local modpath = minetest.get_modpath("aether")
dofile(modpath .. "/pots.lua")
dofile(modpath .. "/pots2.lua")
dofile(modpath .. "/crafting.lua")
dofile(modpath .. "/aether.lua")
--get all craftable items 
craftable_items = {}
craftable_number = 0
minetest.register_on_mods_loaded(function()
	for item, def in pairs(minetest.registered_items) do
		if minetest.get_craft_recipe(item).items ~= nil then
		    craftable_items[item] = def
			craftable_number = craftable_number+1
		end
	end
end)
--functions
local function get_formspec_aether_list(metap)
	craftable_item_string = ""
	aether_cycle_number = 0
	finished = ""
	for item, def in pairs(craftable_items) do
		if metap:get_string(item) == "" then
			craftable_item_string = craftable_item_string.."label[0.5,"..aether_cycle_number..";"..def.description.."]"
			aether_cycle_number = aether_cycle_number+1
		end
	end		
    return "size[12,12]"..
		"label[0.5,0.5;Items needed:]"..
		"list[context;product;7.8,2.8;1,1;1]"..
		"animated_image[7,2;3,3;core_image;aether_reactor.png;10;500;1]"..
		"label[7.6,5;"..craftable_number-aether_cycle_number.." out of "..craftable_number.."]"..
		"scrollbar[0.1,1.5;0.5,10;vertical;scrolly;100]"..
		"scroll_container[0.5,2;8,12;scrolly;vertical]"..
		craftable_item_string..
		"scroll_container_end[]"..
		"list[current_player;main;4,8;8,4;]"
end
local function finished_check(metap)
	aether_cycle_number = 0
	for item, def in pairs(craftable_items) do
		if metap:get_string(item) == "" then
			aether_cycle_number = aether_cycle_number+1
		end
	end		
	if aether_cycle_number == 0 then 
		return "true"
	else
		return "false" 
	end
end
local function particle(pos)
			minetest.add_particlespawner({
				amount = 50,
				time = 2,
				minpos = {x=pos.x-1, y=pos.y-1, z=pos.z-1},
				maxpos = {x=pos.x+1, y=pos.y+1, z=pos.z+1},
				minvel = {x=-0.5, y=-0.5, z=-0.5},
				maxvel = {x=0.5, y=0.5, z=0.5},
				minexptime=3,
				maxexptime=5,
				minsize=1,
				maxsize=6,
				glow = 10,
				texture = "aether_particle.png",
			})
end
--items
minetest.register_craftitem("aether:diamond", {
		description = "Purified Diamond",
		inventory_image = "aether_diamond.png",
})
minetest.register_craftitem("aether:diamond_fire", {
		description = "Fire Infused Diamond",
		inventory_image = "aether_diamond.png^[colorize:#d50000:70",
})
minetest.register_craftitem("aether:diamond_earth", {
		description = "Earth Infused Diamond",
		inventory_image = "aether_diamond.png^[colorize:#ffeb3b:70",
})
minetest.register_craftitem("aether:diamond_air", {
		description = "Air Infused Diamond",
		inventory_image = "aether_diamond.png^[colorize:#4caf4f:70",
})
minetest.register_craftitem("aether:diamond_water", {
		description = "Water Infused Diamond",
		inventory_image = "aether_diamond.png^[colorize:#2195f3:70",
})
minetest.register_craftitem("aether:mese", {
		description = "Purified Mese",
		inventory_image = "aether_mese.png",
})
minetest.register_craftitem("aether:essence", {
		description = "Essence of Aether",
		inventory_image = "aether_essence.png",
})
--reactor
minetest.register_node("aether:reactor_active", {
		description = "Aether Reactor Core (active)",
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 5,
		tiles = {"aether_top.png", 
				"aether_top.png",
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2}},
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2}},
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2}},
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2}},
		},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{5/16, 0.5, 5/16, 0.5, -0.5, 0.5},
				{-5/16, 0.5, 5/16, -0.5, -0.5, 0.5},
				{-5/16, 0.5, -5/16, -0.5, -0.5, -0.5},
				{5/16, 0.5, -5/16, 0.5, -0.5, -0.5},
				{-0.5, 0.5, -0.5, 0.5, 5/16, 0.5},
				{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
				{2/16, 2/16, 2/16, -2/16, -2/16, -2/16},
			},
		},
		groups = {cracky = 2},
		drop = "aether:reactor",
		on_construct = function(pos, node)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("product", 2*1)
			meta:set_string("formspec", get_formspec_aether_list(minetest.get_meta(pos)))
			--make it a little easier
			meta:set_string("aether:reactor", "true")
			meta:set_string("aether:fire_stab", "true")
			meta:set_string("aether:water_stab", "true")
			meta:set_string("aether:air_stab", "true")
			meta:set_string("aether:earth_stab", "true")
			meta:set_string("aether:essence", "true")
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local aether_stack = inv:get_stack("product", 2)
			meta:set_string(aether_stack:get_name(), "true")
			inv:set_stack("product", 2, "")
			meta:set_string("formspec", get_formspec_aether_list(minetest.get_meta(pos)))
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local meta = minetest.get_meta(pos)
			if finished_check(minetest.get_meta(pos)) == "true" then
				pos.x = pos.x-1
				if minetest.get_node(pos).name ~= "aether:beam" then return end
				pos.x = pos.x+2
				if minetest.get_node(pos).name ~= "aether:beam" then return end
				pos.x = pos.x-1
				pos.z=pos.z-1
				if minetest.get_node(pos).name ~= "aether:beam" then return end
				pos.z=pos.z+2
				if minetest.get_node(pos).name ~= "aether:beam" then return end
				pos.z=pos.z-1
				if itemstack:get_name() == "aether:mese" then 
					meta:set_string("formspec", "")
					minetest.add_particlespawner({
						amount = 400,
						time = 10,
						minpos = {x=pos.x-0.5, y=pos.y-0.5, z=pos.z-0.5},
						maxpos = {x=pos.x+0.5, y=pos.y+30, z=pos.z+0.5},
						minvel = {x=0, y=1, z=0},
						maxvel = {x=0, y=3, z=0},
						minexptime=5,
						maxexptime=10,
						minsize=1,
						maxsize=10,
						glow = 14,
						texture = "aether_particle.png",
					})
					clicker:set_breath(0)
					minetest.set_timeofday(1)
					minetest.after(1, function() minetest.set_timeofday(0.5) end)
					minetest.after(2, function() minetest.set_timeofday(1) end)
					minetest.after(3, function() minetest.set_timeofday(0.5) end)
					minetest.after(4, function() minetest.set_timeofday(1) clicker:set_physics_override({gravity = -0.5}) end)
					minetest.after(5, function() minetest.set_timeofday(0.5) end)
					minetest.after(7, function() minetest.set_timeofday(1) end)
					minetest.after(8, function() minetest.set_timeofday(0.5) end)
					minetest.after(9, function() minetest.set_timeofday(1) clicker:set_physics_override({gravity = 1}) end)
					minetest.after(10, function() clicker:set_stars({star_color = "#ff0000", scale = 10}) end)
					minetest.after(10.5, function() clicker:set_stars({star_color = "#ffff00", scale = 10}) end)
					minetest.after(11, function() clicker:set_stars({star_color = "#8cff00", scale = 10}) end)
					minetest.after(11.5, function() clicker:set_stars({star_color = "#ff8400", scale = 10}) end)
					minetest.after(12, function() clicker:set_stars({star_color = "#ff0000", scale = 10}) end)
					minetest.after(12.5, function() clicker:set_stars({star_color = "#ffff00", scale = 10}) end)
					minetest.after(13, function() clicker:set_stars({star_color = "#8cff00", scale = 10}) end)
					minetest.after(13.5, function() clicker:set_stars({star_color = "#ff8400", scale = 10}) end)
					minetest.after(14, function() clicker:set_stars({star_color = "#ebebff69", scale = 1}) end)
					minetest.after(15, function() 
					minetest.add_particlespawner({
						amount = 1000,
						time = 5,
						minpos = {x=pos.x-5, y=pos.y-5, z=pos.z-5},
						maxpos = {x=pos.x+5, y=pos.y+5, z=pos.z+5},
						minvel = {x=-2, y=-2, z=-2},
						maxvel = {x=2, y=2, z=2},
						minexptime=5,
						maxexptime=10,
						minsize=20,
						maxsize=50,
						glow = 14,
						texture = "aether_particle.png",
					})
					end)
					minetest.after(16, function(pos) 
						minetest.set_node(pos, {name = "aether:aether"}) 
						pos.z=pos.z-1
						minetest.set_node(pos, {name = "air"}) 
						pos.z=pos.z-1
						minetest.set_node(pos, {name = "air"}) 
						pos.z=pos.z-1
						minetest.set_node(pos, {name = "air"}) 
						pos.z=pos.z-1
						minetest.set_node(pos, {name = "default:lava_source"}) 
						pos.z=pos.z+5
						minetest.set_node(pos, {name = "air"}) 
						pos.z=pos.z+1
						minetest.set_node(pos, {name = "air"}) 
						pos.z=pos.z+1
						minetest.set_node(pos, {name = "air"}) 
						pos.z=pos.z+1
						minetest.set_node(pos, {name = "default:lava_source"}) 
						pos.z=pos.z-4
						pos.x=pos.x-1
						minetest.set_node(pos, {name = "air"}) 
						pos.x=pos.x-1
						minetest.set_node(pos, {name = "air"}) 
						pos.x=pos.x-1
						minetest.set_node(pos, {name = "air"}) 
						pos.x=pos.x-1
						minetest.set_node(pos, {name = "default:lava_source"}) 
						pos.x=pos.x+5
						minetest.set_node(pos, {name = "air"}) 
						pos.x=pos.x+1
						minetest.set_node(pos, {name = "air"}) 
						pos.x=pos.x+1
						minetest.set_node(pos, {name = "air"}) 
						pos.x=pos.x+1
						minetest.set_node(pos, {name = "default:lava_source"}) 
					end, pos)
				end
			end
		end
})
minetest.register_node("aether:reactor", {
		description = "Aether Reactor Core",
		paramtype = "light",
		sunlight_propagates = true,
		tiles = {"aether_top.png", 
				"aether_top.png",
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.5}},
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.5}},
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.5}},
				{name = "aether_reactor.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.5}},
		},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{5/16, 0.5, 5/16, 0.5, -0.5, 0.5},
				{-5/16, 0.5, 5/16, -0.5, -0.5, 0.5},
				{-5/16, 0.5, -5/16, -0.5, -0.5, -0.5},
				{5/16, 0.5, -5/16, 0.5, -0.5, -0.5},
				{-0.5, 0.5, -0.5, 0.5, 5/16, 0.5},
				{-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
			},
		},
		groups = {cracky = 2},
		on_rightclick = function(pos, node, clicker, itemstack)
			if itemstack:get_name() == "aether:essence" then 
				itemstack:take_item()
				minetest.set_node(pos, {name = "aether:reactor_active"}) 
				particle(pos)
			end
		end
})
--stabilizers
minetest.register_node("aether:fire_stab", {
		description = "Aether Reactor Fire Stabilzer",
		paramtype = "light",
		sunlight_propagates = true,
		tiles = {"aether_fire.png", 
				"aether_top.png",
				"aether_feed.png",
				"aether_top.png",
				"aether_top.png",
				"aether_top.png",
		},
		groups = {cracky = 2},
		on_rightclick = function(pos, node, clicker, itemstack)
			pos.x = pos.x+4
			local node = minetest.get_node(pos)
			local targetmeta = minetest.get_meta(pos)
			if node.name == "aether:reactor_active" then 
				if itemstack:get_name() == "aether:mese" then
					itemstack:take_item()
					pos.x = pos.x-1
					minetest.set_node(pos, {name ="aether:beam"})
					pos.x = pos.x-1
					minetest.set_node(pos, {name ="aether:beam"})
					pos.x = pos.x-1
					minetest.set_node(pos, {name ="aether:beam"})
					particle(pos)
				end
			end
		end,
		on_destruct = function(pos)
			pos.x = pos.x+1
			if minetest.get_node(pos).name == "aether:beam" then
			minetest.set_node(pos, {name = "air"})
			pos.x = pos.x+1
			minetest.set_node(pos, {name = "air"})
			pos.x = pos.x+1
			minetest.set_node(pos, {name = "air"})
			end
		end
})
minetest.register_node("aether:air_stab", {
		description = "Aether Reactor Air Stabilzer",
		paramtype = "light",
		sunlight_propagates = true,
		tiles = {"aether_air.png", 
				"aether_top.png",
				"aether_top.png",
				"aether_feed.png",
				"aether_top.png",
				"aether_top.png",
		},
		groups = {cracky = 2},
		on_rightclick = function(pos, node, clicker, itemstack)
			pos.x = pos.x-4
			local node = minetest.get_node(pos)
			local targetmeta = minetest.get_meta(pos)
			if node.name == "aether:reactor_active" then 
				if itemstack:get_name() == "aether:mese" then
					itemstack:take_item()
					pos.x = pos.x+1
					minetest.set_node(pos, {name ="aether:beam"})
					pos.x = pos.x+1
					minetest.set_node(pos, {name ="aether:beam"})
					pos.x = pos.x+1
					minetest.set_node(pos, {name ="aether:beam"})
				particle(pos)
				end
			end
		end,
		on_destruct = function(pos)
			pos.x = pos.x-1
			if minetest.get_node(pos).name == "aether:beam" then
			minetest.set_node(pos, {name = "air"})
			pos.x = pos.x-1
			minetest.set_node(pos, {name = "air"})
			pos.x = pos.x-1
			minetest.set_node(pos, {name = "air"})
			end
		end
})
minetest.register_node("aether:water_stab", {
		description = "Aether Reactor Water Stabilzer",
		paramtype = "light",
		sunlight_propagates = true,
		tiles = {"aether_water.png", 
				"aether_top.png",
				"aether_top.png",
				"aether_top.png",
				"aether_feed.png",
				"aether_top.png",
		},
		groups = {cracky = 2},
		on_rightclick = function(pos, node, clicker, itemstack)
			pos.z = pos.z+4
			local node = minetest.get_node(pos)
			local targetmeta = minetest.get_meta(pos)
			if node.name == "aether:reactor_active" then 
				if itemstack:get_name() == "aether:mese" then
					itemstack:take_item()
					pos.z = pos.z-1
					minetest.set_node(pos, {name = "aether:beam"})
					pos.z = pos.z-1
					minetest.set_node(pos, {name ="aether:beam"})
					pos.z = pos.z-1
					minetest.set_node(pos, {name ="aether:beam"})
					particle(pos)
				end
			end
		end,
		on_destruct = function(pos)
			pos.z = pos.z+1
			if minetest.get_node(pos).name == "aether:beam" then
			minetest.set_node(pos, {name = "air"})
			pos.z = pos.z+1
			minetest.set_node(pos, {name = "air"})
			pos.z = pos.z+1
			minetest.set_node(pos, {name = "air"})
			end
		end
})
minetest.register_node("aether:earth_stab", {
		description = "Aether Reactor Earth Stabilzer",
		paramtype = "light",
		sunlight_propagates = true,
		tiles = {"aether_earth.png", 
				"aether_top.png",
				"aether_top.png",
				"aether_top.png",
				"aether_top.png",
				"aether_feed.png",
		},
		groups = {cracky = 2},
		on_rightclick = function(pos, node, clicker, itemstack)
			pos.z = pos.z-4
			local node = minetest.get_node(pos)
			local targetmeta = minetest.get_meta(pos)
			if node.name == "aether:reactor_active" then 
				if itemstack:get_name() == "aether:mese" then
					itemstack:take_item()
					pos.z = pos.z+1
					minetest.set_node(pos, {name = "aether:beam"})
					pos.z = pos.z+1
					minetest.set_node(pos, {name = "aether:beam"})
					pos.z = pos.z+1
					minetest.set_node(pos, {name = "aether:beam"})
					particle(pos)
				end
			end
		end,
		on_destruct = function(pos)
			pos.z = pos.z-1
			if minetest.get_node(pos).name == "aether:beam" then
			minetest.set_node(pos, {name = "air"})
			pos.z = pos.z-1
			minetest.set_node(pos, {name = "air"})
			pos.z = pos.z-1
			minetest.set_node(pos, {name = "air"})
			end
		end
})
minetest.register_node("aether:beam", {
	description = "Beam",
	tiles = {{name = "aether_beam.png",animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 0.5}}},
	drawtype = "glasslike",
	sunlight_propagates = true,
	walkable = false,
	digable = false,
	pointable = false,
	buildable_to = false,
	damage_per_second = 2,
	drop = "",
	paramtype = "light",
	post_effect_color = {a=180, r=40, g=40, b=130},
	light_source = 5,
	alpha = 200,
	groups = {not_in_creative_inventory=1}
})
--elemental fuser
local function get_formspec_aether_lab()
    return "size[10,10]"..
		"image[2.5,3;1,1;sfinv_crafting_arrow.png]"..
		"image[6.5,3;1,1;sfinv_crafting_arrow.png^[transformR180]"..
		"image[4.5,1.5;1,1;sfinv_crafting_arrow.png^[transformR270]"..
		"image[4.5,4.5;1,1;sfinv_crafting_arrow.png^[transformR90]"..
		"list[context;one;1.5,3;1,1;1]"..
		"list[context;two;7.5,3;1,1;1]"..
		"list[context;three;4.5,0.5;1,1;1]"..
		"list[context;four;4.5,5.5;1,1;1]"..
		"list[context;product;4.5,3;1,1;1]"..
		"list[context;mese;0.1,0.1;1,1;1]"..
		"image[4.5,3;1,1;aether_face.png]"..
		"image[0.1,0.1;1,1;aether_face2.png]"..
		"list[current_player;main;1,7;8,3;]"
end
local function recipe(one,two,three,four,pos,result)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:contains_item("product", "aether:diamond") == true and inv:contains_item("mese", "aether:mese") == true and inv:contains_item("one", one) == true and inv:contains_item("two", two) == true and inv:contains_item("three", three) == true and inv:contains_item("four", four) == true then 
			inv:remove_item("one", one)
			inv:remove_item("two", two)
			inv:remove_item("three", three)
			inv:remove_item("four", four)
			inv:remove_item("mese", "aether:mese")
			local sone = inv:get_stack("one", 2)
			local stwo = inv:get_stack("two", 2)
			local sthree = inv:get_stack("three", 2)
			local sfour = inv:get_stack("four", 2)
			local smese = inv:get_stack("mese", 2)
			inv:set_stack("product", 2, result)
			inv:set_stack("one", 2, sone)
			inv:set_stack("two", 2, stwo)
			inv:set_stack("three", 2, sthree)
			inv:set_stack("four", 2, sfour)
			inv:set_stack("mese", 2, smese)
			particle(pos)
		end
end
local function work(pos)
	recipe("default:ice 50","bucket:bucket_water 50","default:coral_skeleton 50","default:snowblock 50",pos,"aether:diamond_water")
	recipe("default:coalblock 50","bucket:bucket_lava 50","default:flint 50","default:obsidian 50",pos,"aether:diamond_fire")
	recipe("default:silver_sandstone 50","default:steelblock 50","default:dirt 50","default:bronzeblock 50",pos,"aether:diamond_earth")
	recipe("default:tree 50","default:goldblock 50","default:papyrus 50","default:cactus 50",pos,"aether:diamond_air")
end
minetest.register_node("aether:fuser", {
		description = "Elemental Fuser",
		tiles = {"aether_fuser_top.png", "aether_fuser_top.png", "aether_fuser_side.png", "aether_fuser_side.png", "aether_fuser_side.png", "aether_fuser_front.png"},
		paramtype2 = "facedir",
		groups = {cracky = 2},
		on_construct = function(pos, node)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("one", 2*1)
			inv:set_size("two", 2*1)
			inv:set_size("three", 2*1)
			inv:set_size("four", 2*1)
			inv:set_size("product", 2*1)
			inv:set_size("mese", 2*1)
			meta:set_string("formspec", get_formspec_aether_lab())
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			work(pos)
		end
})