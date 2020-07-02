/obj/item/bullet_cartridge/rifle_308
	name = "\improper .308 rifle bullet"
	desc = "For rifles that require .308."
	icon = 'icons/obj/item/bullet/762.dmi'


	bullet_diameter = 7.62
	bullet_length = 51
	bullet_color = COLOR_BULLET

	item_count_max = 5
	item_count_max_icon = 5
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_308

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY

	size = 0.04
	weight = 0.04

	value = 0.7

	inaccuracy_modifer = 0.75

/obj/item/bullet_cartridge/rifle_308/Generate()
	item_count_current = 5
	return ..()

/obj/item/bullet_cartridge/rifle_308/nato
	name = "\improper 7.62mm rifle bullet"
	desc = "For rifles that require 7.62mm"
	icon = 'icons/obj/item/bullet/762.dmi'
	damage_type_bullet = /damagetype/ranged/bullet/rifle_762mm


/obj/item/bullet_cartridge/rifle_308/short
	name = "\improper 7.62x39mm Soviet rifle bullet"
	desc = "For soviet rifles that require 7.62x39mm"
	icon = 'icons/obj/item/bullet/762_short.dmi'
	damage_type_bullet = /damagetype/ranged/bullet/rifle_762mm/short

	bullet_length = 39

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY*0.9

/obj/item/bullet_cartridge/rifle_308/long
	name = "\improper 7.62mm rifle bullet"
	desc = "For rifles that require 7.62mmx54mmR"
	icon = 'icons/obj/item/bullet/762.dmi'
	damage_type_bullet = /damagetype/ranged/bullet/rifle_762mm/long

	bullet_length = 54


/obj/item/bullet_cartridge/rifle_223
	name = "\improper .223 rifle bullet"
	desc = "For rifles and machineguns that requre .223."
	icon = 'icons/obj/item/bullet/223.dmi'


	bullet_diameter = 5.56
	bullet_length = 45
	bullet_color = COLOR_BULLET

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_223

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	size = 0.03
	weight = 0.03

	value = 0.4

/obj/item/bullet_cartridge/rifle_223/nato
	name = "\improper 5.56mm rifle bullet"
	desc = "For rifles and machineguns that requre 5,56mm."

	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

/obj/item/bullet_cartridge/rifle_545mm
	name = "\improper 5.45mm rifle bullet"
	desc = "For rifles and machineguns that requre 5,45mm."
	icon = 'icons/obj/item/bullet/223.dmi'

	bullet_diameter = 5.45
	bullet_length = 39
	bullet_color = COLOR_BULLET


	item_count_max = 5
	item_count_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_545mm

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT