﻿package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import flash.utils.getTimer;
	public class Powerup_doubleJump extends Powerup_default{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		public function Powerup_doubleJump() {
			health=1;
		}
		
		public override function setUp():void {
			addActorToGameEngine();
			health=1;
			defineGraphics("powerup_doubleJump");
			powerupType = "doubleJump";
		}
		
		public override function updateLoop():void {
		
		}
	}
}