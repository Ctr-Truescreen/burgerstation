/obj/item/weapon/ranged/bullet/pump/shotgun/wood
	name = "12g Civilian Shotgun"
	desc = "Good ol' fashioned shotgun."
	desc_extended = "A classic pump action shotgun with the stock and barrel shortened. Most commonly used by hunters, but has been seen on Security and PMCs on a budget as well."
	icon = 'icons/obj/item/weapons/ranged/shotgun/regular.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 4

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN_SMALL

	size = SIZE_4
	weight = WEIGHT_3

	value = 80

	heat_per_shot = 0.03
	heat_max = 0.12

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_base_spread()
	return 0.08

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_static_spread() //Base spread
	return 0.002

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.025 - (0.01 * L.get_skill_power(SKILL_RANGED)))