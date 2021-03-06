﻿package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	public class TankEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
	//	private var xVelocity:Number=5;//velocity
	//	private var yVelocity:Number=0;
		private var isGravitySystemEnabled:Boolean = true;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		public function TankEnemy() {
			xVelocity = -5;
			setUp();
			health = 2;
			maximumHealth = 2;
			defineGraphics("tank");
		}
		
		public override function updateLoop():void {
			//walk();
			applyGravity(isGravitySystemEnabled);
			//trace("AFS Enemy update loop");
			setQuadTreeNode();
			applyVector();
			//doStuffToEnemyOverTime();
			checkForDamage();
			checkForDeathFlag();
			rechargeHealth();
		}
		
		public function walk():void {
			//	this.x -= xVelocity;
		}
		
		public override function applyVector():void {
			if (!getIsVulnerable()) {	
				this.x += xVelocity;
				this.y += yVelocity;
			}
		}
		
	}
}