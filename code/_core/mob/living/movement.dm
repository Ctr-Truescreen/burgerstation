/mob/living/proc/handle_footsteps(var/turf/T,var/list/footsteps_to_use,var/enter=TRUE)

	if(!T)
		return FALSE

	if(enter)
		CALLBACK("enter_footstep_\ref[src]", TICKS_TO_DECISECONDS(next_move)*0.5, src, .proc/do_footstep, T, footsteps_to_use)
		return FALSE

	do_footstep(T,footsteps_to_use,enter)

	return TRUE

/mob/living/proc/do_footstep(var/turf/T,var/list/footsteps_to_use,var/enter=TRUE)

	footstep_counter = (footstep_counter + 1) % footstep_mod

	if(!footstep_counter)
		footstep_left_right_counter = !footstep_left_right_counter

	for(var/k in footsteps_to_use)
		if(!k)
			continue
		var/footstep/F = SSfootstep.all_footsteps[k]
		if(!footstep_counter)
			var/footstep_volume = 50 * (move_mod-0.5)
			if(is_sneaking)
				footstep_volume *= 0.5

			var/footstep_sound
			if(horizontal)
				if(length(F.drag_sounds))
					footstep_sound = pick(F.drag_sounds)
			else
				if(length(F.footstep_sounds))
					footstep_sound = pick(F.footstep_sounds)

			if(footstep_sound)
				play_sound(footstep_sound, T, volume = footstep_volume, sound_setting = SOUND_SETTING_FOOTSTEPS, pitch = 1 + RAND_PRECISE(-F.variation_pitch,F.variation_pitch),range_max=VIEW_RANGE)

	return TRUE


/mob/living/proc/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps

/mob/living/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	if(intent == INTENT_HARM || attack_flags & CONTROL_MOD_BLOCK || (client && client.is_zoomed))
		Dir = 0x0

	. = ..()

/mob/living/post_move(var/atom/old_loc)

	. = ..()

	var/turf/current_loc_as_turf = get_turf(src)
	if(chat_overlay)
		chat_overlay.glide_size = src.glide_size
		chat_overlay.force_move(current_loc_as_turf)
	if(alert_overlay)
		alert_overlay.glide_size = src.glide_size
		alert_overlay.force_move(current_loc_as_turf)
	if(fire_overlay)
		fire_overlay.glide_size = src.glide_size
		fire_overlay.force_move(current_loc_as_turf)
	if(shield_overlay)
		shield_overlay.glide_size = src.glide_size
		shield_overlay.force_move(current_loc_as_turf)

	if(is_sneaking)
		on_sneak()

	if(old_turf && length(old_turf.old_living))
		old_turf.old_living -= src

	if(isturf(old_loc) && !qdeleting)
		var/turf/T = old_loc
		if(!T.old_living)
			T.old_living = list()
		T.old_living |= src
		src.old_turf = T
		if(is_simulated(old_loc) && !horizontal && move_mod > 1)
			var/turf/simulated/S = T
			var/slip_strength = S.get_slip_strength(src)
			if(slip_strength >= 4 - move_mod)
				var/obj/item/wet_floor_sign/WFS = locate() in range(1,S)
				if(!WFS || move_mod > 2)
					add_status_effect(SLIP,slip_strength*10,slip_strength*10)

	handle_tabled()

	last_move_delay = TICKS_TO_DECISECONDS(next_move)
	last_move_time = world.time

/mob/living/Bump(atom/Obstacle)
	if(ai) ai.Bump(Obstacle)
	. = ..()

/mob/living/proc/can_move()

	if(dead)
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAGGER,STUN,PARRIED))
		return FALSE

	if(buckled_object && !buckled_object.unbuckle(src))
		return FALSE

	return TRUE

/mob/living/on_sprint()
	add_hydration(-0.4)
	if(client)
		add_attribute_xp(ATTRIBUTE_AGILITY,1)
	return ..()

/mob/living/on_jog()
	add_hydration(-0.1)
	return ..()

