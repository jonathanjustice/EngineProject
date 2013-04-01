package utilities.Actors{
	import utilities.Engine.Game;
	import utilities.Mathematics.MathFormulas;
	import utilities.Input.KeyInputManager;
	import flash.utils.getTimer;
	public class AFSEnemy extends Enemy{
		
		//private var gameContainer;
		private var velocityMultiplier:Number=15;
		private var applyXP:Boolean=false;
		private var xpToApply:int=0;
		private var spawnTime:Number;
		private var lifeSpan:Number = 2;//3 seconds
		private var xVelocity:Number=0;//velocity
		private var yVelocity:Number=0;
		
		
		//private var availableForTargeting:Boolean=true;
		
		
		public function AFSEnemy(){
			setUp();
			health=10;
		}
		
		
		
		public override function updateLoop():void{
			setQuadTreeNode();
			applyVector();
			//doStuffToEnemyOverTime();
			checkForDamage();
			checkForDeathFlag();
		}
	}
}