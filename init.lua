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
minetest.register_craftitem("tardis_new:biscut", {
		description = "Biscut",
		inventory_image = "tardis_biscut.png",
		on_use = minetest.item_eat(8)
})
minetest.register_craftitem("tardis_new:shard", {
		description = "Azbantium Shard",
		inventory_image = "tardis_shard.png",
})
minetest.register_craftitem("tardis_new:bar", {
		description = "Dalekanium Ingot",
		inventory_image = "tardis_bar.png",
})
minetest.register_node("tardis_new:azbantium", {
		description = "Azbantium",
		light_source = 4,
		tiles = {"tardis_azbantium.png"},
		groups = {azbantium = 1},
})
--dalek tools
minetest.register_tool("tardis_new:pick_dalek", {
	description = "Dalekanium Pickaxe",
	inventory_image = "tardis_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.0, [2]=0.5, [3]=0.25}, uses=60, maxlevel=3},
			azbantium = {times={[1]=25}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {pickaxe = 1}
})
minetest.register_tool("tardis_new:shovel_dalek", {
	description = "Dalekanium Shovel",
	inventory_image = "tardis_shovel.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.9, [2]=0.25, [3]=0.15}, uses=60, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1}
})
minetest.register_tool("tardis_new:axe_dalek", {
	description = "Dalekanium Axe",
	inventory_image = "tardis_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.45,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})
minetest.register_tool("tardis_new:sword_dalek", {
	description = "Dalekanium Sword",
	inventory_image = "tardis_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1, [2]=0.90, [3]=0.30}, uses=65, maxlevel=3},
		},
		damage_groups = {fleshy=10},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {sword = 1}
})
--sonic
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
		local controls = player:get_player_control()
		local node = minetest.get_node(pointed_thing.under)
		local meta = minetest.get_meta(pointed_thing.under)
		local select_pos = pointed_thing.under
		if controls.sneak then 
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
		else
			if id == meta:get_string("id") then
				if minetest.get_item_group(node.name, "tardis") == 1 then
					local look = data:get_string(id.."look")
					minetest.set_node(select_pos, {name = look.."_locked"})
					local ometa = minetest.get_meta(select_pos)
					ometa:set_string("id", id)
					minetest.chat_send_player(id, "Tardis Locked")
				end
				if minetest.get_item_group(node.name, "tardis_locked") == 1 then
					local look = data:get_string(id.."look")
					minetest.set_node(select_pos, {name = look})
					local timer = minetest.get_node_timer(select_pos)
					timer:start(0.2)
					local ometa = minetest.get_meta(select_pos)
					ometa:set_string("id", id)
					minetest.chat_send_player(id, "Tardis Unlocked")
				end
			end
			if node.name == "doors:door_steel_a" or node.name == "doors:door_steel_c" then
				doors.door_toggle(select_pos, nil, nil)
			end
			if node.name == "doors:trapdoor_steel" or node.name == "doors:trapdoor_steel_open" then
				doors.trapdoor_toggle(select_pos, nil, nil)
			end
			if node.name == "default:glass" then
				minetest.set_node(select_pos, {name = "default:obsidian_glass"})
			end
			if node.name == "default:dirt" then
				minetest.set_node(select_pos, {name = "default:dirt_with_grass"})
			end
			if node.name == "default:sand" then
				minetest.set_node(select_pos, {name = "default:silver_sand"})
			end
			if node.name == "default:obsidian" then
				minetest.set_node(select_pos, {name = "default:lava_source"} )
			end
			if minetest.get_item_group(node.name, "mesecon_conductor_craftable") == 1 then
				if mesecon.is_conductor_on(node) then
					mesecon.turnoff(select_pos, {0, 0, 0})
				else
					mesecon.turnon(select_pos, {0, 0, 0})
				end
			end
		end
	end
	if pointed_thing.type == "object" then
		local controls = player:get_player_control()
		local obj = pointed_thing.ref
		if controls.sneak then 
			local vpos = obj:get_pos()
			local pos = player:get_pos()
			if obj:is_player() then 
			obj:add_player_velocity({ x = 5*(vpos.x - pos.x), y = 5*(vpos.y - pos.y), z = 5*(vpos.z - pos.z)})
			else
			obj:add_velocity({ x = 5*(vpos.x - pos.x), y = 5*(vpos.y - pos.y), z = 5*(vpos.z - pos.z)})
			end
		else 
			minetest.chat_send_player(id, "Scanned subject had " .. obj:get_hp()/2 .. " hearts")
		end
	end
	minetest.sound_play("sonic_sound", { max_hear_distance = 10})
	itemstack:set_wear(itemstack:get_wear() + 500) return itemstack
end
})
--gaunlet
minetest.register_tool("tardis_new:gaunlet", {
	description = "Gaunlet of Rasilion",
	inventory_image = "tardis_glove.png",
	stack_max=1,
	on_use = function(itemstack, player, pointed_thing)
		if pointed_thing.type == "object" then
			local obj = pointed_thing.ref
			obj:punch(player, nil, {full_punch_interval = 0.1, damage_groups = {fleshy=300}}, nil)
			itemstack:set_wear(itemstack:get_wear() + 4000) return itemstack
		end
	end
})
--vortex manipulator
local function get_formspec_vortex()
    return "size[10,10]"..
		"field[1,1;8,1;teleport_x;X-Cord;0]"..
		"field[1,3;8,1;teleport_y;Y-Cord;0]"..
		"field[1,5;8,1;teleport_z;Z-Cord;0]"..
		"image_button_exit[1,6.5;3,3;dial_1.png;teleport; ;false;false;dial_2.png]"
