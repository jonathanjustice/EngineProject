package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	public class JumpingActor extends SelectableActor{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var xVelocity:Number=0;//velocity
		private var yVelocity:Number = 0;
		private var jumpSpeed:Number = 32;
		private var maxJumpCount:Number = 2;
		private var currentJumpCount:Number = 0;
		private var isJumpingEnabled:Boolean = true;
		
		
		public function JumpingActor(){
			
		}
		
		public function getisJumpingFromInputManager():void {
			if (!isJumpingEnabled) {
				if (Main.keyInputManager.getSpace() == false) {
					isJumpingEnabled = true;
					//trace("NO")
				}
			}
			if(isJumpingEnabled){
				if (Main.keyInputManager.getSpace() == true) {
					jump();
					isJumpingEnabled = false;
					//trace("jump is enabled")
				}
			}
			
		}
		
		//jumping & double jumping
		public function jump():void {
			if (currentJumpCount < maxJumpCount) {
				this.y -= 10;
				resetGravity();
				modifiyGravity(jumpSpeed);
				currentJumpCount++;
				//trace("currentJumpCount", currentJumpCount);
			}
		}
		
		//called when this collides with a floor
		public function jumpingEnded():void {
			//trace("jumpingEnded");
			currentJumpCount = 0;
		}
	}
}