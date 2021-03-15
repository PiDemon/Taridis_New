
--formspecs
local function get_formspec_y(add, out)
	local dest = "Y destination: " .. add
	local cur = "Current Y postion: " .. out
    return "size[10,10]"..
		"image_button[0,6;4,4;handel_1.png;up; ;false;false;handel_2.png]"..
		"image_button[6,6;4,4;handel_1.png;down; ;false;false;handel_2.png]"..
		"label[1,1;"..minetest.formspec_escape(dest).."]"..
		"label[1,2.5;"..minetest.formspec_escape(cur).."]"..
		"tooltip[up;Increase]"..
		"tooltip[down;Decrease]"
end
local function get_formspec_z(add, out)
	local dest = "Z destination: " .. add
	local cur = "Current Z postion: " .. out
    return "size[10,10]"..
		"image_button[0,6;4,4;handel_1.png;right; ;false;false;handel_2.png]"..
		"image_button[6,6;4,4;handel_1.png;left; ;false;false;handel_2.png]"..
		"label[1,1;"..minetest.formspec_escape(dest).."]"..
		"label[1,2.5;"..minetest.formspec_escape(cur).."]"..
		"tooltip[right;Increase]"..
		"tooltip[left;Decrease]"
end
local function get_formspec_x(add, out)
	local dest = "X destination: " .. add
	local cur = "Current X postion: " .. out
    return "size[10,10]"..
		"image_button[0,6;4,4;handel_1.png;foward; ;false;false;handel_2.png]"..
		"image_button[6,6;4,4;handel_1.png;back; ;false;false;handel_2.png]"..
		"label[1,1;"..minetest.formspec_escape(dest).."]"..
		"label[1,2.5;"..minetest.formspec_escape(cur).."]"..
		"tooltip[foward;Increase]"..
		"tooltip[back;Decrease]"
end
local function get_formspec_w()
    return "size[10,10]"..
		--"button[1,3;5,1;go;Go]"
		"image_button_exit[3,3;4,4;lever_1.png;go; ;false;false;lever_2.png]"
end
local function get_formspec_r(set)
	local power = "Power Left: " .. set .. " out of 10"
    return "size[10,10]"..
		"label[1,1;"..minetest.formspec_escape(power).."]"
end
local function get_formspec_f(set)
	local factor = "Travel Factor: " .. set
    return "size[10,10]"..
		"label[1,1;"..minetest.formspec_escape(factor).."]"..
		"image_button[1,5;2,2;switch_1.png;one; ;false;false;switch_2.png]"..
		"image_button[2.5,5;2,2;switch_1.png;ten; ;false;false;switch_2.png]"..
		"image_button[4,5;2,2;switch_1.png;hundren; ;false;false;switch_2.png]"..
		"image_button[5.5,5;2,2;switch_1.png;thosand; ;false;false;switch_2.png]"..
		"tooltip[one;1]"..
		"tooltip[ten;10]"..
		"tooltip[hundren;100]"..
		"tooltip[thosand;1000]"
end
local function get_formspec_s()
    return "size[10,10]"..
		"field[1,9;8,1;locate;;type name here... ]"..
		"image_button[1,1;2,2;switch_1.png;pick; ;false;false;switch_2.png]"..
		"image_button[2.5,1;2,2;switch_1.png;heal; ;false;false;switch_2.png]"..
		"image_button[4,1;2,2;switch_1.png;axe; ;false;false;switch_2.png]"..
		"image_button[1,3;2,2;switch_1.png;shovel; ;false;false;switch_2.png]"..
		"image_button[2.5,3;2,2;switch_1.png;food; ;false;false;switch_2.png]"..
		"image_button[4,3;2,2;switch_1.png;attack; ;false;false;switch_2.png]"..
		"image_button[6,1;4,4;handel_1.png;sonic; ;false;false;handel_2.png]"..
		"image_button_exit[0.5,5.5;3,3;dial_1.png;submit; ;false;false;dial_2.png]"..
		"image_button[3.5,5.5;3,3;dial_1.png;scan; ;false;false;dial_2.png]"..
		"tooltip[sonic;Create Sonic Screwdriver]"..
		"tooltip[heal;Heal Me]"..
		"tooltip[axe;Create a Axe]"..
		"tooltip[scan;Scan Named Player]"..
		"tooltip[submit;Locate Named Player]"..
		"tooltip[food;Create a Biscut]"..
		"tooltip[shovel;Create a Shovel]"..
		"tooltip[attack;Activate Weapons]"..
		"tooltip[pick;Create a Pickaxe]"
