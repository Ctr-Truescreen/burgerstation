/obj/hud/examine
	name = "examine effect"

	icon = 'icons/hud/new.dmi'
	icon_state = "none"

	layer = LAYER_HUD
	plane = PLANE_HUD
	mouse_opacity = 0

	screen_loc = "CENTER,CENTER"

	alpha = 0

	user_colors = FALSE

	maptext = "Nothing"
	maptext_width = TILE_SIZE*5
	maptext_height = TILE_SIZE*2

/obj/hud/examine/New(var/desired_loc)

	if(ismob(desired_loc))
		screen_loc = "CENTER,CENTER"
		loc = desired_loc
		var/mob/ME = desired_loc
		if(ME.client)
			ME.client.screen += src

	..()