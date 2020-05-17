/client/proc/update_verbs()
	CLEAR_VERBS(src)
	add_inherent_verbs()
	if(mob)
		CLEAR_VERBS(mob)
		mob.add_inherent_verbs()
	return TRUE

/client/proc/add_inherent_verbs()
	verbs += /client/verb/ooc
	verbs += /client/verb/toggle_focus
	verbs += /client/verb/focus_map
	verbs += /client/verb/focus_input
	verbs += /client/verb/button_press
	verbs += /client/verb/button_release
	verbs += /client/verb/toggle_fullscreen
	verbs += /client/verb/change_click_mode
	verbs += /client/verb/set_volume_master
	verbs += /client/verb/set_volume_fx
	verbs += /client/verb/set_volume_ambient
	verbs += /client/verb/set_volume_music
	verbs += /client/verb/set_volume_footsteps
	verbs += /client/verb/ghost
	verbs += /client/verb/edit_macros
	verbs += /client/verb/set_fps
	verbs += /client/verb/open_discord
	verbs += /client/verb/open_github

	if(ENABLE_ATMOS)
		verbs += /client/verb/air_test
	if(ckey == "burgerbb")
		verbs += /client/verb/add_new_wikibot_entry
		verbs += /client/verb/rtv
		verbs += /client/verb/trigger_shutdown
		verbs += /client/verb/get_threat_level
		verbs += /client/verb/get_enemies_to_spawn

	return TRUE

/client/verb/open_discord()
	set name = "Open Discord"
	set hidden = TRUE
	src << run("https://discord.gg/yEaV92a")

/client/verb/open_github()
	set name = "Open Github"
	set hidden = TRUE
	src << run("https://github.com/BurgerLUA/burgerstation")