end
local function get_formspec_c(set)
	local cur = set
    return "size[10,10]"..
		"label[1,1;Change Exterior Shell: ]"..
		"item_image[6,0.5;3,3;"..minetest.formspec_escape(cur).."]"..
		"button[1,3;3,3;old;Default]"..
		"button[1,4;3,3;pink;Pink]"..
		"button[1,5;3,3;blue;Blue]"..
		"button[1,6;3,3;yellow;Yellow]"..
		"button[1,7;3,3;stone;Stone]"..
		"button[5,3;3,3;empty;Invisible]"..
		"button[5,4;3,3;cool;Classic]"..
		"button[5,5;3,3;leave;Leaves]"..
		"button[5,6;3,3;soda;Soda]"..
		"button[5,7;3,3;funky;Funky]"	
end
local function get_formspec_o()
    return "size[10,10]"..
		"image_button[1,1;2,2;dial_1.png;set_one; ;false;false;dial_2.png]"..
		"image_button[1,4;2,2;dial_1.png;set_two; ;false;false;dial_2.png]"..
		"image_button[1,7;2,2;dial_1.png;set_three; ;false;false;dial_2.png]"..
		"image_button_exit[4.5,2;2,2;switch_1.png;use_one; ;false;false;switch_2.png]"..
		"image_button_exit[6,2;2,2;switch_1.png;use_two; ;false;false;switch_2.png]"..
		"image_button_exit[7.5,2;2,2;switch_1.png;use_three; ;false;false;switch_2.png]"..
		"tooltip[set_one;Set Waypoint 1]"..
		"tooltip[use_one;Use Waypoint 1]"..
		"tooltip[set_two;Set Waypoint 2]"..
		"tooltip[use_two;Use Waypoint 2]"..
		"tooltip[set_three;Set Waypoint 3]"..
		"tooltip[use_three;Use Waypoint 3]"