/mob/living/handle_movement(var/adjust_delay = 1)

	if(dash_target && dash_target.loc && dash_amount > 0 && !horizontal && can_move() && isturf(src.loc)) //can_move dose not consider delays.
		var/final_direction = get_dir_advanced(src,dash_target)
		if(!final_direction)
			dash_amount = 0
			return TRUE
		glide_size = step_size/adjust_delay
		src.set_dir(final_direction)
		if(!Move(get_step(src,final_direction)))
			dash_amount = 0
		else
			dash_amount--
		return TRUE
	else
		dash_amount = 0
		dash_target = null

	if(move_dir) //If you're actuall moving.
		if(!can_move())
			return FALSE
		if(grabbing_hand)
			resist()
			return FALSE
		if(get_status_effect_magnitude(SLEEP) == -1)
			remove_status_effect(SLEEP)
			return FALSE

	. = ..()

/mob/living/get_stance_movement_mul()

	if(horizontal)
		return walk_delay_mul*2

	. = ..()

/mob/living/get_movement_delay(var/include_stance=TRUE)

	. = ..()

	if(is_sneaking)
		. *= max(2 - stealth_mod*0.5,1)

	if(ckey_last)
		. *= 2 - min(1.5,get_nutrition_mod() * get_hydration_mod() * (0.5 + get_nutrition_quality_mod()*0.5))

	if(intoxication)
		. += intoxication*0.003

	var/trait/speed/S = get_trait_by_category(/trait/speed/)
	if(S) . *= S.move_delay_mul

	if(has_status_effect(SLOW))
		. *= 2

	if(!horizontal)
		. *= max(1.25 - get_attribute_power(ATTRIBUTE_AGILITY)*0.25,0.75)

/mob/living/proc/toggle_sneak(var/on = TRUE)

	for(var/k in buttons)
		var/obj/hud/button/B = k
		if(B.type == /obj/hud/button/sneak)
			var/obj/hud/button/sneak/S = B
			S.sneaking = on
			S.update_sprite()

	if(on && !dead)
		stealth_mod = get_skill_power(SKILL_SURVIVAL,0,1,2)
		is_sneaking = TRUE
		return TRUE
	else
		is_sneaking = FALSE
		return FALSE

/mob/living/proc/on_sneak()
	return TRUE

/mob/living/Cross(atom/movable/O,atom/oldloc)

	if(is_living(O) && O.density) //A living being is crossing us.
		var/mob/living/L = O
		if(L.horizontal || src.horizontal)
			//If the crosser is horizontal, or the src is horizontal, you can cross.
			return TRUE
		if((!L.ai || !src.ai))
			if(allow_helpful_action(L.loyalty_tag,src.loyalty_tag)) //If the crosser is not an AI and we're on the same team, allow it.
				return TRUE
		if(L.size >= SIZE_ANIMAL)
			//Can't cross bud. You're an AI. No AI clogging.
			return FALSE

	. = ..()


/mob/living/on_thrown(var/atom/owner,var/atom/hit_atom,var/atom/hit_wall) //What happens after the person is thrown.

	if(!has_status_effects(STUN,STAGGER,PARALYZE))
		if(hit_wall)
			add_status_effect(STUN,10,10,source = owner)
		else
			add_status_effect(STAGGER,5,5,source = owner)

	return ..()

/mob/living/proc/handle_tabled()

	climb_counter = 0

	if(tabled != currently_tabled)
		currently_tabled = tabled
		if(currently_tabled)
			animate(src, pixel_z = initial(pixel_z) + 10, time = 10, easing = CIRCULAR_EASING | EASE_OUT)
			next_move = max(DECISECONDS_TO_TICKS(10),next_move)
		else
			animate(src, pixel_z = initial(pixel_z), time = 5, easing = CIRCULAR_EASING | EASE_OUT)
			next_move = max(DECISECONDS_TO_TICKS(5),next_move)

	return TRUE

/mob/living/throw_self(var/atom/thrower,var/atom/desired_target,var/target_x,var/target_y,var/vel_x,var/vel_y,var/lifetime = -1, var/steps_allowed = 0,var/desired_loyalty_tag)

	if(buckled_object)
		return null

	. = ..()