end
minetest.register_tool("tardis_new:vortex", {
	description = "Vortex Manipulator",
	inventory_image = "tardis_vortex.png",
	stack_max=1,
	on_use = function(itemstack, player, pointed_thing)
		minetest.show_formspec(player:get_player_name(), "tardis_new:vortex_formspec", get_formspec_vortex() )
		itemstack:set_wear(itemstack:get_wear() + 3000) return itemstack
	end
})
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.teleport then
		local pos = minetest.string_to_pos(fields.teleport_x..","..fields.teleport_y..","..fields.teleport_z)
		player:set_pos(pos)
		player:set_hp(player:get_hp()-12)
	end
end)
--screen
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
--lab
local function get_formspec_lab()
    return "size[10,10]"..
		"image[4.5,2;1,1;tardis_arrow.png]"..
		"list[context;fuel;2,2;1,1;1]"..
		"list[context;dest;7,2;1,1;1]"..
		"list[current_player;main;1,5;8,4;]"
end
local function lab_recipe(item,result,pos, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if inv:contains_item("fuel", item) == true and inv:is_empty("dest") then
		inv:remove_item("fuel",item)
		local fuel_s = inv:get_stack("fuel", 2)
		inv:set_stack("fuel", 2, fuel_s)
		inv:set_stack("dest", 2, result)
		player:set_hp(player:get_hp()-4)
	end
end
local function lab_crafting(pos, player)
	lab_recipe("default:diamondblock","tardis_new:spacetime",pos, player)
	lab_recipe("default:mese_crystal","tardis_new:arton",pos, player)
	lab_recipe("default:diamond","tardis_new:shard",pos, player)
	lab_recipe("default:mese","default:diamond",pos, player)
	lab_recipe("default:copper_ingot","default:steel_ingot",pos, player)
	lab_recipe("default:coal_lump","default:tin_lump 2",pos, player)
	lab_recipe("default:steelblock","default:mese_crystal 3",pos, player)
	lab_recipe("default:dirt","default:coal_lump",pos, player)
end
minetest.register_node("tardis_new:lab", {
		description = "Gallifreyan Lab",
		tiles = {"tardis_lab.png"},
		groups = {cracky = 3},
		on_construct = function(pos, node)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_size("fuel", 2*1)
			inv:set_size("dest", 2*1)
			formspec = get_formspec_lab()
			meta:set_string("formspec", formspec)
		end,
		on_metadata_inventory_put = function(pos, listname, index, stack, player)
			lab_crafting(pos, player)
		end,
		on_metadata_inventory_take = function(pos, listname, index, stack, player)
			lab_crafting(pos, player)
		end
})
--chest
local function get_formspec_chest()
    return "size[24,15]"..
		"list[context;main;0,0.5;24,10;]"..
		"list[current_player;main;8,10.5;8,4;]"
end
minetest.register_node("tardis_new:chest", {
		description = "Gallifreyan Chest",
		tiles = {"tardis_chest_top.png", "tardis_chest_top.png", "tardis_chest_side.png", "tardis_chest_side.png", "tardis_chest_side.png", "tardis_chest_side.png"},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			meta:set_string("owner", placer:get_player_name())
			meta:set_string("infotext", "Chest owned by " .. placer:get_player_name())
			meta:set_string("formspec", get_formspec_chest())
			inv:set_size("main", 24*10)
		end,
		on_rightclick = function(pos, node, clicker, itemstack) 
			local meta = minetest.get_meta(pos)
			if clicker:get_player_name() == meta:get_string("owner") then meta:set_string("formspec", get_formspec_chest(pos)) else meta:set_string("formspec", "") end
		end
})
--extra
minetest.register_chatcommand("summon_tardis", {
	params = "",
	description = "Summons your Tardis to your location",
	privs = {bring = true},
	func = function(name)
    if data:get_string(name.."in_pos") == "" then return false, "tardis not found" else
		local player = minetest.get_player_by_name(name)
		local select_pos = player:get_pos()
		local out_pos = minetest.deserialize(data:get_string(name.."out_pos"))
		local look = data:get_string(name.."look")
		minetest.set_node(out_pos, {name = "air"})
		out_pos.x = select_pos.x
		out_pos.y = select_pos.y
		out_pos.z = select_pos.z		
		minetest.set_node(out_pos, {name=look})
		local ometa = minetest.get_meta(out_pos)
		ometa:set_string("id", name)
		data:set_string(name.."out_pos", minetest.serialize(out_pos))
		local timer = minetest.get_node_timer(out_pos)
		timer:start(0.5)
		minetest.chat_send_player(name, "Tardis Summoned")
	end
	end
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
		output = "tardis_new:vortex",
		recipe = {
			{"default:stick", "tardis_new:board", "default:stick"},
			{"default:mese_crystal", "tardis_new:arton", "default:mese_crystal"},
			{"tardis_new:shard", "default:tinblock", "tardis_new:shard"}
		}
})
minetest.register_craft({
		output = "tardis_new:gaunlet",
		recipe = {
			{"tardis_new:arton", "tardis_new:bar", "tardis_new:arton"},
			{"tardis_new:bar", "default:diamondblock", "tardis_new:bar"},
			{"tardis_new:bar", "", "tardis_new:bar"}
		}
})
minetest.register_craft({
		output = "tardis_new:chest",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "tardis_new:spacetime", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
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
		output = "tardis_new:light 4",
		recipe = {
			{"", "default:steel_ingot", ""},
			{"default:steel_ingot", "tardis_new:arton", "default:steel_ingot"},
			{"", "default:steel_ingot", ""}
		}
})
minetest.register_craft({
		output = "tardis_new:azbantium",
		recipe = {
			{"tardis_new:shard", "tardis_new:shard"},
			{"tardis_new:shard", "tardis_new:shard"}
		}
})
minetest.register_craft({
		type = "shapeless",
		output = "tardis_new:shard 4",
		recipe = {"tardis_new:azbantium"}
})
minetest.register_craft({
		output = "tardis_new:pick_dalek",
		recipe = {
			{"tardis_new:bar", "tardis_new:bar", "tardis_new:bar"},
			{"", "default:stick", ""},
			{"", "default:stick", ""}
		}
})
minetest.register_craft({
		output = "tardis_new:shovel_dalek",
		recipe = {
			{"tardis_new:bar"},
			{"default:stick"},
			{"default:stick"}
		}
})
minetest.register_craft({
		output = "tardis_new:axe_dalek",
		recipe = {
			{"tardis_new:bar", "tardis_new:bar", ""},
			{"tardis_new:bar", "default:stick", ""},
			{"", "default:stick", ""}
		}
})
minetest.register_craft({
		output = "tardis_new:sword_dalek",
		recipe = {
			{"tardis_new:bar"},
			{"tardis_new:bar"},
			{"default:stick"}
		}
})
minetest.register_craft({
		output = "tardis_new:bar",
		recipe = {
			{"default:obsidian", "default:steel_ingot", "default:obsidian"},
			{"tardis_new:shard", "default:gold_ingot", "tardis_new:shard"},
			{"default:obsidian", "default:steel_ingot", "default:obsidian"}
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