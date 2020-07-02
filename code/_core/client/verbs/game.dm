/client/verb/ghost()
	set name = "Ghost"
	set desc = "Abandon your body and become a ghost."
	set category = "Game"

	if(is_player(mob))
		var/mob/living/advanced/player/P = mob
		if(P.allow_save)
			var/obj/structure/interactive/bed/sleeper/S = locate() in P.loc.contents
			var/in_sleeper = istype(S,/obj/structure/interactive/bed/sleeper/backup) || istype(S,/obj/structure/interactive/bed/sleeper/cryo)
			if(in_sleeper)
				var/choice = input("Are you sure you want to save your character and cryo? You will no longer be able to be rejoin the round as this character.","Cryogenics","No") in list("Yes","No") | null
				if(choice == "Yes")
					var/savedata/client/mob/mobdata = MOBDATA(ckey)
					if(mobdata)
						mobdata.save_character(P)
					qdel(P)
					make_ghost(S.loc)
					return TRUE
				return FALSE

	if(!mob || !is_living(mob))
		to_chat("You have no body to abandon!")
		return FALSE

	var/mob/living/L = mob

	if(!L.dead)
		to_chat("You can't abandon your body while alive!")
		return FALSE

	var/choice = input("Are you sure you want to abandon your body and become a ghost? You will no longer be able to be revived.","Abandon Body","No") in list("Yes","No") | null
	if(choice == "Yes")
		make_ghost(mob.loc)
		to_chat("You abandon your body...")
		return TRUE


	return FALSE

/client/verb/stop_sound()
	set name = "Stop Sounds"
	set category = "Game"
	mob << sound(null)
	to_chat("All sounds have been stopped.")