end
local general_functions = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local id = meta:get_string("id")
	local name = sender:get_player_name()
	local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
	local factor = data:get_int(id.."factor")
	local inv = sender:get_inventory()
	if fields.up then
		meta:set_string("formspec", get_formspec_y(data:get_int(id.."y_dest")+factor, out_pos.y))
		data:set_int(id.."y_dest", data:get_int(id.."y_dest")+factor)
	end
	if fields.down then
		meta:set_string("formspec", get_formspec_y(data:get_int(id.."y_dest")-factor, out_pos.y))
		data:set_int(id.."y_dest", data:get_int(id.."y_dest")-factor)
	end
	if fields.right then
		meta:set_string("formspec", get_formspec_z(data:get_int(id.."z_dest")+factor, out_pos.z))
		data:set_int(id.."z_dest", data:get_int(id.."z_dest")+factor)
	end
	if fields.left then
		meta:set_string("formspec", get_formspec_z(data:get_int(id.."z_dest")-factor, out_pos.z))
		data:set_int(id.."z_dest", data:get_int(id.."z_dest")-factor)
	end
	if fields.foward then
		meta:set_string("formspec", get_formspec_x(data:get_int(id.."x_dest")+factor, out_pos.x))
		data:set_int(id.."x_dest", data:get_int(id.."x_dest")+factor)
	end
	if fields.back then
		meta:set_string("formspec", get_formspec_x(data:get_int(id.."x_dest")-factor, out_pos.x))
		data:set_int(id.."x_dest", data:get_int(id.."x_dest")-factor)
	end
	if fields.one then
		meta:set_string("formspec", get_formspec_f(1))
		data:set_int(id.."factor", 1)
	end
	if fields.ten then
		meta:set_string("formspec", get_formspec_f(10))
		data:set_int(id.."factor", 10)
	end
	if fields.hundren then
		meta:set_string("formspec", get_formspec_f(100))
		data:set_int(id.."factor", 100)
	end 
	if fields.thosand then
		meta:set_string("formspec", get_formspec_f(1000))
		data:set_int(id.."factor", 1000)
	end 
	--extra functions
	if fields.submit then
		if data:get_int(id.."power") < 2 then minetest.chat_send_player(name, "You Need 2 Power") else
			local victim = minetest.get_player_by_name(fields.locate)
			if not victim then minetest.chat_send_player(name, fields.locate .. " not found") else 
				local vpos = victim:get_pos()
				data:set_int(id.."x_dest", vpos.x) 
				data:set_int(id.."y_dest", vpos.y+1)
				data:set_int(id.."z_dest", vpos.z)
				minetest.chat_send_player(name, "Player Located")
				data:set_int(id.."power", data:get_string(id.."power")-2)
			end
		end
	end 
	if fields.sonic then
		if data:get_int(id.."power") < 5 then minetest.chat_send_player(name, "You Need 5 Power") else
			pos.y = pos.y+1
			minetest.add_item(pos, "tardis_new:sonic")
			data:set_int(id.."power", data:get_string(id.."power")-5)
		end
	end 
	if fields.heal then
		if data:get_int(id.."power") < 3 then minetest.chat_send_player(name, "You Need 3 Power") else
			sender:set_hp(40)
			data:set_int(id.."power", data:get_string(id.."power")-3)
		end
	end 
	if fields.scan then
		if data:get_int(id.."power") < 1 then minetest.chat_send_player(name, "You Need 1 Power") else
			local victim = minetest.get_player_by_name(fields.locate)
			if not victim then minetest.chat_send_player(name, fields.locate .. " not found") else 
				local item = victim:get_wielded_item()
				local item_name = item:get_name()
				if item:get_name() == "" then item_name = "nothing" end
				minetest.chat_send_player(name, fields.locate .. " is holding " .. item_name .. " and has " .. victim:get_hp()/2 .. " hearts") 
				data:set_int(id.."power", data:get_string(id.."power")-1)
			end
		end
	end 
	if fields.pick then
		if data:get_int(id.."power") < 5 then minetest.chat_send_player(name, "You Need 5 Power") else
			pos.y = pos.y+1
			minetest.add_item(pos, "default:pick_diamond")
			data:set_int(id.."power", data:get_string(id.."power")-5)
		end
	end 
	if fields.axe then
		if data:get_int(id.."power") < 5 then minetest.chat_send_player(name, "You Need 5 Power") else
			pos.y = pos.y+1
			minetest.add_item(pos, "default:axe_diamond")
			data:set_int(id.."power", data:get_string(id.."power")-5)
		end
	end 
	if fields.shovel then
		if data:get_int(id.."power") < 5 then minetest.chat_send_player(name, "You Need 5 Power") else
			pos.y = pos.y+1
			minetest.add_item(pos, "default:shovel_diamond")
			data:set_int(id.."power", data:get_string(id.."power")-5)
		end
	end 
	if fields.food then
		if data:get_int(id.."power") < 1 then minetest.chat_send_player(name, "You Need 1 Power") else
			pos.y = pos.y+1
			minetest.add_item(pos, "tardis_new:biscut")
			data:set_int(id.."power", data:get_string(id.."power")-1)
		end
	end 
	if fields.attack then
		if data:get_int(id.."power") < 1 then minetest.chat_send_player(name, "You Need 1 Power") else
			local objs = minetest.get_objects_inside_radius(out_pos, 10)
			if objs[1] == nil then minetest.chat_send_player(name, "No players in range of Tardis") else
				if objs[1]:is_player() then
					objs[1]:set_hp(objs[1]:get_hp()-8)
					minetest.chat_send_player(name, objs[1]:get_player_name().." was attacked" )
					data:set_int(id.."power", data:get_string(id.."power")-1)
				end			
			end
		end
	end
