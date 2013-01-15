package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	public class Enemy extends Actor{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var xVelocity:Number=0;//velocity
		private var yVelocity:Number=0;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		public function Enemy(){
			setUp();
			health=10;
		}
		
		public function setUp(){
			addActorToGameEngine();
			defineGraphics();
			//trace(get_availableForTargeting());
		}
		
		public function updateLoop(){
			setQuadTreeNode();
			applyVector();
			//doStuffToEnemyOverTime();
			checkForDamage();
			checkForDeathFlag();
		}
		
		private function applyVector(){
			this.x += xVelocity;
			this.y += yVelocity;
		}
		
		
		

		private function checkForDamage(){
			if(health <= 0){
				markDeathFlag();
			}
		}
		
		
		//direction indicator is useful for determine what direction the enemy is faceing / moving in / shooting in
		//make it invisible if its not being used
		//it's commented out because it't not part of the default graphic anymore
		/*private function set_direction_indicator_visibility(){
			directionIndiactor.visible = false;
		}
		*/
		
		//this records the moment the bullet was created
		 private function setSpawnTime() {
         	spawnTime = getTimer();
			//trace("spawnTime",spawnTime);
        }
		
		public function takeDamage(amount){
			health -= amount;
		}
		
		public function markKillWithXpFlag(){
			markDeathFlag();
			applyXP = true;
		}
		
		public function markDeathWithoutXpFlag(){
			markDeathFlag();
			applyXP = false;
		}
		
		public function get_apply_XP_flag():Boolean{
			return applyXP;
		}
		
		public function get_xpToApply():int{
			return xpToApply;
		}
	}
}