#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init(){ level thread vending_additionalprimaryweapon_fix(); }

vending_additionalprimaryweapon_fix()
{
	level thread additionalprimaryweapon_disable();
    level thread additionalprimaryweapon_locations();
	level thread additionalprimaryweapon_spawn();
}

additionalprimaryweapon_locations()
{
	switch( level.script )
	{
	case "zombie_theater":
		level.zombie_additionalprimaryweapon_machine_origin = (1172.4, -359.7, 320);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (1160, -360, 448);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
		break;
	case "zombie_pentagon":
		level.zombie_additionalprimaryweapon_machine_origin = (-1081.4, 1496.9, -512);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 162.2, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (-1084, 1489, -448);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 341.4, 0);
		break;
	case "zombie_cosmodrome":
		level.zombie_additionalprimaryweapon_machine_origin = (420.8, 1359.1, 55);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 270, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (436, 1359, 177);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);

		level.zombie_additionalprimaryweapon_machine_monkey_angles = (0, 0, 0);
		level.zombie_additionalprimaryweapon_machine_monkey_origins = [];
		level.zombie_additionalprimaryweapon_machine_monkey_origins[0] = (398.8, 1398.6, 60);
		level.zombie_additionalprimaryweapon_machine_monkey_origins[1] = (380.8, 1358.6, 60);
		level.zombie_additionalprimaryweapon_machine_monkey_origins[2] = (398.8, 1318.6, 60);
		break;
	case "zombie_coast":
		level.zombie_additionalprimaryweapon_machine_origin = (2424.4, -2884.3, 314);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 231.6, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (2435, -2893, 439);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 322.2, 0);
		break;
	case "zombie_temple":
		level.zombie_additionalprimaryweapon_machine_origin = (-1352.9, -1437.2, -485);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 297.8, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (-1342, -1431, -361);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 28.8, 0);
		break;
	case "zombie_moon":
		level.zombie_additionalprimaryweapon_machine_origin = (1480.8, 3450, -65);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 180, 0);
		break;
	case "zombie_cod5_prototype":
		level.zombie_additionalprimaryweapon_machine_origin = (-160, -528, 1);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 0, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (-162, -517, 17);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
		break;
	case "zombie_cod5_asylum":
		level.zombie_additionalprimaryweapon_machine_origin = (-91, 540, 64);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (-103, 540, 92);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
		break;
	case "zombie_cod5_sumpf":
		level.zombie_additionalprimaryweapon_machine_origin = (9565, 327, -529);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (9555, 327, -402);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
		break;
	case "zombie_cod5_factory":
		level.zombie_additionalprimaryweapon_machine_origin = (-1089, -1366, 67);
		level.zombie_additionalprimaryweapon_machine_angles = (0, 90, 0);
		level.zombie_additionalprimaryweapon_machine_clip_origin = (-1100, -1365, 70);
		level.zombie_additionalprimaryweapon_machine_clip_angles = (0, 0, 0);
		break;
	}
}

additionalprimaryweapon_spawn()
{
	level.zombiemode_using_additionalprimaryweapon_perk = true;
	cost = 4000;

	machine_clip = spawn( "script_model", level.zombie_additionalprimaryweapon_machine_clip_origin );
	machine_clip.angles = level.zombie_additionalprimaryweapon_machine_clip_angles;
	machine_clip setmodel( "collision_geo_64x64x256" );
	machine_clip Hide();

	machine = Spawn( "script_model", level.zombie_additionalprimaryweapon_machine_origin );
	machine.angles = level.zombie_additionalprimaryweapon_machine_angles;
	machine setModel( "zombie_vending_three_gun" );
	machine.targetname = "vending_additionalprimaryweapon";

	machine_trigger = Spawn( "trigger_radius", level.zombie_additionalprimaryweapon_machine_origin + (0, 0, 30), 0, 30, 70 );
	machine_trigger SetCursorHint( "HINT_NOICON" );
	machine_trigger SetHintString( &"ZOMBIE_NEED_POWER" );

	if( "zombie_cod5_prototype" != level.script && "zombie_cod5_sumpf" != level.script )
	{
		level flag_wait( "power_on" );
	}

	machine setmodel("zombie_vending_three_gun_on");
	machine vibrate((0,-100,0), 0.3, 0.4, 3);
	machine playsound("zmb_perks_power_on");
	machine thread maps\_zombiemode_perks::perk_fx( "additionalprimaryweapon_light" );

	machine_trigger	SetHintString( &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", cost );
	machine_trigger thread vending_mule_kick(cost);
}

vending_mule_kick(cost)
{
	for(;;)
	{
		self waittill("trigger", player);

		is_not_poor = (player.score >= cost);

		if(player useButtonPressed())
		{
			while( player UseButtonPressed() )
			{
				wait 0.05;
			}

			if(!player hasPerk("specialty_additionalprimaryweapon") && is_not_poor && player.num_perks < 4)
			{
				playsoundatposition("evt_bottle_dispense", player.origin);
				player maps\_zombiemode_score::minus_to_player_score( cost );

				player.perk_purchased = "specialty_additionalprimaryweapon";
				player thread maps\_zombiemode_audio::play_jingle_or_stinger("mus_perks_mulekick_sting");

				gun = player maps\_zombiemode_perks::perk_give_bottle_begin( "specialty_additionalprimaryweapon" );
				player waittill_any( "fake_death", "death", "player_downed", "weapon_change_complete" );
				player maps\_zombiemode_perks::perk_give_bottle_end( gun, "specialty_additionalprimaryweapon" );
				
				if ( player maps\_laststand::player_is_in_laststand() || is_true( player.intermission ) )
				{
					continue;
				}

				if ( isDefined( level.perk_bought_func ) )
				{
					player [[ level.perk_bought_func ]]( "specialty_additionalprimaryweapon" );
				}
				player.perk_purchased = undefined;
				player maps\_zombiemode_perks::give_perk( "specialty_additionalprimaryweapon", true );
			}
			else
			{
				player playsound("evt_perk_deny");
			}
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This dvar disables mule kick on servers. Regardless having this on, mule kick will only spawn after first map rotation, which is very inconsistent! //
// This ensures it will never spawn to prevent inconsistency and to make sure it doesn't interupt this mod...so DO NOT TURN THIS DVAR ON! You will     //
// have double mule kicks and upon a player trigger, it will DUPE the purchase and have 2 mule kick icons in your hud!                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
additionalprimaryweapon_disable()
{
	setDvar("scr_zm_extra_perk_all", 0);
}