end
local travel_to_location = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local id = meta:get_string("id")
	local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
	local look = data:get_string(id.."look")
	local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
	local rmeta = minetest.get_meta(r_pos)
	local style = rmeta:get_string("style")
	local go_pos = { x = data:get_int(id.."x_dest"), y = data:get_int(id.."y_dest"), z = data:get_int(id.."z_dest") }
	local pmeta = sender:get_meta()
	local name = sender:get_player_name()
	if fields.go then
		if data:get_int(id.."power") == 0 then minetest.chat_send_player(name, "No Power Left!") else --power?
			local node = minetest.get_node(go_pos)
			if node.name == "ignore" then minetest.get_voxel_manip():read_from_map(out_pos, out_pos) local node = minetest.get_node(out_pos) end
			if node.name == "ignore" or node.name == "air" then --are you trying to land on a block?
				if minetest.is_protected(go_pos, name) then minetest.chat_send_player(name, "You don't have access to this area!") else --protected?
					if r_pos.x+100 > go_pos.x and r_pos.x-100 < go_pos.x and r_pos.z+100 > go_pos.z and r_pos.z-100 < go_pos.z and r_pos.y+100 > go_pos.y and r_pos.y-100 < go_pos.y then minetest.chat_send_player(name, "Your Tardis does not want to land at this location") else --stay away from consle room!
						if 30900 > go_pos.x and -30900 < go_pos.x and 30900 > go_pos.z and -30900 < go_pos.z and 30900 > go_pos.z and -30900 < go_pos.z then --world limits
							minetest.swap_node(r_pos, {name = "tardis_new:rotor_active"..style })
							pmeta:set_string("vortex", "yes")
							local effect = minetest.sound_play("tardis_sound", {pos = pos, max_hear_distance = 10})
							
							minetest.after(8, function(effect)
								minetest.sound_stop(effect)
								minetest.swap_node(r_pos, {name = "tardis_new:rotor"..style })
								--local ometa = minetest.get_meta(r_pos)
								--ometa:set_string("id", id)
								--ometa:set_string("formspec", get_formspec_r(data:get_int(id.."power")))
								local otimer = minetest.get_node_timer(r_pos)
								otimer:start(15)
								pmeta:set_string("vortex", "no")
							end, effect)
					
							minetest.set_node(out_pos, {name = "air"})
							out_pos.x = data:get_int(id.."x_dest")
							out_pos.y = data:get_int(id.."y_dest")
							out_pos.z = data:get_int(id.."z_dest")
							minetest.set_node(out_pos, {name=look})
							
							out_pos.y = out_pos.y+1
							minetest.set_node(out_pos, {name = "air"})
							out_pos.y = out_pos.y-1
							
							local ometa = minetest.get_meta(out_pos)
							ometa:set_string("id", id)
							data:set_string(id.."out_pos", minetest.serialize(out_pos))
							data:set_int(id.."power", data:get_string(id.."power")-1)
							local timer = minetest.get_node_timer(out_pos)
							timer:start(0.2)
						else minetest.chat_send_player(name, "Your Tardis can not travel outside the world!") end
					end
				end
			else minetest.chat_send_player(name, "Location Obstructed") end
		end
	end
end
local change_look = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local id = meta:get_string("id")
	local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
	if fields.blue then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis"))
		data:set_string(id.."look", "tardis_new:tardis")
	end
	if fields.yellow then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_yellow"))
		data:set_string(id.."look", "tardis_new:tardis_yellow")
	end
	if fields.pink then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_pink"))
		data:set_string(id.."look", "tardis_new:tardis_pink")
	end
	if fields.old then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_old"))
		data:set_string(id.."look", "tardis_new:tardis_old")
	end
	if fields.stone then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_stone"))
		data:set_string(id.."look", "tardis_new:tardis_stone")
	end
	if fields.empty then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_empty"))
		data:set_string(id.."look", "tardis_new:tardis_empty")
	end
	if fields.cool then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_cool"))
		data:set_string(id.."look", "tardis_new:tardis_cool")
	end
	if fields.leave then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_leave"))
		data:set_string(id.."look", "tardis_new:tardis_leave")
	end
	if fields.soda then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_soda"))
		data:set_string(id.."look", "tardis_new:tardis_soda")
	end
	if fields.funky then
		meta:set_string("formspec", get_formspec_c("tardis_new:tardis_funky"))
		data:set_string(id.."look", "tardis_new:tardis_funky")
	end
