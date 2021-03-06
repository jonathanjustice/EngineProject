﻿package utilities.Actors{
	import utilities.Mathematics.MathFormulas;
	import utilities.Mathematics.QuadTree;
	import utilities.Engine.Game;
	import utilities.Engine.Combat.AnimationManager;
	import utilities.Actors.Actor;
	import utilities.Input.KeyInputManager;
	import utilities.Input.MouseInputManager;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.text.*;

	public class Avatar extends JumpingActor{
		//private var mySprite:Sprite = new Sprite();
		private var myTextField:TextField = new TextField(); 
		private var myAngle:Number=0;
		private var velocityIncrease:Number=12;
		private var maxSpeed:Number=100;
	
		public var xDiff:Number=0;
		public var yDiff:Number = 0;
		private var jumpDamage:int = 1;
		private var invincibilityDamage:int = 5;
		private var isGravitySystemEnabled:Boolean = true;
		
		private var isInvincibilityEnabled:Boolean = false;
		private var isShootingEnabled:Boolean = false;
		
		public function Avatar(){
			setUp();
			//addStroke();
		}
		
		public function setUp():void{
			addActorToGameEngine();
			defineGraphics("frank");
			this.x = 750;
			this.y = 25;
			setHitBoxWidth(100);
			setHitBoxHeight(100);
		}
		
		public function getAvatarLocation():Point{
			var point:Point=new Point(this.x,this.y);
			return point;
		}
		
		public function updateLoop():void {
			if (getIsSwfLoaded() == true) {
				idleLogic();
				getisJumpingFromInputManager();
				applyGravity(isGravitySystemEnabled);
				
				setQuadTreeNode();
				//get key data
				getAnglesFromKeyInputManager();
				
				//get the velocity
				getVelocityFromKeyInputManager();
				//getRotationFromKeyInputManager();
				//apply the velocities to the avatar
				applyVelocities();
				var myPoint:Point = new Point(mouseX,mouseY);
				myPoint = Main.getMouseCoordinates();
				//Point_Actor_At_Target(myPoint);
				
				//trace("thisX: ",this.x,"thisY:",this.y);
				
				
			}
		}
		
		/*public override function Point_Actor_At_Target(target:Point):void{
			MathFormulas.Point_Object_At_Target(this,target);
		}
		*/
		
		public function getAnglesFromKeyInputManager():void{
			this.rotation = Main.keyInputManager.getMyAngle();
		}
		
		public function getVelocityFromKeyInputManager():void{
			Main.keyInputManager.setSimpleVelocityViaKeys();
			
			xVelocity = Main.keyInputManager.getMyVelocityX() * velocityIncrease;
			yVelocity += Main.keyInputManager.getMyVelocityY() * velocityIncrease;
			if (Main.keyInputManager.getMyVelocityX() == 0) {
				xVelocity = 0;
			}
		}
		
		public function getRotationFromKeyInputManager():void{
			//trace(KeyInputManager.getMyRotation());
			trace(this.rotation);
			this.rotation += Main.keyInputManager.getMyRotation();
		}
		
		public function applyVelocities():void{
			this.x += xVelocity;
			this.y += yVelocity;
		}

		//don't set this every frame
		//use only when required
		//get the change in vector
		public function getChangeInPosition():Point{
			var changePoint:Point = new Point(xDiff,yDiff);
			return changePoint;
		}
		
		public override function getActor():MovieClip{
			return this;
		}
		
		public function getJumpDamage():int {
			return jumpDamage;
		}
		
		public function getInvincibilityDamage():int {
			return invincibilityDamage;
		}
		
		public function applyPowerup(type:String):void {
			switch(type) {
				case "shoot":
					isShootingEnabled = true;
					break;
				case "invincible":
					isInvincibilityEnabled = true;
					break;
				case "doubleJump":
					isDoubleJumpingEnabled = true;
					break;
			}
		}
		
		public function idleLogic():void {
			//If running, disable idleing & play run 
			if (xVelocity != 0 && yVelocity == 0) {
				setIsIdle(false);
				setIdleTime(0);
				utilities.Engine.Game.getAnimationManager().updateAnimationState(this, "run");
				//if you are not moving and have not already started idleing, then idle
			}else if (xVelocity == 0 && yVelocity == 0 && isJumping == false && getIdleTime() == 0) {
				utilities.Engine.Game.animationManager.updateAnimationState(this, "idle");
				setIsIdle(true);
			}
			//If idleing, increment idle timer
			if (getIsIdle()==true) {
				setIdleTime((getIdleTime() + 1));
			}
			
			if (getIdleTime() >= getMaxIdleTime()) {
				//if over max idle time, switch to impatient idle
				setIdleImpatientTime((getIdleImpatientTime() + 1));
				if (getIdleImpatientTime() == 1) {
					utilities.Engine.Game.getAnimationManager().updateAnimationState(this,"idleImpatient");
				}
				//if over max idle time, switch to idle
				if (getIdleImpatientTime() == getMaxIdleTime()) {
					utilities.Engine.Game.getAnimationManager().updateAnimationState(this, "idle");
					setIdleImpatientTime(0);
					setIdleTime(0);
				}
			}
		}
	}
}