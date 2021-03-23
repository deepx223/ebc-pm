#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{	
	//[[level.on]]( "spawned", ::AFKMonitor ); // Remove comment for live server
}

AFKMonitor()
{
	level endon ("vote started");
    self endon("disconnect");
	self endon("joined_spectators");
    self endon("game_ended");
	self endon("isKnifing");
	self endon( "inintro" );
	hmmmmm = 0;
	while(isAlive(self))
	{
		ori = self.origin;
		angles = self.angles;
		wait 1;
		if(isAlive(self) && self.sessionteam != "spectator")
		{
			if(self.origin == ori && angles == self.angles)
			{
				hmmmmm++;
			}
			else
			{
				hmmmmm = 0;
			}
			if(hmmmmm == 15)
			{
				self iPrintlnBOld("^7You Appear To Be ^1AFK!");
			}
			if(hmmmmm >= 25)
			{
				if ( self.sessionstate == "playing" && (!isDefined( self.isPlanting ) || !self.isPlanting) && !level.gameEnded && isDefined( self.carryObject ) )
				self.carryObject thread maps\mp\gametypes\_gameobjects::setDropped();
				self.sessionteam = "spectator";
				self.sessionstate = "spectator";
				self [[level.spawnSpectator]]();
				iPrintln("" +self.name + " ^7Appears To Be ^1AFK!");
				return;
			}
		}
		else	
		{
			hmmmmm = 0;
		}
	}
}