end
local waypoint = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local id = meta:get_string("id")
	local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
	local way1 = minetest.deserialize(data:get_string(id.."way1"))
	local way2 = minetest.deserialize(data:get_string(id.."way2"))
	local way3 = minetest.deserialize(data:get_string(id.."way3"))
	if fields.set_one then
		data:set_string(id.."way1", minetest.serialize(out_pos))
		local way1 = minetest.deserialize(data:get_string(id.."way1"))
	end
	if fields.use_one  then
		data:set_int(id.."x_dest", way1.x)
		data:set_int(id.."y_dest", way1.y)
		data:set_int(id.."z_dest", way1.z)
	end
	if fields.set_two then
		data:set_string(id.."way2", minetest.serialize(out_pos))
		local way2 = minetest.deserialize(data:get_string(id.."way2"))
	end
	if fields.use_two then
		data:set_int(id.."x_dest", way2.x)
		data:set_int(id.."y_dest", way2.y)
		data:set_int(id.."z_dest", way2.z)
	end
	if fields.set_three then
		data:set_string(id.."way3", minetest.serialize(out_pos))
		local way3 = minetest.deserialize(data:get_string(id.."way3"))
	end
	if fields.use_three then
		data:set_int(id.."x_dest", way3.x)
		data:set_int(id.."y_dest", way3.y)
		data:set_int(id.."z_dest", way3.z)
	end
