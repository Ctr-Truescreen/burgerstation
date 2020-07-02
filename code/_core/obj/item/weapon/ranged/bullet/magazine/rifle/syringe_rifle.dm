/obj/item/weapon/ranged/bullet/magazine/rifle/syringe
	name = "\improper syringe rifle"
	icon = 'icons/obj/item/weapons/ranged/misc/syringe.dmi'
	desc = "Long distance Poisoning"
	desc_extended = "In the older days, poisoners had to rely on clever tricks, distraction and sleight-of-hand in order to poison their enemies. Luckily, we live in gentler times, so now you can just shoot em with poison syringes."
	icon_state = "inventory"

	shoot_delay = 8

	automatic = FALSE

	shoot_sounds = list('sound/weapons/silenced/fire.ogg')

	can_wield = FALSE

	view_punch = 1

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_3
	weight = WEIGHT_4

	override_icon_state = TRUE

	heat_per_shot = 0.01
	heat_max = 0.03

	bullet_length_min = 18.5
	bullet_length_best = 18.5
	bullet_length_max = 18.5

	bullet_diameter_min = 18.5
	bullet_diameter_best = 18.5
	bullet_diameter_max = 18.5

	size = SIZE_3
	weight = WEIGHT_3

	value = 150

	ai_heat_sensitivity = 2

	shoot_alert = ALERT_LEVEL_NONE

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/stored_bullets = length(M.stored_bullets)
		if(stored_bullets == 1)
			icon_state = "[initial(icon_state)]_[round(stored_bullets,1)]"
		else
			icon_state = "[initial(icon_state)]_[round(stored_bullets,2)]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/syringe/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))