end
--------------------
--NODE DEFINITIONS--
--------------------
local function register_console_set(set, craftitem, side, ytexture, xtexture, ztexture, ftexture, stexture, wtexture, ctexture, otexture, rotortexture, altrotortexture, ltexture)
minetest.register_node("tardis_new:consle_y"..set, {
		description = "Y-Axis Console Unit",
		tiles = {ytexture, ytexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos) 
				local out_pos = minetest.deserialize(data:get_string(id.."out_pos")) 
				meta:set_string("id", id) 
				meta:set_string("formspec", get_formspec_y(0, out_pos.y)) 
			else minetest.dig_node(pos) end
		end,
		on_rightclick = function(pos, node, clicker, itemstack) 
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
			meta:set_string("formspec", get_formspec_y(data:get_int(id.."y_dest"), out_pos.y))
		end,
		on_receive_fields = general_functions
})
minetest.register_node("tardis_new:consle_x"..set, {
		description = "X-Axis Console Unit",
		tiles = {xtexture, xtexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then 
				local meta = minetest.get_meta(pos)
				local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
				meta:set_string("id", id)
				meta:set_string("formspec", get_formspec_x(0, out_pos.x))
			else minetest.dig_node(pos) end
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
			meta:set_string("formspec", get_formspec_x(data:get_int(id.."x_dest"), out_pos.x))
		end,
		on_receive_fields = general_functions
})
minetest.register_node("tardis_new:consle_z"..set, {
		description = "Z-Axis Console Unit",
		tiles = {ztexture, ztexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos)
				local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
				meta:set_string("id", id)
				meta:set_string("formspec", get_formspec_z(0, out_pos.z))
			else minetest.dig_node(pos) end
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			local out_pos = minetest.deserialize(data:get_string(id.."out_pos"))
			meta:set_string("formspec", get_formspec_z(data:get_int(id.."z_dest"), out_pos.z))
		end,
		on_receive_fields = general_functions
})
minetest.register_node("tardis_new:consle_f"..set, {
		description = "Travel Factor Console Unit",
		tiles = {ftexture, ftexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos)
				meta:set_string("id", id)
				meta:set_string("formspec", get_formspec_f(1))
			else minetest.dig_node(pos) end
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			meta:set_string("formspec", get_formspec_f(data:get_int(id.."factor")))
		end,
		on_receive_fields = general_functions
})
minetest.register_node("tardis_new:consle_s"..set, {
		description = "Functions Console Unit",
		tiles = {stexture, stexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos)
				local id = pmeta:get_string("id")
				meta:set_string("formspec", get_formspec_s())
			else minetest.dig_node(pos) end
		end,
		on_receive_fields = general_functions
})
minetest.register_node("tardis_new:consle_go"..set, {
		description = "Warp Lever Console Unit",
		tiles = {wtexture, wtexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos)
				meta:set_string("id", id)
				meta:set_string("formspec", get_formspec_w())
			else minetest.dig_node(pos) end
		end,
		on_receive_fields = travel_to_location
})
minetest.register_node("tardis_new:consle_c"..set, {
		description = "Exterior Console Unit",
		tiles = {ctexture, ctexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos)
				meta:set_string("id", id)
				meta:set_string("formspec", get_formspec_c("tardis_new:tardis_old"))
			else minetest.dig_node(pos) end
		end,
		on_receive_fields = change_look
})
minetest.register_node("tardis_new:consle_o"..set, {
		description = "Waypoint Console Unit",
		tiles = {otexture, otexture, side, side, side, side},
		groups = {cracky = 3},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos)
				meta:set_string("id", id)
				meta:set_string("formspec", get_formspec_o())
			else minetest.dig_node(pos) end
		end,
		on_receive_fields = waypoint
})
minetest.register_node("tardis_new:rotor"..set, {
		description = "Time Rotor",
		tiles = {rotortexture},
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		light_source = 10,
		groups = {cracky = 1},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			local pmeta = placer:get_meta()
			local id = pmeta:get_string("id")
			local r_pos = minetest.deserialize(data:get_string(id.."r_pos"))
			if r_pos.x+50 > pos.x and r_pos.x-50 < pos.x and r_pos.z+50 > pos.z and r_pos.z-50 < pos.z and r_pos.y+50 > pos.y and r_pos.y-50 < pos.y then
				local meta = minetest.get_meta(pos)
				meta:set_string("id", id)
				meta:set_string("formspec", get_formspec_r(data:get_int(id.."power")))
				meta:set_string("style", set)
				data:set_string(id.."r_pos", minetest.serialize(pos))
				local timer = minetest.get_node_timer(pos)
				timer:start(15)
			else minetest.dig_node(pos) end
		end,
		on_rightclick = function(pos, node, clicker, itemstack)
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			meta:set_string("formspec", get_formspec_r(data:get_int(id.."power")))
		end,
		on_timer = function(pos)
			local meta = minetest.get_meta(pos)
			local id = meta:get_string("id")
			if  data:get_int(id.."power") < 10 then data:set_int(id.."power", data:get_int(id.."power")+1) end
			meta:set_string("formspec", get_formspec_r(data:get_int(id.."power")))
			if data:get_string(id.."r_pos") == minetest.serialize(pos) then return true else return false end
		end
})
minetest.register_node("tardis_new:rotor_active"..set, {
		description = "Time Rotor (active)",
		tiles = { {name = altrotortexture, animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.5}} },
		drawtype = "mesh",
		mesh = "tardis_2.obj",
		selection_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		collision_box = {type = "fixed", fixed = { { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 } }},
		light_source = 12,
		groups = {not_in_creative_inventory = 1},
})
minetest.register_node("tardis_new:light"..set, {
		description = "Tardis Light",
		inventory_image = ltexture,
		drawtype = "signlike",
		paramtype = "light",
		sunlight_propagates = true,
		light_source = minetest.LIGHT_MAX,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {ltexture},
		groups = {oddly_breakable_by_hand = 1}
})
if craftitem == "" then return else
minetest.register_craft({
		output = "tardis_new:consle_y"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_y"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_x"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_x"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_z"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_z"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_c"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_c"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_go"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_go"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_f"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_f"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_o"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_o"}
		}
})
minetest.register_craft({
		output = "tardis_new:consle_s"..set,
		recipe = {
			{craftitem},
			{"tardis_new:consle_s"}
		}
})
minetest.register_craft({
		output = "tardis_new:light"..set,
		recipe = {
			{craftitem},
			{"tardis_new:light"}
		}
})
minetest.register_craft({
		output = "tardis_new:rotor"..set,
		recipe = {
			{craftitem},
			{"tardis_new:rotor"}
		}
})
end
end

register_console_set("", "", "tardis_side_1.png", "y_console_1.png", "x_console_1.png", "z_console_1.png", "f_console_1.png", "s_console_1.png", "w_console_1.png", "c_console_1.png", "o_console_1.png", "rotor_1.png", "alt_rotor_1.png", "tardis_light_1.png")
register_console_set("_2", "group:wood", "tardis_side_2.png", "y_console_2.png", "x_console_2.png", "z_console_2.png", "f_console_2.png", "s_console_2.png", "w_console_2.png", "c_console_2.png", "o_console_2.png", "rotor_2.png", "alt_rotor_2.png", "tardis_light_2.png")
register_console_set("_3", "default:silver_sand", "tardis_side_3.png", "y_console_3.png", "x_console_3.png", "z_console_3.png", "f_console_3.png", "s_console_3.png", "w_console_3.png", "c_console_3.png", "o_console_3.png", "rotor_3.png", "alt_rotor_3.png", "tardis_light_3.png")